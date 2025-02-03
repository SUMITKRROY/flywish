import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../component/myTextForm.dart';
import '../../provider/register/register_bloc.dart';
import '../../route/pageroute.dart';
import '../../utils/image.dart';
import '../../utils/utils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  bool agreeTerms = false;

  @override
  void initState() {
    passwordVisible = true;
    confirmPasswordVisible = true;
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            setState(() => _isLoading = true);  // Show loading
          } else {
            setState(() => _isLoading = false); // Hide loading
          }

          if (state is RegisterFailure) {
            Utils.snackbarToast(state.error);  // Display error message
          } else if (state is SignupSuccess) {
            Navigator.pushReplacementNamed(context, RoutePath.profileRegister);
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Image.asset(ImagePath.logo, height: 80.h),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Create Your Account',
                    style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Enter your details to get an account',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                  SizedBox(height: 30.h),
                  _buildEmailField(),
                  SizedBox(height: 15.h),
                  _buildPasswordField(),
                  SizedBox(height: 15.h),
                  _buildConfirmPasswordField(),
                  SizedBox(height: 10.h),
                  _buildTermsCheckbox(),
                  SizedBox(height: 20.h),
                  _buildRegisterButton(context),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text('or'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  _buildSocialButton('Login with Google', ImagePath.google),
                  SizedBox(height: 10.h),
                  _buildSocialButton('Login with Facebook', ImagePath.facebook),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account? '),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RoutePath.login);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return MyTextForm(
      label: "Email",
      controller: _emailController,
      inputFormatters: [
        LengthLimitingTextInputFormatter(30),
      ],
      keyboardType: TextInputType.emailAddress,
      validator: true,
      validatorFunc: Utils.emailValidator(), onChanged: (String ) {  },
    );
  }

  Widget _buildPasswordField() {
    return MyTextForm(
      label: 'Password',
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
      maxline: 1, onChanged: (String ) {  },
    );
  }

  Widget _buildConfirmPasswordField() {
    return MyTextForm(
      label: 'Confirm Password',
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
      maxline: 1, onChanged: (String ) {  },
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: agreeTerms,
          onChanged: (value) {
            setState(() {
              agreeTerms = value!;
            });
          },
        ),
        Text('Agree with Our '),
        GestureDetector(
          onTap: () {},
          child: Text(
            'Terms & Conditions',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: _isLoading || !agreeTerms ? null : () {
            if (_formKey.currentState!.validate()) {
              BlocProvider.of<RegisterBloc>(context).add(
                SignupUser(
                  email: _emailController.text,
                  password: _passwordController.text,
                  confirmPassword: _confirmPasswordController.text,
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            minimumSize: Size(double.infinity, 50.h),
          ),
          child: _isLoading
              ? CircularProgressIndicator()
              : Text('REGISTER', style: TextStyle(fontSize: 16.sp)),
        );
      },
    );
  }

  Widget _buildSocialButton(String text, String iconPath) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        minimumSize: Size(double.infinity, 40.h),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconPath, height: 20.h),
          SizedBox(width: 10.w),
          Text(text, style: TextStyle(fontSize: 14.sp, color: Colors.black)),
        ],
      ),
    );
  }
}
