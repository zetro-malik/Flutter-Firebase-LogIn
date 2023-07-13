import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_task/controllers/user_controller.dart';
import 'package:job_task/services/auth_methods.dart';
import 'package:job_task/views/forget_password_screen.dart';
import 'package:job_task/views/user_home_screen.dart';
import 'package:job_task/views/user_resgister_screen.dart';
import 'package:job_task/widgets/custom_btn.dart';
import 'package:job_task/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
class UserLoginScreen extends StatelessWidget {

  UserController userController = Get.put(UserController());

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
 
   
    return Scaffold(
            resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        title: const Text("User Panel"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6),
              ),
              const SizedBox(height: 40),
              CustomTextField(
                  controller: emailController,
                  hintText: "email",
                  icon:const Icon(Icons.email),
                  textHide: false),
              const SizedBox(height: 20),
              CustomTextField(
                  controller: passwordController,
                  hintText: "password",
                  icon:const Icon(Icons.password),
                  textHide: true),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () => Get.to(ForgetPasswordScreen()), child: const Text('Forget Password ?'))
                ],
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                text: "Login",
                onPressed: () async {
                  await userController.login( emailController.text.toString(),  passwordController.text.toString());
                } ,
                buttonColor: Colors.deepPurpleAccent,
                textStyle: const TextStyle(fontSize: 18),
                width: 150,
              ),
              const SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Don't have an account? ",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey[700]),
                ),
                GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Get.to(UserRegisterScreen());
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.blue[700]),
                    )),
              ]),
              const SizedBox(height: 20),
              GestureDetector( 
                onTap: () async{
                 await userController.signInWithGoogle();
                } ,
                child: Image.asset('assets/images/google.png',scale: 1.8,)),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    FocusManager.instance.primaryFocus?.unfocus();
    emailController.dispose();
    passwordController.dispose();
  }
}