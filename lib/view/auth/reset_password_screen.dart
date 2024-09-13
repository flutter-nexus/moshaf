

import '../../imports/imports.dart';

class ResetPasswordScreen extends StatelessWidget {
  final ResetPasswordController _controller = ResetPasswordController();

  ResetPasswordScreen({super.key});

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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
            child: Form(
              key: _controller.formKey,
              child: Container(
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 15),
                    const Text(
                      "Reset Password",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                        fontFamily: 'NotoNaskhArabic',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      'assets/images/forgetpassword.png',
                      height: MediaQuery.sizeOf(context).height * 0.3,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Enter your email and we'll send you a code to reset your password.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                    const SizedBox(height: 40),
                    _buildEmailField(_controller),
                    const SizedBox(height: 40),
                    _controller.isLoading
                        ? const CircularProgressIndicator()
                        : _buildResetPasswordButton(context, _controller),
                    const SizedBox(height: 20),
                    _buildBackToLoginButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField(ResetPasswordController controller) {
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

  Widget _buildResetPasswordButton(
      BuildContext context, ResetPasswordController controller) {
    return ElevatedButton(
      onPressed: () {
        controller.resetPassword(context);
        
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.2,
          vertical: MediaQuery.sizeOf(context).height * 0.02,
        ),
      ),
      child: const Text(
        'Reset Password',
        style: TextStyle(
          fontSize: 18,
          color: Colors.teal,
        ),
      ),
    );
  }

  Widget _buildBackToLoginButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context); // Go back to the previous screen
      },
      child: const Text(
        'Back to Login',
        style: TextStyle(color: Colors.teal),
      ),
    );
  }
}

class ResetPasswordController with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool isLoading = false;

  void resetPassword(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();

      // Simulate a network request to send reset password email
      await Future.delayed(const Duration(seconds: 2));

      isLoading = false;
      notifyListeners();

      // Display a success message or navigate to another screen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent!'),
          backgroundColor: Colors.green,
        ),
        
      );
       Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerificationCodeInput(
                      controller: TextEditingController(),
                      onCompleted: (value) { 
                        print(value);
                        
                      },
                    ),
                  ),
                );
    }
  }
}
