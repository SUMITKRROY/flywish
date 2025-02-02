import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool action;

  MyAppBar({this.action = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: preferredSize.height,
leadingWidth: 70.w,
      leading: Container(
        margin: const EdgeInsets.all(8.0),
        height: 50.h,
        width: 50.w,
        child: Image.asset(
          "assets/images/spars_app_logo.png",
          fit: BoxFit.cover,
        ),
      ),
      titleSpacing: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text(
            "Department of Reproductive Biology",
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "AIIMS New Delhi",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
      actions: action
          ? [
        IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: () {
            // Add functionality for favorite icon
          },
        ),
      ]
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(65.h);
}
