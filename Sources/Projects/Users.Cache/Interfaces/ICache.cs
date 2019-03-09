namespace Users.Cache.Interfaces
{
    public interface ICache<TData> 
        where TData : class
    {
        TData GetValue();

        void Set(TData value);

        void Remove();
    }
}