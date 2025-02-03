import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/image.dart';
import '../component/myTextForm.dart';
import '../provider/login/login_bloc.dart';
import '../route/pageroute.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool passwordVisible = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {

          if (state is LoginSuccess) {
            Navigator.pushReplacementNamed(context, RoutePath.myNavbarScreen);
          } else if (state is LoginFailure) {
            Utils.snackbarToast(state.error);
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
                    'Log In',
                    style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Enter your registered email & password',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                  SizedBox(height: 30.h),
                  _buildEmailField(),
                  SizedBox(height: 15.h),
                  _buildPasswordField(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.pushNamed(context, RoutePath.forgotPassword),
                      child: Text('Forgot Password?'),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  _buildLoginButton(context),
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
                      Text('New user? '),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, RoutePath.register),
                        child: Text(
                          'Register',
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
      inputFormatters: [LengthLimitingTextInputFormatter(30)],
      keyboardType: TextInputType.emailAddress,
      validator: true,
      validatorFunc: Utils.emailValidator(),
      prefix: const Icon(Icons.email_outlined),
      onChanged: (String) {},
    );
  }

  Widget _buildPasswordField() {
    return MyTextForm(
      prefix: const Icon(Icons.lock_open_outlined),
      inputFormatters: [LengthLimitingTextInputFormatter(16)],
      label: 'Password',
      controller: _passwordController,
      keyboardType: TextInputType.text,
      validatorLabel: 'password',
      suffix: IconButton(
        color: Colors.grey,
        icon: Icon(passwordVisible ? Icons.visibility_off : Icons.visibility),
        onPressed: () => setState(() => passwordVisible = !passwordVisible),
      ),
      obscured: passwordVisible,
      validator: true,
      maxline: 1, onChanged: (String ) {  },
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state is LoginLoading
            ? CircularProgressIndicator()
            : ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              BlocProvider.of<LoginBloc>(context).add(
                LoginUser(
                  email: _emailController.text.toString(),
                  password: _passwordController.text.toString(),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            minimumSize: Size(double.infinity, 50.h),
          ),
          child: Text('LOGIN', style: TextStyle(fontSize: 16.sp)),
        );
      },
    );
  }

  Widget _buildSocialButton(String text, String iconPath) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(minimumSize: Size(double.infinity, 40.h)),
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
