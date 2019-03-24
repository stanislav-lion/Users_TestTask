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
    using Microsoft.AspNetCore.Authorization;
    using Users.Cache.AppSettings;
    using System.Threading.Tasks;

    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    [FormatFilter] // api/[controller]?format=xml
    public class UsersController : ControllerBase
    {
        private readonly IUserRepository _userRepository;
        private readonly CacheSetting _сacheSetting;
        private readonly IMemoryCache _memoryCache;

        private CacheList<User> _userCacheList;

        public UsersController(
            IUserRepository userRepository,
            IOptions<CacheSetting> сacheSetting,
            IMemoryCache memoryCache)
        {
            _userRepository = userRepository;
            _сacheSetting = сacheSetting.Value;
            _memoryCache = memoryCache;

            _userCacheList = new CacheList<User>(
                _memoryCache,
                _userRepository.UsersWithoutPasswords,
                CacheKeys.Users.UsersItems,
                _сacheSetting.ExpireMinutes);
        }

        // GET api/users
        [HttpGet(Name = "GetUsers")]
        [Authorize(Roles = "APPLICATION_ADMINISTRATOR")]
        public async Task<IActionResult> GetUsers()
        {
            return await Task.Run(
                () =>
                {
                    IEnumerable<User> users = _userCacheList.GetValues();

                    if (users == null)
                    {
                        return BadRequest();
                    }

                    IActionResult actionResult = Ok(users);

                    return actionResult;
                });
        }
        
        // GET: api/users/[userId]
        [HttpGet("{userId}", Name = "GetUser")]
        public async Task<IActionResult> GetUser(int userId)
        {
            return await Task.Run(
                () =>
                {
                    if (userId < 1)
                    {
                        return BadRequest();
                    }

                    User user = _userRepository.Get(userId);

                    if (user == null)
                    {
                        return BadRequest();
                    }

                    IActionResult actionResult = Ok(user);

                    return actionResult;
                });
        }
        
        // POST: api/users
        [HttpPost]
        public async Task<IActionResult> AddUser([FromBody] User user)
        {
            return await Task.Run(
                () =>
                {
                    if ((user == null) ||
                        (user.UserId < 1))
                    {
                        return BadRequest();
                    }

                    int added = _userRepository.Upsert(user);

                    if (added == 0)
                    {
                        return BadRequest();
                    }

                    IActionResult actionResult = Ok(added);

                    return actionResult;
                });
        }

        // PUT: api/users/
        [HttpPut]
        public async Task<IActionResult> UpdateUser([FromBody] User user)
        {
            return await Task.Run(
                () =>
                {
                    if ((user == null) ||
                        (user.UserId < 1))
                    {
                        return BadRequest();
                    }

                    int updated = _userRepository.Upsert(user);

                    if (updated == 0)
                    {
                        return BadRequest();
                    }

                    IActionResult actionResult = Ok(updated);

                    return actionResult;
                });
        }

        // DELETE: api/users/[userId]
        [HttpDelete("{userId}")]
        public async Task<IActionResult> DeleteUser(int userId)
        {
            return await Task.Run(
                () =>
                {
                    if (userId < 1)
                    {
                        return BadRequest();
                    }

                    int deleted = _userRepository.Delete(userId);

                    if (deleted == 0)
                    {
                        return BadRequest();
                    }

                    IActionResult actionResult = Ok(deleted);

                    return actionResult;
                });
        }
    }
}