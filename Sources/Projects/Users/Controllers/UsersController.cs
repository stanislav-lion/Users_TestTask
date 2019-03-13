namespace Users.Controllers
{
    using System;
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

    [ApiController]
    [Authorize]
    [Route("api/[controller]")]
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
        [Authorize(Roles = "APPLICATION_ADMINISTRATOR")]
        [HttpGet(Name = "GetUsers")]
        public IEnumerable<User> GetUsers()
        {
            return _userCacheList.GetValues();
        }

        // GET: api/users/[userId]
        [HttpGet("{userId}", Name = "GetUser")]
        public User GetUser(int userId)
        {
            throw new NotImplementedException();
        }
        
        // POST: api/users
        [HttpPost]
        public void AddUser([FromBody] User user)
        {
            throw new NotImplementedException();
        }

        // PUT: api/users/[userId]
        [HttpPut("{userId}")]
        public void UpdateUser(int userId, [FromBody] User user)
        {
            throw new NotImplementedException();
        }

        // DELETE: api/users/[userId]
        [HttpDelete("{userId}")]
        public void DeleteUser(int userId)
        {
            throw new NotImplementedException();
        }
    }
}