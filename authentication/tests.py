from django.contrib.auth.models import User
from django.test import TestCase, Client


# Create your tests here.
class AuthenticationTest(TestCase):
    def setUp(self):
        self.client = Client()
        self.account = User.objects.create_user(username='user', password='passw')

    def test_non_login_redirect(self):
        response = self.client.get('/home/')
        self.assertRedirects(response, '/accounts/login/?next=/home/')

    def test_login_page(self):
        response = self.client.get('/accounts/login/')
        self.assertEqual(response.status_code, 200)
        self.assertTemplateUsed(response, 'authentication.html')

    def test_correct_login(self):
        response = self.client.post('/accounts/login/?next=/home/', data={'username': 'user', 'password': 'passw'})
        self.assertEqual(response.status_code, 302)
        self.assertTemplateNotUsed(response, 'authentication.html')

    def test_incorrect_login(self):
        response = self.client.post('/accounts/login/?next=/home/', data={'username': 'fake', 'password': 'fake'})
        self.assertEqual(response.status_code, 200)
        self.assertTemplateUsed(response, 'authentication.html')

    def test_logged_in_redirection(self):
        self.client.post('/accounts/login/?next=/home/', data={'username': 'user', 'password': 'passw'})
        response = self.client.get('/accounts/login/?next=/home/')
        self.assertTemplateNotUsed(response, 'authentication.html')

    def test_logout_page(self):
        self.client.post('/accounts/login/?next=/home/', data={'username': 'user', 'password': 'passw'})
        self.client.get('/accounts/logout/')
        response = self.client.get('/home/')
        self.assertRedirects(response, '/accounts/login/?next=/home/')

