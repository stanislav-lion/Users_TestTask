namespace Users.Controllers
{
    using System.Collections.Generic;
    using Microsoft.AspNetCore.Mvc;
    using Users.DataAccess.DataModel.Types;
    using Users.DataAccess.Repository;

    [Route("api/[controller]")]
    [ApiController]
    public class AccountsController : ControllerBase
    {
        private readonly IAccountRepository _accountRepository;

        public AccountsController(IAccountRepository accountRepository)
        {
            _accountRepository = accountRepository;
        }

        // GET: api/accounts
        [HttpGet]
        public IEnumerable<Account> GetAccounts()
        {
            return _accountRepository.Accounts;
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