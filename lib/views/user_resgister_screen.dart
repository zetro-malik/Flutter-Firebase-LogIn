import 'dart:io';
import 'dart:typed_data';

import 'package:job_task/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../widgets/custom_btn.dart';
import '../widgets/text_field.dart';

class UserRegisterScreen extends StatelessWidget {
 

  final UserController userController = Get.put(UserController());

  final TextEditingController nameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController= new TextEditingController();

  getCircleAvatar(){
    return Stack(  
                  children: [
                    Obx(() {
                      return userController.imageFile.isNotEmpty
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: FileImage(File(userController.imageFile.toString())),
                          )
                        :   const  CircleAvatar(
                            radius: 64,
                            backgroundImage: AssetImage("assets/images/user.png"),
                          );
                    }),
                    Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                          onPressed: userController.selectImage,
                          icon: Icon(Icons.add_a_photo,color: Colors.black,),
                        ))
                  ],
                );
  }



  @override
  Widget build(BuildContext context) {
    print(userController.imageFile);
    return  Scaffold(
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
          padding: const EdgeInsets.only(left :50.0, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               
           getCircleAvatar(),
           const SizedBox(height: 40),
            CustomTextField(controller: nameController, hintText: "Name",icon: const Icon(Icons.person), textHide: false),
           const SizedBox(height: 20),
           CustomTextField(controller: emailController, hintText: "email",icon:const Icon(Icons.email),textHide:false),
           const SizedBox(height: 20),
           CustomTextField(controller: passwordController, hintText: "password",icon:const Icon(Icons.password), textHide: true),
           const SizedBox(height: 20),
           CustomElevatedButton(text: "Sign up", onPressed: () async {
             FocusManager.instance.primaryFocus?.unfocus();
            await userController.signup(nameController.text.toString(), emailController.text.toString(), passwordController.text.toString(), userController.imageFile.toString());
           }, buttonColor: Colors.deepPurpleAccent, textStyle:const TextStyle(fontSize: 18),width: 150,),
           const SizedBox(height: 20),
           
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Already have an account? ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal,color: Colors.grey[700]),),
              GestureDetector(
                onTap: () => Get.back(),
                child: Text("Log In",style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal,color: Colors.blue[700]),
              )
            ),  
              ]),     
           const SizedBox(height: 100),
           
        
        
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