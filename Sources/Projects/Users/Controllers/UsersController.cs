namespace Users.Controllers
{
    using System.Collections.Generic;
    using Microsoft.AspNetCore.Mvc;
    using Users.DataAccess.Repository;

    [Route("api/[controller]")]
    [ApiController]
    public class UsersController : Controller
    {
        private readonly IUserRepository _userRepository;
        private readonly IUserRoleRepository _userRoleRepository;
        private readonly IAccountRepository _accountRepository;
        private readonly IAccountRoleRepository _accountRoleRepository;
        private readonly IAccountAddressRepository _accountAddressRepository;

        public UsersController(
            IUserRepository userRepository,
            IUserRoleRepository userRoleRepository,
            IAccountRepository accountRepository,
            IAccountRoleRepository accountRoleRepository,
            IAccountAddressRepository accountAddressRepository)
        {
            _userRepository = userRepository;
            _userRoleRepository = userRoleRepository;
            _accountRepository = accountRepository;
            _accountRoleRepository = accountRoleRepository;
            _accountAddressRepository = accountAddressRepository;
        }

        // GET api/users
        [HttpGet]
        public IEnumerable<string> GetListUsers()
        {
            return new string[] {"User1", "User2", "User3"};
        }

        // GET api/users/user
        [HttpGet("{user}")]
        public string GetUserRole(string user)
        {
            return "UserRole";
        }
    }
}