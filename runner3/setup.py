from __future__ import unicode_literals

try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

setup(
    name='runway_model_runner',
    version='0.1.0',
    description='Runway Model Runner',
    author='Runway AI',
    author_email='contact@runwayapp.ai',
    url='https://runwayapp.ai',
    packages=['model_runner'],
    entry_points={
        'console_scripts': [
            'model_runner = model_runner:main',
        ],
    },
    install_requires=[
        'pyyaml>=3.11',
        'wget>=3.2'
    ]
)


