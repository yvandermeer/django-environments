from distribute_setup import use_setuptools
use_setuptools()
# See http://packages.python.org/distribute/setuptools.html#using-setuptools-without-bundling-it

from os import path, listdir

# from distutils.core import setup
import setuptools; print setuptools.__file__
from setuptools import setup, find_packages
# exit()


# XXX TODO only include executable files here, and try to include the other files with MANIFEST.in
bin_dirname = 'bin'
bin_dir = path.join(path.dirname(path.abspath(__file__)), bin_dirname)
scripts = [path.join(bin_dirname, script) for script in listdir(bin_dir)]

setup(
    name='django-environments',
    version='0.1',
    description='Django Environments',
    url='http://goeiejongens.nl/',
    author='Goeie Jongens',
    author_email='wij@goeiejongens.nl',
    packages=[],
    scripts=scripts,
)
