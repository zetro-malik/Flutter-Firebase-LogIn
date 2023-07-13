import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:job_task/controllers/user_controller.dart';
import 'package:job_task/widgets/custom_btn.dart';
import 'package:job_task/widgets/text_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();

  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              const Text('Please enter you email.',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,letterSpacing: 0.2),),
              const SizedBox(height: 20,),
              CustomTextField(controller: emailController, hintText: 'email', icon: const Icon(Icons.email), textHide: false),
              const SizedBox(height: 20,),
              CustomElevatedButton(text: 'Reset Password', onPressed: () =>userController.resetPassword(emailController.text) , buttonColor: Colors.deepPurpleAccent)
          ],
        ) ,
      ),

    );
  }
}