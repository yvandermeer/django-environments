from django.conf.urls.defaults import patterns, include, url, handler404, handler500
handler404, handler500 # Keep pyflakes happy...
from django.contrib import admin
from django.contrib import databrowse
from django.conf import settings


__all__ = ('default_patterns', 'patterns', 'include', 'url', 'handler404', 'handler500')

admin.autodiscover()

default_patterns = patterns('',
    url(r'^admin/doc/', include('django.contrib.admindocs.urls')),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^databrowse/(.*)', databrowse.site.root),
    url(r'^%s$' % settings.LOGIN_URL[1:], 'django.contrib.auth.views.login',
         {'template_name': 'admin/login.html'})
)
