# Default settings for django-compressor
# http://pypi.python.org/pypi/django_compressor
# https://github.com/mintchaos/django_compressor

COMPRESS_ENABLED = False
#Default: the opposite of DEBUG
"""Boolean that decides if compression will happen."""

#COMPRESS_URL
#Default: MEDIA_URL
"""Controls the URL that linked media will be read from and compressed
media will be written to."""

#COMPRESS_ROOT
#Default: MEDIA_ROOT
"""Controls the absolute file path that linked media will be read
from and compressed media will be written to."""

COMPRESS_OUTPUT_DIR = 'z'
#Default: 'CACHE'
"""Controls the directory inside COMPRESS_ROOT that compressed files
will be written to."""

#COMPRESS_CSS_FILTERS
#Default: ['compressor.filters.css_default.CssAbsoluteFilter']
"""A list of filters that will be applied to CSS."""

#COMPRESS_JS_FILTERS
#Default: ['compressor.filters.jsmin.JSMinFilter']
"""A list of filters that will be applied to javascript."""

#COMPRESS_STORAGE
#Default: 'compressor.storage.CompressorFileStorage'
"""The dotted path to a Django Storage backend to be used to save the
compressed files."""

#COMPRESS_PARSER
#Default: 'compressor.parser.BeautifulSoupParser'
"""The backend to use when parsing the JavaScript or Stylesheet files.
The backends included in compressor:
* compressor.parser.BeautifulSoupParser
* compressor.parser.LxmlParser
See Dependencies for more info about the packages you need for
each parser."""

#COMPRESS_CACHE_BACKEND
#Default: CACHE_BACKEND
"""The backend to use for caching, in case you want to use a different
cache backend for compressor. Defaults to the CACHE_BACKEND setting."""

#COMPRESS_REBUILD_TIMEOUT
#Default: 2592000 (30 days in seconds)
"""The period of time after which the the compressed files are rebuilt
even if no file changes are detected."""

#COMPRESS_MINT_DELAY
#Default: 30 (seconds)
"""The upper bound on how long any compression should take to run.
Prevents dog piling, should be a lot smaller than COMPRESS_REBUILD_TIMEOUT."""

#COMPRESS_MTIME_DELAY
#Default: None
"""The amount of time (in seconds) to cache the result of the check
of the modification timestamp of a file. Disabled by default. Should
be smaller than COMPRESS_REBUILD_TIMEOUT and COMPRESS_MINT_DELAY."""
