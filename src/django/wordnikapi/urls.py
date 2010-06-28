from django.conf.urls.defaults import *

# Uncomment the next two lines to enable the admin:
# from django.contrib import admin
# admin.autodiscover()

urlpatterns = patterns('',
    # Example:
    # (r'^wordnikapi/', include('wordnikapi.foo.urls')),
    (r'^$', 'wordnikapi.hello_dictionary.views.index'),
    (r'^wordnik/', 'wordnikapi.hello_dictionary.views.index')
)
