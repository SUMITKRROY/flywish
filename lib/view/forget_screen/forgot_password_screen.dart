import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../component/myTextForm.dart';
import '../../route/pageroute.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text("Back"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Forgot Your Password",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Enter your registered email address or phone number, and we'll send you a link to reset your password.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              _buildEmailField(),
              const SizedBox(height: 10),
              const Text(
                "You may receive Email or SMS notification from us",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacementNamed(
                          context, RoutePath.otpVerify);

                    }
                  },
                  child: const Text("CONTINUE"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return MyTextForm(
      label: "Email Address or Phone Number",
      controller: _emailController,
      inputFormatters: [
        LengthLimitingTextInputFormatter(30),
      ],
      keyboardType: TextInputType.text,
      validator: true,
validatorLabel: "email address or phone number",
      onChanged: (String) {},
    );
  }
}
