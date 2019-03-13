namespace Users.Authentication.Interfaces
{
    using System.Collections.Generic;
    using Users.Authentication.Models;
    using Users.DataAccess.DataModel.Types;

    public interface IUserService
    {
        IEnumerable<User> Users { get; }

        User CurrentUser { get; }

        UserShort LogIn(string username, string password);

        void LogOut();

        string GetUserRole();
    }
}