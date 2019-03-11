namespace Users.Services
{
    using Microsoft.Extensions.Caching.Memory;
    using Microsoft.IdentityModel.Tokens;
    using System;
    using System.IdentityModel.Tokens.Jwt;
    using System.Linq;
    using System.Security.Claims;
    using System.Text;
    using Users.Authentication.Interfaces;
    using Users.Authentication.Models;
    using Users.Cache;
    using Users.CommonNames;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository;
    using System.Collections.Generic;
    using Microsoft.Extensions.Options;
    using Users.Authentication.AppSettings;
    using Users.Cache.AppSettings;

    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;
        private readonly IMemoryCache _memoryCache;
        private readonly JwtSetting _jwtSetting;
        private readonly CacheSetting _cacheSetting;

        private readonly CacheList<User> _userCacheList;

        public UserService(
            IUserRepository userRepository,
            IMemoryCache memoryCache,
            IOptions<JwtSetting> jwtSetting,
            IOptions<CacheSetting> cacheSetting)
        {
            _userRepository = userRepository;
            _memoryCache = memoryCache;
            _jwtSetting = jwtSetting.Value;
            _cacheSetting = cacheSetting.Value;

            _userCacheList = new CacheList<User>(
                _memoryCache,
                _userRepository.UsersWithoutPasswords,
                CacheKeys.Users.UsersItems,
                _cacheSetting.ExpireMinutes);
        }

        public IEnumerable<User> Users => _userCacheList.GetValues();

        public UserShort Authenticate(string userName, string password)
        {
            User user = GetUser(userName, password);

            if (user == null)
            {
                return null;
            }

            // Authentication successful so generate JWT token.
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Name, user.UserId.ToString())
                }),
                Expires = DateTime.UtcNow.AddDays(_jwtSetting.ExpireDays),
                SigningCredentials = new SigningCredentials(
                    new SymmetricSecurityKey(Encoding.ASCII.GetBytes(_jwtSetting.Key)),
                    SecurityAlgorithms.HmacSha256Signature)
            };

            var tokenHandler = new JwtSecurityTokenHandler();

            return new UserShort()
            {
                UserId = user.UserId,
                UserName = user.LogonName,
                FirstName = user.FirstName,
                LastName = user.LastName,
                Token = tokenHandler.WriteToken(tokenHandler.CreateToken(tokenDescriptor))
            };
        }

        private User GetUser(string userName, string password)
        {
            return _userRepository.Users
                .FirstOrDefault(user =>
                    user.LogonName.Equals(userName) &&
                    user.PasswordSalt.Equals(password));
        }
    }
}