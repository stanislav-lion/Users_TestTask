namespace Users.Controllers
{
    using System;
    using System.Collections.Generic;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.Extensions.Caching.Memory;
    using Users.Cache;
    using Users.CommonNames;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository;
    using Microsoft.Extensions.Options;
    using Microsoft.AspNetCore.Authorization;
    using Users.Cache.AppSettings;

    [ApiController]
    [Authorize]
    [Route("api/[controller]")]
    [FormatFilter] // api/[controller]?format=xml
    public class AccountsController : ControllerBase
    {
        private readonly IAccountRepository _accountRepository;
        private readonly CacheSetting _cacheSetting;
        private readonly IMemoryCache _memoryCache;

        private readonly CacheList<Account> _accountCacheList;

        public AccountsController(
            IAccountRepository accountRepository,
            IOptions<CacheSetting> cacheSetting,
            IMemoryCache memoryCache)
        {
            _accountRepository = accountRepository;
            _cacheSetting = cacheSetting.Value;
            _memoryCache = memoryCache;

            _accountCacheList = new CacheList<Account>(
                _memoryCache,
                _accountRepository.Accounts,
                CacheKeys.Accounts.AccountsItems,
                _cacheSetting.ExpireMinutes);
        }

        // GET: api/accounts
        [Authorize(Roles = "APPLICATION_ADMINISTRATOR")]
        [HttpGet]
        public IEnumerable<Account> GetAccounts()
        {
            return _accountCacheList.GetValues();
        }

        // GET: api/accounts/[accountId]
        [HttpGet("{accountId}", Name = "GetAccount")]
        public Account GetAccount(int accountId)
        {
            throw new NotImplementedException();
        }

        // POST: api/accounts
        [HttpPost]
        public void AddAccount([FromBody] Account account)
        {
            throw new NotImplementedException();
        }

        // PUT: api/accounts/[accountId]
        [HttpPut("{accountId}")]
        public void UpdateAccount(int accountId, [FromBody] Account account)
        {
            throw new NotImplementedException();
        }

        // DELETE: api/accounts/[accountId]
        [HttpDelete("{accountId}")]
        public void DeleteAccount(int accountId)
        {
            throw new NotImplementedException();
        }
    }
}