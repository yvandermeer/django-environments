from os import path
import logging

from .generic import PROJECT_ROOT, PROJECT


LOGGING_FILENAME = path.join(PROJECT_ROOT, 'log/%s.log' % PROJECT)

LOGGING = {
    'version': 1,
    'disable_existing_loggers': True,
    'filters': {
         'require_debug_false': {
             '()': 'django.utils.log.RequireDebugFalse',
         },
     },
    'formatters': {
        'verbose': {
            'format': '%(asctime)s %(levelname)-8s %(name)s: %(message)s',
            'datefmt': '%Y-%m-%d %H:%M:%S',
        },
        'devserver': {
            'format': '[%(asctime)s] %(name)s: %(message)s',
            'datefmt': '%d/%b/%Y %H:%M:%S',
        },
    },
    'handlers': {
        'null': {
            'level': 'DEBUG',
            'class': 'django.utils.log.NullHandler',
        },
        'console':{
            'level': 'DEBUG',
            'class': 'logging.StreamHandler',
            'formatter': 'devserver',
        },
        'file':{
            'level': 'DEBUG',
            'class': 'logging.FileHandler',
            'formatter': 'verbose',
            'filename': LOGGING_FILENAME,
        },
        'mail_admins': {
            'level': 'ERROR',
            'filters': ['require_debug_false'],
            'class': 'django.utils.log.AdminEmailHandler',
        },
    },
    'loggers': {
        '': {
            'handlers': ['file'],
            'propagate': True,
            'level': 'WARNING',
        },
        'django': {
            'handlers': ['null'],
            'propagate': False,
            'level': 'INFO',
        },
        'django.request': {
            'handlers': ['mail_admins', 'file'],
            'level': 'ERROR',
            'propagate': False,
        },
    }
}
