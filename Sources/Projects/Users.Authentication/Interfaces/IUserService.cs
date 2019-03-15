namespace Users.Authentication.Interfaces
{
    using System.Collections.Generic;
    using Users.Authentication.Models;
    using Users.DataAccess.DataModel.Types;

    public interface IUserService
    {
        IEnumerable<User> Users { get; }

        User CurrentUser { get; }

        string CurrentUserRole { get; }

        UserShort Register(string userName, string password);

        UserShort LogIn(string userName, string password);

        void LogOut();
    }
}