namespace Users.Controllers
{
    using Microsoft.AspNetCore.Authorization;
    using Microsoft.AspNetCore.Mvc;
    using System;
    using Users.Authentication.Interfaces;
    using Users.Authentication.Models;
    using Users.DataAccess.DataModel.Types;

    [ApiController]
    [Route("api/[controller]/[action]")]
    [Authorize]
    [FormatFilter] // api/[controller]/[action]?format=xml
    public class UserServiceController : ControllerBase
    {
        private readonly IUserService _userService;

        public UserServiceController(IUserService userService) =>
            _userService = userService;

        // GET: api/userservice/getcurrentuser
        [HttpGet(Name = "GetCurrentUser")]
        [Authorize(Roles = "APPLICATION_ADMINISTRATOR")]
        public User GetCurrentUser() =>
            _userService.CurrentUser;

        // GET: api/userservice/getcurrentrole
        [HttpGet(Name = "GetUserRole")]
        [Authorize(Roles = "COMPANY_ADMINISTRATOR, COMPANY_USER")]
        public string GetCurrentUserRole() =>
            _userService.CurrentUserRole;

        // POST: api/userservice/login
        [HttpPost]
        [AllowAnonymous]
        public IActionResult LogIn([FromBody] Login login)
        {
            if (_userService.CurrentUser != null)
            {
                return BadRequest(new
                {
                    message = Resource.ErrorMessageByLogIn
                });
            }

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
        [AllowAnonymous]
        public IActionResult LogOut()
        {
            if (_userService.CurrentUser == null)
            {
                return BadRequest(new
                {
                    message = Resource.ErrorMessageByLogOut
                });
            }

            _userService.LogOut();

            return Ok(Resource.MessageLogOutSuccess);
        }

        // POST: api/userservice/register
        [HttpPost]
        [AllowAnonymous]
        public IActionResult Register([FromBody] Register register)
        {
            throw new NotImplementedException();
        }
    }
}