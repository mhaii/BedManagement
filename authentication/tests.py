from django.contrib.auth.models import User
from django.core.urlresolvers import reverse
from django.test import TestCase, Client


# Create your tests here.
class AuthenticationTest(TestCase):
    def setUp(self):
        self.client = Client()
        self.account = User.objects.create_user(username='test_account', password='1')

    def test_non_login_redirect(self):
        response = self.client.get(reverse('status'))
        self.assertRedirects(response, reverse('login') + '?next=' + reverse('status'))

    def test_login_page(self):
        response = self.client.get(reverse('login'))
        self.assertEqual(response.status_code, 200)
        self.assertTemplateUsed(response, 'authentication.html')

    def test_incorrect_login(self):
        response = self.client.post(reverse('login'), data={'username': 'fake', 'password': 'fake'})
        self.assertEqual(response.status_code, 200)
        self.assertTemplateUsed(response, 'authentication.html')

    def test_correct_login(self):
        response = self.client.post(reverse('login'), data={'username': 'test_account', 'password': '1'})
        self.assertEqual(response.status_code, 302)
        self.assertTemplateNotUsed(response, 'authentication.html')

    def test_logged_in_redirection(self):
        self.client.post(reverse('login'), data={'username': 'test_account', 'password': '1'})
        response = self.client.get(reverse('login') + '?next=' + reverse('status'))
        self.assertTemplateNotUsed(response, 'authentication.html')

    def test_logout_page(self):
        self.client.post(reverse('login'), data={'username': 'test_account', 'password': '1'})
        self.client.get(reverse('logout'))
        response = self.client.get(reverse('status'))
        self.assertRedirects(response, reverse('login') + '?next=' + reverse('status'))

