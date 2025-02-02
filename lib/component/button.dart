import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyButton extends StatelessWidget {
  final String? text;
  final void Function()? onTap;
  final Color? color;
  final Color? textColor;
  final double? height;
  final double? width;

  // Constructor
  const MyButton({
    Key? key,
    this.text,
    this.onTap,
    this.color,
    this.textColor,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text == null
                ? SizedBox()
                : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                                text!,
                                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                                ),
                              ),
                ),
          ],
        ),
      ),
    );
  }
}
