namespace Users.Controllers
{
    using System.Collections.Generic;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.Extensions.Caching.Memory;
    using Microsoft.Extensions.Options;
    using Users.Cache;
    using Users.CommonNames;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository;
    using Users.AppSettings;

    [Route("api/[controller]")]
    [ApiController]
    [FormatFilter]
    public class UsersController : ControllerBase
    {
        private readonly IUserRepository _userRepository;
        private readonly IMemoryCache _memoryCache;
        private readonly AppSettings _appSettings;

        private readonly CacheList<User> _userCacheList;

        public UsersController(
            IUserRepository userRepository,
            IMemoryCache memoryCache,
            IOptions<AppSettings> appSettings)
        {
            _userRepository = userRepository;
            _memoryCache = memoryCache;
            _appSettings = appSettings.Value;

            _userCacheList = new CacheList<User>(
                _memoryCache,
                _userRepository.Users,
                CacheKeys.Users.UsersItems,
                _appSettings.CacheExpirationAddMinutes);
        }

        // GET api/users
        [HttpGet]
        public IEnumerable<User> GetUsers()
        {
            return _userCacheList.GetValues();
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