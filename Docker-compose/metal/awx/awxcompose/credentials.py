DATABASES = {
    'default': {
        'ATOMIC_REQUESTS': True,
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': "awx",
        'USER': "awx",
        'PASSWORD': "",
        'HOST': "postgres",
        'PORT': "5432",
    }
}

BROADCAST_WEBSOCKET_SECRET = ""
