﻿namespace Users.Controllers
{
    using System.Collections.Generic;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.Extensions.Caching.Memory;
    using Users.Cache;
    using Users.CommonNames;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository;
    using Users.AppSettings;
    using Microsoft.Extensions.Options;

    [Route("api/[controller]")]
    [ApiController]
    [FormatFilter] // api/[controller]?format=xml
    public class AccountsController : ControllerBase
    {
        private readonly IAccountRepository _accountRepository;
        private readonly IMemoryCache _memoryCache;
        private readonly AppSettings _appSettings;

        private readonly CacheList<Account> _accountCacheList;

        public AccountsController(
            IAccountRepository accountRepository,
            IMemoryCache memoryCache,
            IOptions<AppSettings> appSettings)
        {
            _accountRepository = accountRepository;
            _memoryCache = memoryCache;
            _appSettings = appSettings.Value;

            _accountCacheList = new CacheList<Account>(
                _memoryCache,
                _accountRepository.Accounts,
                CacheKeys.Accounts.AccountsItems,
                _appSettings.CacheExpirationAddMinutes);
        }

        // GET: api/accounts
        [HttpGet]
        public IEnumerable<Account> GetAccounts()
        {
            return _accountCacheList.GetValues();
        }

        // GET: api/accounts/[accountId]
        [HttpGet("{accountId}", Name = "GetAccount")]
        public Account GetAccount(int accountId)
        {
            return new Account();
        }

        // POST: api/accounts
        [HttpPost]
        public void AddAccount([FromBody] Account account)
        {

        }

        // PUT: api/accounts/[accountId]
        [HttpPut("{accountId}")]
        public void UpdateAccount(int accountId, [FromBody] Account account)
        {

        }

        // DELETE: api/accounts/[accountId]
        [HttpDelete("{accountId}")]
        public void DeleteAccount(int accountId)
        {

        }
    }
}