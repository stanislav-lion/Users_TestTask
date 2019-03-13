namespace Users.Controllers
{
    using Microsoft.AspNetCore.Authorization;
    using Microsoft.AspNetCore.Mvc;
    using System;
    using Users.Authentication.Interfaces;
    using Users.Authentication.Models;
    using Users.DataAccess.DataModel.Types;

    [ApiController]
    [Authorize]
    [Route("api/[controller]/[action]")]
    [FormatFilter] // api/[controller]/[action]?format=xml
    public class UserServiceController : ControllerBase
    {
        private readonly IUserService _userService;

        public UserServiceController(IUserService userService) =>
            _userService = userService;

        // GET: api/userservice/getcurrentuser
        [Authorize(Roles = "APPLICATION_ADMINISTRATOR")]
        [HttpGet(Name = "GetCurrentUser")]
        public User GetCurrentUser()
        {
            return _userService.CurrentUser;
        }

        // GET: api/userservice/getcurrentrole
        [Authorize(Roles = "COMPANY_ADMINISTRATOR")]
        [Authorize(Roles = "COMPANY_USER")]
        [HttpGet(Name = "GetUserRole")]
        public string GetCurrentUserRole()
        {
            return _userService.CurrentUserRole;
        }

        // POST: api/userservice/login
        [AllowAnonymous]
        [HttpPost]
        public IActionResult LogIn([FromBody] Login login)
        {
            UserShort user = _userService.LogIn(login.UserName, login.Password);

            if (user == null)
            {
                return BadRequest(new
                {
                    message = Resource.ErrorMessageByAuthenticate
                });
            }

            return Ok(user);
        }

        // POST: api/userservice/logout
        [HttpPost]
        public IActionResult LogOut()
        {
            _userService.LogOut();

            return Ok();
        }

        // POST: api/userservice/register
        [AllowAnonymous]
        [HttpPost]
        public IActionResult Register([FromBody] Register register)
        {
            throw new NotImplementedException();
        }
    }
}