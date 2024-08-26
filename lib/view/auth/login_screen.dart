import 'package:flutter/material.dart';
import 'package:moshaf/view/home/HomeScreen.dart';
import 'package:moshaf/view/auth/reset_password_screen.dart';
import 'package:moshaf/view/auth/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate a network request
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        // Navigate to the next screen or show success message
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color.fromARGB(255, 157, 251, 243),
                  Colors.white,
                ]),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 15),
                  const Text(
                    "Assalamu Alaikum",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                      fontFamily: 'NotoNaskhArabic',
                    ),
                  ),
                  Image.asset(
                    'assets/images/muslim-prayer.png',
                    height: MediaQuery.sizeOf(context).height * 0.25,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Welcome to the Muslim App",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  const SizedBox(height: 40),
                  _buildEmailField(),
                  const SizedBox(height: 20),
                  _buildPasswordField(),
                  const SizedBox(height: 40),
                  _isLoading ? _buildLoadingIndicator() : _buildLoginButton(),
                  const SizedBox(height: 20),
                  _buildForgotPasswordButton(),
                  const SizedBox(height: 5),
                  _buildCreateAccountButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'Enter your email',
        prefixIcon: const Icon(Icons.email, color: Colors.teal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Enter a valid email';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        prefixIcon: const Icon(Icons.lock, color: Colors.teal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return const CircularProgressIndicator();
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        _login;
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 100,
        ),
      ),
      child: const Text(
        'Login',
        style: TextStyle(
          fontSize: 18,
          color: Colors.teal,
        ),
      ),
    );
  }

  Widget _buildForgotPasswordButton() {
    return TextButton(
      onPressed: () {
        // Navigate to the Forgot Password screen
        // Navigator.pushNamed(context, '/forgot_password');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResetPasswordScreen(),
          ),
        );
      },
      child: const Text(
        'Forgot Password?',
        style: TextStyle(color: Colors.teal),
      ),
    );
  }

  Widget _buildCreateAccountButton() {
    return TextButton(
      onPressed: () {
        // Navigate to the Forgot Password screen
        // Navigator.pushNamed(context, '/forgot_password');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignUpScreen(),
          ),
        );
      },
      child: Text(
        'Create Account',
        style: TextStyle(color: Colors.teal[700]),
      ),
    );
  }
}
