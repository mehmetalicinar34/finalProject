import 'package:flutter/material.dart';
import 'package:flutter_advanced_dev/screens/client/register.dart';
import 'package:flutter_advanced_dev/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await loginUser(context); // context ekledik
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterScreen()),
                );
              },
              child: const Text('Create an account'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loginUser(BuildContext context) async {
    // Kullanıcı giriş bilgilerini al
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    // Kullanıcı giriş bilgilerini kontrol et
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedEmail = prefs.getString('user_email');
    final String? savedPassword = prefs.getString('user_password');

    // Kullanıcı giriş bilgilerini karşılaştır
    if (email == savedEmail && password == savedPassword) {
      // Başarılı giriş işlemi
      // HomeScreen'e yönlendirme
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()), // HomeScreen'e yönlendirme
      );
    } else {
      // Hatalı giriş işlemi
      // Örnek olarak, kullanıcıya hatalı giriş bilgileri girdiğini bildiren bir iletişim kutusu gösterebilirsiniz
      _showLoginErrorDialog(context);
    }
  }

  void _showLoginErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Login Failed'),
          content: const Text('Invalid email or password. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
