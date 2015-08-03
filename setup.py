#!/usr/bin/python
import sys
from setuptools import setup, find_packages

# Add the local path
sys.path.append('src/usr/local/lib/python2.7/dist-packages')

# Get the module version
from lsbinit import __version__

# Module version / long description
version = __version__
long_desc = open('DESCRIPTION.rst').read()

# Run the setup
setup(
    name='lsbinit',
    version=version,
    description='Linux init scripts handler',
    package_dir={'': 'src/usr/local/lib/python2.7/dist-packages'},
    long_description=long_desc,
    author='David Taylor',
    author_email='djtaylor13@gmail.com',
    url='http://github.com/djtaylor/python-lsbinit',
    license='GPLv3',
    packages=find_packages(),
    keywords='feedback terminal shell init service',
    classifiers=[
        'Development Status :: 3 - Alpha',
        'Environment :: Console',
        'License :: OSI Approved :: GNU General Public License v3 or later (GPLv3+)',
        'Natural Language :: English',
        'Operating System :: POSIX',
        'Programming Language :: Python',
        'Topic :: Terminals',
        'Topic :: System :: Systems Administration',
        'Topic :: System :: Shells'
    ]
)