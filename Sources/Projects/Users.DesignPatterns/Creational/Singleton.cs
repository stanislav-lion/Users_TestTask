namespace Users.DesignPatterns.Creational
{
    using System;
    using System.Reflection;

    public class Singleton<T>
        where T : new()
    {
        protected Singleton()
        {

        }

        private sealed class SingletonCreator<TS>
            where TS : new()
        {
            public static TS CreatorInstance { get; } = (TS) typeof(TS).GetConstructor(
                    BindingFlags.Instance | BindingFlags.NonPublic,
                    null,
                    new Type[0],
                    new ParameterModifier[0]
                )
                ?.Invoke(null);
        }

        public static T Instance => SingletonCreator<T>.CreatorInstance;
    }

    /*public class Singleton<T>
        where T : new()
    {
        protected Singleton()
        {

        }

        private sealed class SingletonCreator<TS> 
            where TS : new()
        {
            public static TS Instance { get; } = new TS();
        }

        public static T Instance => SingletonCreator<T>.Instance;
    }*/

    /*public class Singleton<T> 
        where T : new()
    {
        protected Singleton()
        {

        }

        public static T Instance { get; } = new T();
    }*/
}