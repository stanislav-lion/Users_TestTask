namespace Users.Controllers
{
    using Microsoft.AspNetCore.Authorization;
    using Microsoft.AspNetCore.Mvc;
    using System;
    using Users.Authentication.Interfaces;
    using Users.Authentication.Models;

    [ApiController]
    [Route("api/[controller]/[action]")]
    public class AuthenticationController : ControllerBase
    {
        private readonly IUserService _userService;

        public AuthenticationController(IUserService userService)
        {
            _userService = userService;
        }

        [AllowAnonymous]
        [HttpPost]
        public IActionResult Login([FromBody]Login login)
        {
            UserShort user = _userService.Authenticate(login.UserName, login.Password);

            if (user == null)
            {
                return BadRequest(new
                {
                    message = Resource.ErrorMessageByAuthenticate
                });
            }

            return Ok(user);
        }

        [AllowAnonymous]
        [HttpPost]
        public IActionResult Register([FromBody] Register register)
        {
            throw new NotImplementedException();
        }
    }
}