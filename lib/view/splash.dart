import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../route/pageroute.dart';
import '../utils/image.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _currentIndex = 0;
  final List<String> _images = [
    ImagePath.splash1,
    ImagePath.splash2,
    ImagePath.splash3,
    ImagePath.splash4
  ];

  @override
  void initState() {
    super.initState();
    // Change the image every 1 second with animation
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_currentIndex < _images.length - 1) {
        setState(() {
          _currentIndex++;
        });
      } else {
        timer.cancel(); // Stop the timer when we reach the last image
        Future.delayed(Duration(seconds: 1), () {
          // Navigate to the next screen after the last image
           Navigator.pushReplacementNamed(context, RoutePath.onboard);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 800),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: Image.asset(
            _images[_currentIndex],
            key: ValueKey<String>(_images[_currentIndex]),
            height: 250.h,
            width: 250.h,
          ),
        ),
      ),
    );
  }
}
