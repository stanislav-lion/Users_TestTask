namespace Users.DataAccess.Database.RepositoryContexts.Async
{
    using System;
    using Users.DataAccess.Repository.Async;

    public class RepositoryContextAsync : IRepositoryContextAsync
    {
        public IAccountAddressRepositoryAsync AccountAddressRepositoryAsync => throw new NotImplementedException();

        public IAccountRepositoryAsync AccountRepositoryAsync => throw new NotImplementedException();

        public IAccountRoleRepositoryAsync AccountRoleRepositoryAsync => throw new NotImplementedException();

        public IUserRepositoryAsync UserRepositoryAsync => throw new NotImplementedException();

        public IUserRoleRepositoryAsync UserRoleRepositoryAsync => throw new NotImplementedException();

        public void BeginChangesAsync()
        {
            throw new NotImplementedException();
        }

        public void CancelChangesAsync()
        {
            throw new NotImplementedException();
        }

        public void Dispose()
        {
            throw new NotImplementedException();
        }

        public void PerformChangesAsync(Func<bool> changes)
        {
            throw new NotImplementedException();
        }

        public void SaveChangesAsync()
        {
            throw new NotImplementedException();
        }
    }
}