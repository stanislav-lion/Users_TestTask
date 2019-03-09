namespace Users.Cache.Interfaces
{
    using System.Collections.Generic;

    public interface ICacheList<TData> 
        where TData : class
    {
        IEnumerable<TData> GetValues();

        void Set(IEnumerable<TData> values);

        void Remove();
    }
}