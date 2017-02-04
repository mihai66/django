import pymysql
pymysql.install_as_MySQLdb()

from settings import *  # noqa

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'oscar',
        'USER': 'apps',
        'PASSWORD': 'apps',
        'HOST': 'localhost',
        'PORT': '',
    }
}
