namespace Users.DesignPatterns.Creational
{
    public class LazyInitialization<T> 
        where T : new()
    {
        protected LazyInitialization()
        {

        }

        private static T _instance;

        public static T Instance
        {
            get
            {
                // To eliminate the possibility of creating two objects in a multithreaded application.
                if (_instance == null)
                {
                    lock (typeof(T))
                    {
                        if (_instance == null)
                        {
                            _instance = new T();
                        }
                    }
                }

                return _instance;
            }
        }
    }
}