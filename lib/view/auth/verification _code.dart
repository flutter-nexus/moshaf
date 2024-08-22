import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationCodeInput extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onCompleted;

  const VerificationCodeInput({
    Key? key,
    required this.controller,
    this.onCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.teal,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Verification Code',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  // Animation for illustrative image
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(seconds: 2),
                    builder:
                        (BuildContext context, double value, Widget? child) {
                      return Opacity(
                        opacity: value,
                        child: child,
                      );
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Image.asset(
                        'assets/images/verificationpin.png',
                        height: MediaQuery.of(context).size.height * 0.5,
                      ),
                    ),
                  ),
                  // Pin Code Input Field
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    controller: controller,
                    onChanged: (value) {},
                    onCompleted: onCompleted,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      disabledColor: Colors.teal,
                      activeColor: Colors.teal,
                      selectedColor: Colors.teal,
                      inactiveFillColor: Colors.white,
                      selectedFillColor: Colors.blue.shade100,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    keyboardType: TextInputType.number,
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
