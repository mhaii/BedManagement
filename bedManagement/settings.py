import os
import sys

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


# Application launched from finder ignores '/usr/local/bin'
if sys.platform == 'darwin' and '/usr/local/bin' not in os.environ['PATH']:
    os.environ['PATH'] += ':/usr/local/bin'


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/1.9/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'a)dg*3orbx!#t4!b3by8#tqcw*p(crp-c(ksdq0=k9*23vp5fk'

try:
    # noinspection PyUnresolvedReferences
    import gunicorn
    DEBUG = False
except ImportError:
    DEBUG = True

ALLOWED_HOSTS = ['bed.mhaii.xyz', '127.0.0.1']


# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',

    # Third-party app
    'compressor', 'djangobower', 'djangular', 'rest_framework',

    # Our homebrew app~ <3
    'api', 'authentication', 'dashboard', 'statistic'
]

MIDDLEWARE_CLASSES = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.locale.LocaleMiddleware',    # i18n, must be between 'SessionMiddleware' and 'CommonMiddleware'
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.auth.middleware.SessionAuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'bedManagement.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'bedManagement.wsgi.application'


# Database
# https://docs.djangoproject.com/en/1.9/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'bed_management',
        'USER': 'root',
        'PASSWORD': '',
        'HOST': '127.0.0.1',     # localhost via TCP
        'PORT': '',              # default
    }
}


# Password validation
# https://docs.djangoproject.com/en/1.9/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator', },
    {'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator', },
    {'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator', },
    {'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator', },
]


# Internationalization
# https://docs.djangoproject.com/en/1.9/topics/i18n/

TIME_ZONE = 'Asia/Bangkok'

USE_I18N = True
USE_L10N = True
USE_TZ = True

LOCALE_PATHS = [os.path.join(BASE_DIR, 'locale/'), ]

LANGUAGE_CODE = 'th'
LANGUAGE = [
    ('en', 'English'),
    ('th', 'Thai'),
]


# Django-Rosetta
# http://django-rosetta.readthedocs.org/en/latest/settings.html

if DEBUG:
    INSTALLED_APPS += ['rosetta']
    ROSETTA_MESSAGES_PER_PAGE = 30
    ROSETTA_STORAGE_CLASS = 'rosetta.storage.CacheRosettaStorage'

# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.9/howto/static-files/

STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(BASE_DIR, 'static/')

# # settings with default values # #
STATICFILES_DIRS = []
STATICFILES_FINDERS = ['django.contrib.staticfiles.finders.FileSystemFinder',
                       'django.contrib.staticfiles.finders.AppDirectoriesFinder']


# Django-Compressor (Coffee, SASS)
# https://django-compressor.readthedocs.org/en/latest/settings/

STATICFILES_FINDERS += ['compressor.finders.CompressorFinder']

COMPRESS_OUTPUT_DIR = 'cache'
COMPRESS_PRECOMPILERS = [
    ('text/coffeescript', 'coffee --compile --stdio'),
    ('text/x-sass', 'django_libsass.SassCompiler'),
]

# Django-Bower (CSS, JavaScript Dependencies)
# https://django-bower.readthedocs.org/en/latest/usage.html

# noinspection PyUnresolvedReferences
BOWER_INSTALLED_APPS = [
    'jquery#~2.1.4',
    'angular#~1.4.8',
    'bootstrap-sass#~3.3.6',
    'bootstrap-material-design#~0.5.7',
    'highcharts#~4.2.1',
    'angular-ui-router#~0.2.0',
    'angular-resource#~1.4.9',
    'angularjs-humanize#~0.0.1'
]
BOWER_COMPONENTS_ROOT = BASE_DIR

# Django-Angular
# http://django-angular.readthedocs.org/en/latest/reverse-urls.html

MIDDLEWARE_CLASSES.insert(0, 'djangular.middleware.DjangularUrlMiddleware')
STATICFILES_DIRS += [os.path.join(BASE_DIR, 'dashboard/templates')]

# Django REST Framework
# http://www.django-rest-framework.org/api-guide/settings/

REST_FRAMEWORK = {
    # Return in character or escape value
    # 'UNICODE_JSON': False,
}
