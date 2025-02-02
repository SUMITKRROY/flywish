import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/image.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> users = [
    {"name": "Allison", "image": ImagePath.story1},
    {"name": "Davis", "image": ImagePath.story2},
    {"name": "Zaire", "image": ImagePath.story3},
    {"name": "Chance", "image": ImagePath.story4},
    {"name": "Martine", "image": ImagePath.story1},
    {"name": "joen", "image": ImagePath.story2},
  ];

  final List<Map<String, String>> posts = [
    {
      "name": "Charlie Carder",
      "profile": ImagePath.user,
      "postImage": ImagePath.postImage,

    },
    {
      "name": "Alice Johnson",
      "profile": ImagePath.user,
      "postImage": ImagePath.postImage,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 10.h),
                _buildHeader(),
                _buildUserStories(),
                ...posts.map((post) => _buildPostItem(post)).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(ImagePath.splash4, height: 60.h),
        Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Image.asset(ImagePath.me)
        ),
      ],
    );
  }

  Widget _buildUserStories() {
    return Padding(
      padding: EdgeInsets.all(8.w), // Padding around the entire ListView
      child: SizedBox(
        height: 120.h, // Height for the scrollable content
        child: ListView.builder(
          scrollDirection: Axis.horizontal, // Makes the list scroll horizontally
          itemCount: users.length, // Number of items in the list
          itemBuilder: (context, index) {
            final user = users[index];
            return Padding(
              padding: EdgeInsets.all(8.w), // Padding around each item
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(user['image']!),
                  SizedBox(height: 5.h),
                  Text(user['name']!, style: TextStyle(fontSize: 12.sp)), // Name outside the card
                ],
              ),
            );
          },
        ),
      ),
    );
  }



  Widget _buildPostItem(Map<String, String> post) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
          width: double.infinity,
          height: 280.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(post['postImage']!),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),

      ],
    );
  }
}
