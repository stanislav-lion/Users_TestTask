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

        public UsersController(
            IUserRepository userRepository,
            IUserRoleRepository userRoleRepository)
        {
            _userRepository = userRepository;
            _userRoleRepository = userRoleRepository;
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