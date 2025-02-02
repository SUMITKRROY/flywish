import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../component/myTextForm.dart';
import '../../route/pageroute.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool passwordVisible = true;
  bool confirmPasswordVisible = true;

  void _updatePassword() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement password update logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password Updated Successfully!")),
      );
      Navigator.pushReplacementNamed(context, RoutePath.login);
    }
  }

  Widget _buildPasswordField() {
    return MyTextForm(
      //prefix: const Icon(Icons.lock_open_outlined),
      inputFormatters: [
        LengthLimitingTextInputFormatter(16),
      ],
      label: 'Password',
      onChanged: (val) => {},
      controller: _passwordController,
      keyboardType: TextInputType.text,
      validatorLabel: 'password',
      suffix: IconButton(
        color: Colors.grey,
        icon: Icon(passwordVisible ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
          setState(() {
            passwordVisible = !passwordVisible;
          });
        },
      ),
      obscured: passwordVisible,
      validator: true,
      maxline: 1,
    );
  }

  Widget _buildConfirmPasswordField() {
    return MyTextForm(
      //  prefix: const Icon(Icons.lock_outline),
      inputFormatters: [
        LengthLimitingTextInputFormatter(16),
      ],
      label: 'Confirm Password',
      onChanged: (val) => {},
      controller: _confirmPasswordController,
      keyboardType: TextInputType.text,
      validatorLabel: 'confirm password',
      suffix: IconButton(
        color: Colors.grey,
        icon: Icon(confirmPasswordVisible ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
          setState(() {
            confirmPasswordVisible = !confirmPasswordVisible;
          });
        },
      ),
      obscured: confirmPasswordVisible,
      validator: true,
      validatorFunc: (value) {
        if (value != _passwordController.text) {
          return "Passwords do not match";
        }
        return null;
      },
      maxline: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("New Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                "Set the new password for your account so you can login and access all features",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              _buildPasswordField(),
              const SizedBox(height: 15),
              _buildConfirmPasswordField(),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _updatePassword,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("UPDATE PASSWORD"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
