namespace Users.Cache.Interfaces
{
    using System.Collections.Generic;

    public interface ICacheList<T> where T : class
    {
        IList<T> GetValues();

        bool Add(IList<T> values);

        void Update(IList<T> values);

        void Delete();
    }
}