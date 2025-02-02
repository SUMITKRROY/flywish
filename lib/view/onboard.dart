import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../component/appbar.dart';
import '../component/button.dart';
import '../component/myText.dart';
import '../route/pageroute.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Welcome to Dually",
      "description": "Twice the view, double the impact",
      "image": "assets/images/onboard/onboard_1.png"
    },
    {
      "title": "Dual Camera Recording",
      "description": "Capture synchronized video/photos",
      "image": "assets/images/onboard/onboard_2.png"
    },
    {
      "title": "Social Interaction",
      "description": "Like & comment on photos in real time",
      "image": "assets/images/onboard/onboard_3.png"
    },
  ];

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _skipOnboarding() {
    // Navigate to the next screen (e.g., home page)
    print("Skip to Home Screen");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Use PageView without Expanded
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  // Image positioning adjusted here
                  Container(
                    height: 400.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(_onboardingData[index]["image"]!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _onboardingData[index]["title"]!,
                    style:   TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _onboardingData[index]["description"]!,
                    textAlign: TextAlign.center,
                    style:   TextStyle(fontSize: 18.sp,    fontWeight: FontWeight.w400,),
                  ),
                ],
              );
            },
          ),

          // Skip button
          Positioned(
            top: 40.h,
            right: 20.w,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, RoutePath.login);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              child: Text("Skip", style: TextStyle(color: Colors.blue)),
            ),
          ),

          // Onboarding indicator dots
          Positioned(
            bottom: 120.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _onboardingData.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentPage == index ? 16 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),

          // Next/Get Started button
          Positioned(
            bottom: 50.h,
            left: 20.w,
            right: 20.w,
            child: _currentPage == _onboardingData.length - 1
                ? Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, RoutePath.login);
                },
                child: MyText(
                  label: "Get Started",
                  fontSize: 16,
                  fontColor: Colors.white,
                ),
              ),
            )
                : Center(
              child: ElevatedButton(
                onPressed: _nextPage,
                child: MyText(
                  label: "Next",
                  fontSize: 16,
                  fontColor: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(String title, String subtitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.h),
        Text(
          subtitle,
          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
