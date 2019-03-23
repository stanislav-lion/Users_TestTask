﻿namespace Users.Controllers
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
        public async Task<IEnumerable<User>> GetUsers()
        {
            return await Task.Run(
                () => _userCacheList.GetValues());
        }
        
        // GET: api/users/[userId]
        [HttpGet("{userId}", Name = "GetUser")]
        public async Task<IActionResult> GetUser(int userId)
        {
            return await Task.Run(
                () =>
                {
                    IActionResult actionResult;

                    if (userId < 1)
                    {
                        actionResult = BadRequest();
                    }

                    User user = _userRepository.Get(userId);

                    if (user == null)
                    {
                        actionResult = BadRequest();
                    }

                    actionResult = Ok(user);

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
                    IActionResult actionResult;

                    if ((user == null) ||
                        (user.UserId < 1))
                    {
                        actionResult = BadRequest();
                    }

                    int added = _userRepository.Upsert(user);

                    if (added == 0)
                    {
                        actionResult = BadRequest();
                    }

                    actionResult = Ok(added);

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
                    IActionResult actionResult;

                    if ((user == null) ||
                        (user.UserId < 1))
                    {
                        actionResult = BadRequest();
                    }

                    int updated = _userRepository.Upsert(user);

                    if (updated == 0)
                    {
                        actionResult = BadRequest();
                    }

                    actionResult = Ok(updated);

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
                    IActionResult actionResult = Ok();

                    if (userId < 1)
                    {
                        actionResult = BadRequest();
                    }

                    int deleted = _userRepository.Delete(userId);

                    if (deleted == 0)
                    {
                        actionResult = BadRequest();
                    }

                    actionResult = Ok(deleted);

                    return actionResult;
                });
        }
    }
}