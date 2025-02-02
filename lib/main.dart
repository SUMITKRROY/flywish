import 'package:dually/provider/forget_password/forgetpassword_bloc.dart';
import 'package:dually/provider/login/login_bloc.dart';
import 'package:dually/provider/register/register_bloc.dart';
import 'package:dually/route/pageroute.dart';
import 'package:dually/route/route_generater.dart';
import 'package:dually/view/register/register_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/theamdata.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<ForgetpasswordBloc>(
          create: (context) => ForgetpasswordBloc(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          initialRoute: RoutePath.splash,
          onGenerateRoute: MyRoutes.generateRoute,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: lightMode,
          // home: ProfileRegisterScreen(),
        ),
      ),
    );
  }
}
