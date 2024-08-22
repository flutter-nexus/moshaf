import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  final SignUpController _controller = SignUpController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
              key: _controller.formKey,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 15),
                    const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                        fontFamily: 'NotoNaskhArabic',
                      ),
                    ),
                    Image.asset(
                      'assets/images/registration.png',
                      height: MediaQuery.sizeOf(context).height * 0.25,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Join the Muslim App",
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                    const SizedBox(height: 20),
                    _buildNameField(_controller),
                    const SizedBox(height: 20),
                    _buildEmailField(_controller),
                    const SizedBox(height: 20),
                    _buildPasswordField(_controller),
                    const SizedBox(height: 20),
                    _buildConfirmPasswordField(_controller),
                    const SizedBox(height: 40),
                    _controller.isLoading
                        ? const CircularProgressIndicator()
                        : _buildSignUpButton(context, _controller),
                    const SizedBox(height: 20),
                    _buildLoginButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameField(SignUpController controller) {
    return TextFormField(
      controller: controller.nameController,
      decoration: InputDecoration(
        labelText: 'Name',
        hintText: 'Enter your name',
        prefixIcon: const Icon(Icons.person, color: Colors.teal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
    );
  }

  Widget _buildEmailField(SignUpController controller) {
    return TextFormField(
      controller: controller.emailController,
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

  Widget _buildPasswordField(SignUpController controller) {
    return TextFormField(
      controller: controller.passwordController,
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

  Widget _buildConfirmPasswordField(SignUpController controller) {
    return TextFormField(
      controller: controller.confirmPasswordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        hintText: 'Confirm your password',
        prefixIcon: const Icon(Icons.lock, color: Colors.teal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please confirm your password';
        }
        if (value != controller.passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }

  Widget _buildSignUpButton(BuildContext context, SignUpController controller) {
    return ElevatedButton(
      onPressed: () {
        controller.signUp(context);
        Navigator.pop(context);
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
        'Sign Up',
        style: TextStyle(
          fontSize: 18,
          color: Colors.teal,
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text(
        'Already have an account? Log In',
        style: TextStyle(color: Colors.teal),
      ),
    );
  }
}

class SignUpController with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;

  void signUp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();

      // Simulate a network request
      await Future.delayed(const Duration(seconds: 2));

      isLoading = false;
      notifyListeners();

      // Navigate to the next screen or show success message
    }
  }
}
