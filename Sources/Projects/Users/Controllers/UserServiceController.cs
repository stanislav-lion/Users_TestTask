namespace Users.Controllers
{
    using Microsoft.AspNetCore.Authorization;
    using Microsoft.AspNetCore.Mvc;
    using System.Threading.Tasks;
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

        public UserServiceController(IUserService userService)
        {
            _userService = userService;
        }

        // GET: api/userservice/getcurrentuser
        [HttpGet(Name = "GetCurrentUser")]
        [Authorize(Roles = "APPLICATION_ADMINISTRATOR")]
        public async Task<IActionResult> GetCurrentUser()
        {
            return await Task.Run(
                () =>
                {
                    User currentUser = _userService.CurrentUser;

                    if (currentUser == null)
                    {
                        return BadRequest();
                    }

                    IActionResult actionResult = Ok(currentUser);

                    return actionResult;
                });
        }

        // GET: api/userservice/getcurrentrole
        [HttpGet(Name = "GetUserRole")]
        [Authorize(Roles = "COMPANY_ADMINISTRATOR, COMPANY_USER")]
        public async Task<IActionResult> GetCurrentUserRole()
        {
            return await Task.Run(
                () =>
                {
                    string currentUserRole = _userService.CurrentUserRole;

                    if (string.IsNullOrEmpty(currentUserRole))
                    {
                        return BadRequest();
                    }

                    IActionResult actionResult = Ok(currentUserRole);

                    return actionResult;
                });
        }

        // POST: api/userservice/login
        [HttpPost]
        [AllowAnonymous]
        public async Task<IActionResult> LogIn([FromBody] Login login)
        {
            return await Task.Run(
                () =>
                {
                    if (login == null)
                    {
                        return BadRequest();
                    }

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

                    IActionResult actionResult = Ok(user);

                    return actionResult;
                });
        }

        // POST: api/userservice/logout
        [HttpPost]
        [AllowAnonymous]
        public async Task<IActionResult> LogOut()
        {
            return await Task.Run(
                () =>
                {
                    if (_userService.CurrentUser == null)
                    {
                        return BadRequest(new
                        {
                            message = Resource.ErrorMessageByLogOut
                        });
                    }

                    _userService.LogOut();

                    IActionResult actionResult = Ok(Resource.MessageLogOutSuccess);

                    return actionResult;
                });
        }

        // POST: api/userservice/register
        [HttpPost]
        [AllowAnonymous]
        public async Task<IActionResult> Register([FromBody] Register register)
        {
            return await Task.Run(
                () =>
                {
                    if (register == null)
                    {
                        return BadRequest();
                    }

                    UserShort user = _userService.Register(register.UserName, register.Password);

                    if (user == null)
                    {
                        return BadRequest(new
                        {
                            message = Resource.ErrorMessageByRegister
                        });
                    }

                    IActionResult actionResult = Ok(Resource.MessageLogOutSuccess);

                    return actionResult;
                });
        }
    }
}