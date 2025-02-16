import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordScreen({super.key});

  void handleResetPassword(BuildContext context) {
    final String email = emailController.text;
    debugPrint('Reset password for: $email');

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Password Reset'),
        content: Text('A password reset link has been sent to $email.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => handleResetPassword(context),
              child: const Text('Send Reset Link'),
            ),
          ],
        ),
      ),
    );
  }
}
