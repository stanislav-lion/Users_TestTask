namespace Users.Controllers
{
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
    using System.Threading.Tasks;

    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    [FormatFilter] // api/[controller]?format=xml
    public class AccountsController : ControllerBase
    {
        private readonly IAccountRepository _accountRepository;
        private readonly CacheSetting _cacheSetting;
        private readonly IMemoryCache _memoryCache;

        private CacheList<Account> _accountCacheList;

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
        [HttpGet(Name = "GetAccounts")]
        [Authorize(Roles = "APPLICATION_ADMINISTRATOR")]
        public async Task<IEnumerable<Account>> GetAccounts()
        {
            return await Task.Run(
                () => _accountCacheList.GetValues());
        }

        // GET: api/accounts/[accountId]
        [HttpGet("{accountId}", Name = "GetAccount")]
        public async Task<IActionResult> GetAccount(int accountId)
        {
            return await Task.Run(
                () =>
                {
                    if (accountId < 1)
                    {
                        return BadRequest();
                    }

                    Account account = _accountRepository.Get(accountId);

                    if (account == null)
                    {
                        return BadRequest();
                    }

                    IActionResult actionResult = Ok(account);

                    return actionResult;
                });
        }

        // POST: api/accounts
        [HttpPost]
        public async Task<IActionResult> AddAccount([FromBody] Account account)
        {
            return await Task.Run(
                () =>
                {
                    if ((account == null) ||
                        (account.AccountId < 1))
                    {
                        return BadRequest();
                    }

                    int added = _accountRepository.Upsert(account);

                    if (added == 0)
                    {
                        return BadRequest();
                    }

                    IActionResult actionResult = Ok(added);

                    return actionResult;
                });
        }

        // PUT: api/accounts/
        [HttpPut]
        public async Task<IActionResult> UpdateAccount([FromBody] Account account)
        {
            return await Task.Run(
                () =>
                {
                    if ((account == null) ||
                        (account.AccountId < 1))
                    {
                        return BadRequest();
                    }

                    int updated = _accountRepository.Upsert(account);

                    if (updated == 0)
                    {
                        return BadRequest();
                    }

                    IActionResult actionResult = Ok(updated);

                    return actionResult;
                });
        }

        // DELETE: api/accounts/[accountId]
        [HttpDelete("{accountId}")]
        public async Task<IActionResult> DeleteAccount(int accountId)
        {
            return await Task.Run(
                () =>
                {
                    if (accountId < 1)
                    {
                        return BadRequest();
                    }

                    int deleted = _accountRepository.Delete(accountId);

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