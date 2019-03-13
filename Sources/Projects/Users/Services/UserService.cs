namespace Users.Services
{
    using Microsoft.Extensions.Caching.Memory;
    using Microsoft.IdentityModel.Tokens;
    using System;
    using System.IdentityModel.Tokens.Jwt;
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
    using Users.Extensions;

    public class UserService : IUserService
    {
        private readonly IUserRepository _userRepository;
        private readonly IAccountRoleRepository _accountRoleRepository;

        private readonly JwtSetting _jwtSetting;
        private readonly CacheSetting _cacheSetting;
        private readonly IMemoryCache _memoryCache;

        private User _currentUser;

        private CacheList<User> _userCacheList;

        public UserService(
            IUserRepository userRepository,
            IAccountRoleRepository accountRoleRepository,
            IOptions<JwtSetting> jwtSetting,
            IOptions<CacheSetting> cacheSetting,
            IMemoryCache memoryCache)
        {
            _userRepository = userRepository;
            _accountRoleRepository = accountRoleRepository;

            _jwtSetting = jwtSetting.Value;
            _cacheSetting = cacheSetting.Value;
            _memoryCache = memoryCache;

            _userCacheList = new CacheList<User>(
                _memoryCache,
                _userRepository.UsersWithoutPasswords,
                CacheKeys.Users.UsersItems,
                _cacheSetting.ExpireMinutes);
        }

        public IEnumerable<User> Users => _userCacheList.GetValues();

        public User CurrentUser => _currentUser;

        public UserShort LogIn(
            string userName,
            string password)
        {
            _currentUser = GetUser(userName, password);

            if (_currentUser == null)
            {
                return null;
            }

            List<Claim> claims = GetClaimsDefault(_currentUser.UserId);

            string userRole = GetUserRole();

            if (!string.IsNullOrEmpty(userRole))
            {
                claims.Add(GetClaimRoleType(userRole));
            }

            return GetUserShort(_currentUser, GetJWTToken(claims));
        }

        public void LogOut()
        {
            _currentUser = null;
        }

        public string GetUserRole()
        {
            if (_currentUser.AccountId.HasValue)
            {
                AccountRole accountRole = _accountRoleRepository.GetByAccount(
                    _currentUser.AccountId.Value);

                if ((accountRole != null) && (accountRole.RoleType.HasValue))
                {
                    return accountRole.RoleType.GetDescription();
                }
            }

            return string.Empty;
        }

        private string GetJWTToken(List<Claim> claims)
        {
            var tokenHandler = new JwtSecurityTokenHandler();

            return tokenHandler.WriteToken(
                tokenHandler.CreateToken(
                    new SecurityTokenDescriptor
                    {
                        Subject = new ClaimsIdentity(claims),
                        Expires = DateTime.UtcNow.AddDays(_jwtSetting.ExpireDays),
                        SigningCredentials = new SigningCredentials(
                            new SymmetricSecurityKey(Encoding.ASCII.GetBytes(_jwtSetting.Key)),
                            SecurityAlgorithms.HmacSha256Signature)
            }));
        }

        private User GetUser(
            string userName, 
            string password)
        {
            User user = _userRepository.Get(userName);

            if (user == null)
            {
                return null;
            }

            if (user.PasswordSalt.Equals(password))
            {
                return user;
            }

            return null;
        }

        private UserShort GetUserShort(
            User user,
            string token) =>
            new UserShort()
            {
                UserId = user.UserId,
                UserName = user.LogonName,
                FirstName = user.FirstName,
                LastName = user.LastName,
                Token = token
            };

        private List<Claim> GetClaimsDefault(int userId)
        {
            return new List<Claim>
            {
                new Claim(ClaimsIdentity.DefaultNameClaimType, userId.ToString())
            };
        }

        private Claim GetClaimRoleType(string roleType)
        {
            return new Claim(ClaimsIdentity.DefaultRoleClaimType, roleType);
        }
    }
}