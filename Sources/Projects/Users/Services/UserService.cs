namespace Users.Services
{
    using Microsoft.Extensions.Caching.Memory;
    using System.Security.Claims;
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
    using Users.Authentication.Base;
    using Users.Authentication.Tokens;

    public class UserService : BaseUserService, IUserService
    {
        private readonly JwtSetting _jwtSetting;
        private readonly CacheSetting _cacheSetting;
        private readonly IMemoryCache _memoryCache;

        private CacheList<User> _userCacheList;

        public UserService(
            IUserRepository userRepository,
            IAccountRoleRepository accountRoleRepository,
            IOptions<JwtSetting> jwtSetting,
            IOptions<CacheSetting> cacheSetting,
            IMemoryCache memoryCache)
            : base(
                userRepository,
                accountRoleRepository)
        {
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

            return GetUserShort(_currentUser,
                Token.GetJWTToken(
                    claims,
                    _jwtSetting.Key,
                    _jwtSetting.ExpireDays));
        }

        public void LogOut()
        {
            _currentUser = null;
        }

        public new string GetUserRole()
        {
            return base.GetUserRole();
        }
    }
}