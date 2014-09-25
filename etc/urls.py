from django.conf.urls import url, include, patterns
from django.conf.urls.i18n import i18n_patterns
from django.contrib import admin
from django.conf import settings


__all__ = ('default_patterns', 'default_i18n_patterns')

admin.autodiscover()

_patterns = (
    url(r'^admin/', include(admin.site.urls)),
    url(r'^%s$' % settings.LOGIN_URL[1:], 'django.contrib.auth.views.login',
         {'template_name': 'admin/login.html'})
)

default_patterns = patterns('', *_patterns)
default_i18n_patterns = i18n_patterns('', *_patterns)
