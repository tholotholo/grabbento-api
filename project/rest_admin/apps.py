from django.apps import AppConfig


class RestAdminConfig(AppConfig):
    name = 'rest_admin'

    def ready(self):
        import rest_admin.signals

