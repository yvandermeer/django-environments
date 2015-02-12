import glob
import versioneer
from os import path
from setuptools import setup, find_packages


here = path.dirname(path.abspath(__file__))
scripts = [path.relpath(p, here) for p in glob.glob(path.join(here, 'bin/*'))]
packages = find_packages()

with open(path.join(here, 'README.rst')) as f:
    long_description = f.read().strip()

versioneer.VCS = 'git'
versioneer.versionfile_source = '{0}/_version.py'.format(packages[0])
versioneer.tag_prefix = ''
versioneer.parentdir_prefix = ''

setup(
    name='django-environments',
    version=versioneer.get_version(),
    cmdclass=versioneer.get_cmdclass(),
    description='Manage different settings within a Django project with maximum DRY',
    long_description=long_description,
    author='Goeie Jongens',
    author_email='jullie@goeiejongens.nl',
    url='http://github.com/yvandermeer/django-environments',
    packages=packages,
    install_requires=[
        'Django>=1.1',
    ],
    scripts=scripts,
    classifiers=[
        'Development Status :: 3 - Alpha',
        'Environment :: Console',
        'Environment :: Web Environment',
        'Framework :: Django',
        'Intended Audience :: Developers',
        'Intended Audience :: System Administrators',
        'License :: OSI Approved :: MIT License',
        'Operating System :: MacOS :: MacOS X',
        'Operating System :: POSIX',
        'Programming Language :: Python',
        'Topic :: Internet :: WWW/HTTP',
        'Topic :: Internet :: WWW/HTTP :: Dynamic Content',
    ],
    zip_safe=False,
)
