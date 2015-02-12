"""
Generic settings and url configuration for django-environments
projects
"""
from ._version import get_versions
__version__ = get_versions()['version']
del get_versions
