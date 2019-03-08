namespace Users.Controllers
{
    using System.Collections.Generic;
    using Microsoft.AspNetCore.Mvc;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository;

    [Route("api/[controller]")]
    [ApiController]
    public class UsersController : ControllerBase
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
        public IEnumerable<User> GetUsers()
        {
            return _userRepository.Users;
        }

        // GET: api/users/[userId]
        [HttpGet("{userId}", Name = "GetUser")]
        public User GetUser(int userId)
        {
            return new User();
        }

        // POST: api/users
        [HttpPost]
        public void AddUser([FromBody] User user)
        {

        }

        // PUT: api/users/[userId]
        [HttpPut("{userId}")]
        public void UpdateUser(int userId, [FromBody] User user)
        {

        }

        // DELETE: api/users/[userId]
        [HttpDelete("{userId}")]
        public void DeleteUser(int userId)
        {

        }
    }
}