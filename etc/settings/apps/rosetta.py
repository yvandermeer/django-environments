# Default settings for django-compressor

# ROSETTA_MESSAGES_PER_PAGE: Number of messages to display per page. Defaults to 10.
ROSETTA_MESSAGES_PER_PAGE = 100

# ROSETTA_ENABLE_TRANSLATION_SUGGESTIONS: Enable AJAX translation suggestions. Defaults to False.
ROSETTA_ENABLE_TRANSLATION_SUGGESTIONS = True

# BING_APP_ID: Translation suggestions used to come from the Google Translation API service, but free service has been discontinued, and the next best thing is Microsoft Bing's Translation API. To use this service you must first obtain an AppID key, then specify the key here. Defaults to None.

# ROSETTA_MESSAGES_SOURCE_LANGUAGE_CODE and ROSETTA_MESSAGES_SOURCE_LANGUAGE_NAME: Change these if the source language in your PO files isn't English. Default to 'en' and 'English' respectively.

# ROSETTA_WSGI_AUTO_RELOAD and ROSETTA_UWSGI_AUTO_RELOAD: When running WSGI daemon mode, using mod_wsgi 2.0c5 or later, this setting controls whether the contents of the gettext catalog files should be automatically reloaded by the WSGI processes each time they are modified. For performance reasons, this setting should be disabled in production environments. Default to False.
ROSETTA_WSGI_AUTO_RELOAD = True
ROSETTA_UWSGI_AUTO_RELOAD = True

# ROSETTA_EXCLUDED_APPLICATIONS: Exclude applications defined in this list from being translated. Defaults to ().

# ROSETTA_REQUIRES_AUTH: Require authentication for all Rosetta views. Defaults to True.

# ROSETTA_POFILE_WRAP_WIDTH: Sets the line-length of the edited PO file. Set this to 0 to mimic makemessage's --no-wrap option. Defaults to 78.

# ROSETTA_STORAGE_CLASS: See the note below on Storages. Defaults to rosetta.storage.CacheRosettaStorage
