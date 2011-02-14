from django.conf.urls.defaults import patterns, include, url, handler404, handler500
handler404, handler500 # Keep pyflakes happy...
from django.contrib import admin
from django.contrib import databrowse
from django.conf import settings


__all__ = ('handler404', 'handler500', 'patterns', 'default_patterns', 'databrowse')


admin.autodiscover()


default_patterns = patterns('',
    (r'^admin/doc/', include('django.contrib.admindocs.urls')),
    (r'^admin/', include(admin.site.urls)),
    (r'^databrowse/(.*)', databrowse.site.root),
)

default_patterns += patterns('django.views.generic.simple',
    ('^$', 'redirect_to', {'url': '/admin/'}),
)

if settings.SERVE_MEDIA:
    default_patterns += patterns('',
        (r'^%s/(?P<path>.*)$' % settings.MEDIA_ID, 'django.views.static.serve',
         {'document_root': settings.MEDIA_ROOT, 'show_indexes': False}),
    )
