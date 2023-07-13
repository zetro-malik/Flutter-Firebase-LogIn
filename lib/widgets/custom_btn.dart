import 'package:job_task/controllers/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomElevatedButton extends StatelessWidget {
 
  final UserController userController =Get.find();
  
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;
  final double width;
  final double height;
  final TextStyle textStyle;

   CustomElevatedButton({
    required this.text,
    required this.onPressed,
    required this.buttonColor,
    this.width = 200.0,
    this.height = 48.0,
    this.textStyle = const TextStyle(),
  });

  @override
  Widget build(BuildContext context) {
      
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child:Obx(() => userController.isLoading.isFalse ? Text(
            text,
            style: textStyle,
          ):const CircularProgressIndicator()
          )
        ),
      ),
    );
  }
}
