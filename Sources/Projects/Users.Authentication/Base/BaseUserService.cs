namespace Users.Authentication.Base
{
    using System.Collections.Generic;
    using System.Security.Claims;
    using Users.Authentication.Models;
    using Users.DataAccess.DataModel.Extensions;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository;

    public abstract class BaseUserService
    {
        protected readonly IUserRepository _userRepository;
        protected readonly IAccountRoleRepository _accountRoleRepository;

        protected static User _currentUser;

        protected BaseUserService(
            IUserRepository userRepository,
            IAccountRoleRepository accountRoleRepository)
        {
            _userRepository = userRepository;
            _accountRoleRepository = accountRoleRepository;
        }

        protected User CreateUser(
            string userName,
            string password)
        {
            var user = new User()
            {
                LogonName = userName,
                PasswordSalt = password
            };

            _userRepository.Upsert(new User()
            {
                LogonName = userName,
                PasswordSalt = password
            });

            return user;
        }

        protected User GetUser(
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

        protected string GetCurrentUserRole()
        {
            if ((_currentUser != null) &&
                (_currentUser.AccountId.HasValue))
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

        protected UserShort GetUserShort(
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

        protected List<Claim> GetClaimsDefault(int userId)
        {
            return new List<Claim>
            {
                new Claim(ClaimsIdentity.DefaultNameClaimType, userId.ToString())
            };
        }

        protected Claim GetClaimRoleType(string roleType)
        {
            return new Claim(ClaimsIdentity.DefaultRoleClaimType, roleType);
        }
    }
}