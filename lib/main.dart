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
  // ignore: library_private_types_in_public_api
  _PasswordGeneratorScreenState createState() =>
      _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState extends State<PasswordGeneratorScreen> {
  final TextEditingController _passwordController = TextEditingController();
  String _passwordStrength = "";

  void _generatePassword() {
    const String chars =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()-_=+";
    const int passwordLength = 15;
    Random random = Random();

    setState(() {
      _passwordController.text = List.generate(
              passwordLength, (index) => chars[random.nextInt(chars.length)])
          .join();
      _passwordStrength = _checkPasswordStrength(_passwordController.text);
    });
  }

  String _checkPasswordStrength(String password) {
    if (password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
      return "Forte";
    } else if (password.contains(RegExp(r'[A-Z]')) ||
        password.contains(RegExp(r'[a-z]')) ||
        password.contains(RegExp(r'[0-9]'))) {
      return "Média";
    } else {
      return "Fraca";
    }
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
          children: <Widget>[
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
