from django.shortcuts import redirect


def get_context(request):
    context = dict()

    return context


def require_login_function_view(function):
    def wrapper(request, *args, **kwargs):
        oauth_id = request.session.get('oauth-id')
        if oauth_id:
            return function(request, *args, **kwargs)
        else:
            return redirect('login')
    return wrapper


def require_login_class_html(function):
    def wrapper(self, request, *args, **kwargs):
        oauth_id = request.session.get('oauth-id')
        if oauth_id:
            return function(self, request, *args, **kwargs)
        else:
            return redirect('login')
    return wrapper
