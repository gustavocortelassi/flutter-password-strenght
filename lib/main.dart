import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Gerador de Senhas',
      home: PasswordGeneratorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PasswordGeneratorScreen extends StatefulWidget {
  const PasswordGeneratorScreen({super.key});

  @override
  _PasswordGeneratorScreenState createState() =>
      _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState extends State<PasswordGeneratorScreen> {
  final TextEditingController _passwordController = TextEditingController();
  String _passwordStrength = "";

  void _generatePassword() {
    const chars =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()-_=+";
    const passwordLength = 15;
    final random = Random();

    final password = List.generate(
      passwordLength,
      (index) => chars[random.nextInt(chars.length)],
    ).join();

    setState(() {
      _passwordController.text = password;
      _passwordStrength = _checkPasswordStrength(password);
    });
  }

  String _checkPasswordStrength(String password) {
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasDigits = password.contains(RegExp(r'[0-9]'));
    final hasSpecial = password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));

    final strengthCount = [hasUppercase, hasLowercase, hasDigits, hasSpecial]
        .where((condition) => condition)
        .length;

    return ['Fraca', 'Média', 'Forte'][strengthCount - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerador de Senhas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _generatePassword,
              child: const Text('Gerar'),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _passwordController,
              onChanged: (text) {
                setState(() {
                  _passwordStrength = _checkPasswordStrength(text);
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Senha',
              ),
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            Text(
              'Força da senha: $_passwordStrength',
              style: TextStyle(
                fontSize: 20,
                color: _passwordStrength == 'Fraca'
                    ? Colors.red
                    : _passwordStrength == 'Média'
                        ? Colors.orange
                        : Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
