CACHES = {
    'memcached': {
        'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
        'LOCATION': '127.0.0.1:11211',
    },
    'database': {
        'BACKEND': 'django.core.cache.backends.db.DatabaseCache',
        'LOCATION': '_cache',
    },
    'dummy': {
        'BACKEND': 'django.core.cache.backends.dummy.DummyCache',
    }
}
CACHES['default'] = CACHES['database']
