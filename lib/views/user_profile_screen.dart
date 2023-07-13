import 'dart:io';

import 'package:job_task/widgets/custom_btn.dart';
import 'package:job_task/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../controllers/user_controller.dart';

class UserProfileScreen extends StatelessWidget {
  
 
  final UserController userController = Get.find();

  final TextEditingController nameController = new TextEditingController();
  





  getCircleAvatar(){
    return Stack(  
                  children: [
                    Obx(() {
                      return userController.imageFile.isNotEmpty
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: FileImage(File(userController.imageFile.toString())),
                          )
                        :    CircleAvatar(
                            radius: 64,
                            backgroundImage: NetworkImage(userController.user.value.photoUrl),
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
bool init = false;
    void initVars(){
      if (!init){
        userController.imageFile.value ="";
        nameController.text = userController.user.value.name;
        init = true;
      }
    }

  @override
  Widget build(BuildContext context) {

    initVars();
    return  Scaffold(
       resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        title: const Text("User Profile"),
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
           CustomElevatedButton(text: "Update", onPressed: () async {
             FocusManager.instance.primaryFocus?.unfocus();
            await userController.updateUser(nameController.text.toString(), userController.user.value.email, userController.user.value.password, userController.imageFile.toString());
           }, buttonColor: Colors.deepPurpleAccent, textStyle:const TextStyle(fontSize: 18),width: 150,),
           const SizedBox(height: 20),

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

  
   
  }
}