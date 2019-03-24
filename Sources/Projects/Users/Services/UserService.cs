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
    using Users.CustomAttributes;

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

        public virtual IEnumerable<User> Users => _userCacheList.GetValues();

        public virtual User CurrentUser => _currentUser;

        public virtual User CurrentUserWithoutPasswords => GetUserWithoutPasswords();

        [ReplaceChars(OldValue = '_', NewValue = ' ')]
        public virtual string CurrentUserRole => GetCurrentUserRole();

        public UserShort Register(
            string userName, 
            string password)
        {
            _currentUser = CreateUser(userName, password);

            if (_currentUser == null)
            {
                return null;
            }

            return GetUserShort(_currentUser,
                Token.GetJWTToken(
                    GetClaimsDefault(_currentUser.UserId),
                    _jwtSetting.Key,
                    _jwtSetting.ExpireDays));

        }

        public UserShort LogIn(
            string userName,
            string password)
        {
            _currentUser = GetUser(userName.Trim(), password.Trim());

            if (_currentUser == null)
            {
                return null;
            }

            List<Claim> claims = GetClaimsDefault(_currentUser.UserId);

            string userRole = GetCurrentUserRole();

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
    }
}