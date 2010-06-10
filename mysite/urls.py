from django.conf.urls.defaults import *
from django.contrib import admin
from django.conf import settings

admin.autodiscover()

# Basic stuff
urlpatterns = patterns('',
    (r'^', Just_throwing_exception_to_get_the_debug_screen),

    #(r'^', include('main.urls')),

    #$(r'^admin/doc/', include('django.contrib.admindocs.urls')),
    (r'^admin/', include(admin.site.urls)),

    #$(r'^admin/filebrowser/', include('filebrowser.urls')),
    #$(r'^admin/rosetta/', include('rosetta.urls')),
)

# Check SERVE_MEDIA
if settings.SERVE_MEDIA:
    urlpatterns += patterns('',
        (r'^static/(?P<path>.*)$', 'django.views.static.serve',
         {'document_root': settings.MEDIA_ROOT, 'show_indexes': False}),
    )
