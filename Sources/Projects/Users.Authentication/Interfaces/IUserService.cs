namespace Users.Authentication.Interfaces
{
    using System.Collections.Generic;
    using Users.Authentication.Models;
    using Users.DataAccess.DataModel.Types;

    public interface IUserService
    {
        UserShort Authenticate(string username, string password);

        IEnumerable<User> Users { get; }
    }
}