namespace Users.Cache
{
    using Microsoft.Extensions.Caching.Memory;
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using Users.Cache.Interfaces;

    public class CacheList<TData> : ICacheList<TData>
        where TData : class
    {
        private readonly IMemoryCache _memoryCache;
        private readonly IQueryable<TData> _dataList;
        private readonly string _key;
        private readonly int _cacheExpirationAddMinutes;

        public CacheList(
            IMemoryCache memoryCache,
            IQueryable<TData> dataList,
            string key = nameof(ICacheList<TData>),
            int cacheExpirationAddMinutes = 10)
        {
            _memoryCache = memoryCache;
            _dataList = dataList;
            _key = key;
            _cacheExpirationAddMinutes = cacheExpirationAddMinutes;
        }

        public IEnumerable<TData> GetValues()
        {
            if (!_memoryCache.TryGetValue(_key, out IEnumerable<TData> values))
            {
                if (_dataList != null)
                {
                    values = _dataList;

                    Set(values);
                }
            }

            return values;
        }

        public void Set(IEnumerable<TData> values)
        {
            _memoryCache.Set(_key, values, new MemoryCacheEntryOptions
            {
                AbsoluteExpirationRelativeToNow = TimeSpan.FromMinutes(_cacheExpirationAddMinutes)
            });
        }

        public void Remove()
        {
            if (_memoryCache.TryGetValue(_key, out IEnumerable<TData> values))
            {
                _memoryCache.Remove(_key);
            }
        }
    }
}