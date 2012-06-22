from .generic import DJANGO_PROJECT_DIR


TEMPLATE_DIRS = (
)

TEMPLATE_LOADERS_DEFAULT = (
    'django.template.loaders.filesystem.Loader',
    'django.template.loaders.app_directories.Loader',
)

TEMPLATE_LOADERS = TEMPLATE_LOADERS_DEFAULT

TEMPLATE_LOADERS_CACHED = (
    ('django.template.loaders.cached.Loader', TEMPLATE_LOADERS_DEFAULT),
)

TEMPLATE_CONTEXT_PROCESSORS_DEFAULT = (
    'django.contrib.auth.context_processors.auth',
    'django.core.context_processors.debug',
    'django.core.context_processors.i18n',
    'django.core.context_processors.request',
    'django.core.context_processors.media',
    'django.core.context_processors.static',
    'django.core.context_processors.tz'
    'django.contrib.messages.context_processors.messages',
    'g0j0.context_processors.settings_proxy',
)

TEMPLATE_CONTEXT_PROCESSORS = TEMPLATE_CONTEXT_PROCESSORS_DEFAULT
