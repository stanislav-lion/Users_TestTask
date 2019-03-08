namespace Users.Cache.Interfaces
{
    public interface ICache<T> where T : class
    {
        T GetValue();

        bool Add(T value);

        void Update(T value);

        void Delete();
    }
}