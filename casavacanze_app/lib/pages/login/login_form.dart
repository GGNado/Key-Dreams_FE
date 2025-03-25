import 'package:casavacanze_app/pages/home/home_page.dart';
import 'package:casavacanze_app/service/http_login.dart';
import 'package:casavacanze_app/main.dart'; // o il percorso corretto della HomePage
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _submitForm() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      final user = await HttpLogin.loginAndReturnUser(username, password);
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } catch (e) {
      if (!mounted) return;
      print(e);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Login fallito')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            hintText: 'Username',
            hintStyle: TextStyle(
              color: const Color.fromARGB(
                255,
                0,
                0,
                0,
              ), // Colore del placeholder
              fontSize: 16, // Dimensione del testo
              fontWeight: FontWeight.w500, // Peso del font
            ),
            filled: true,
            fillColor: const Color.fromARGB(105, 255, 255, 255),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: TextStyle(
              color: const Color.fromARGB(
                255,
                0,
                0,
                0,
              ), // Colore del placeholder
              fontSize: 16, // Dimensione del testo
              fontWeight: FontWeight.w500, // Peso del font
            ),
            filled: true,
            fillColor: const Color.fromARGB(105, 255, 255, 255),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 14),
            ),
            onPressed: _submitForm,
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
