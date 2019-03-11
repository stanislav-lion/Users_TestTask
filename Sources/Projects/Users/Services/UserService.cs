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
    using Users.AppSettings;
    using System.Collections.Generic;
    using Microsoft.Extensions.Options;

    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;
        private readonly IMemoryCache _memoryCache;
        private readonly JwtSettings _jwtSettings;
        private readonly AppSettings _appSettings;

        private readonly CacheList<User> _userCacheList;

        public UserService(
            IUserRepository userRepository,
            IMemoryCache memoryCache,
            IOptions<JwtSettings> jwtSettings,
            IOptions<AppSettings> appSettings)
        {
            _userRepository = userRepository;
            _memoryCache = memoryCache;
            _jwtSettings = jwtSettings.Value;
            _appSettings = appSettings.Value;

            _userCacheList = new CacheList<User>(
                _memoryCache,
                _userRepository.Users,
                CacheKeys.Users.UsersItems,
                _appSettings.CacheExpirationAddMinutes);
        }

        public IEnumerable<User> Users => _userCacheList.GetValues();

        public UserShort Authenticate(string userName, string password)
        {
            User user = Users.FirstOrDefault(u =>
                u.LogonName.Equals(userName) && u.PasswordSalt.Equals(password));

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
                Expires = DateTime.UtcNow.AddDays(_jwtSettings.ExpireDays),
                SigningCredentials = new SigningCredentials(
                    new SymmetricSecurityKey(Encoding.ASCII.GetBytes(_jwtSettings.Key)),
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
    }
}