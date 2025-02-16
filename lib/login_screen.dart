import 'package:flutter/material.dart';
import 'package:skillapp/mongodb_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  bool _isLoading = false;
  bool _isPasswordVisible = false;

  /// 🔹 Handle User Login
  Future<void> _login() async {
    String email = emailController.text.trim().toLowerCase(); // Convert to lowercase
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage('⚠️ Please fill in all fields', Colors.orange);
      return;
    }

    setState(() => _isLoading = true); // Show loader

    final result = await MongoDBService.loginUser(email, password);

    setState(() => _isLoading = false); // Hide loader

    if (result['success']) {
      _showMessage('✅ Welcome ${result['name']}!', Colors.green);
      _clearFields();
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      _showMessage('❌ ${result['error']}', Colors.red);
    }
  }

  /// 🔹 Show SnackBar messages (Ensures only one message at a time)
  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).clearSnackBars(); // Clear previous messages
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontSize: 16)),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// 🔹 Clear email & password fields
  void _clearFields() {
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Email',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            const Text(
              'Password',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              obscureText: !_isPasswordVisible,
            ),
            const SizedBox(height: 20),

            Center(
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Login', style: TextStyle(fontSize: 18)),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
