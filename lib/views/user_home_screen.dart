import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:job_task/controllers/user_controller.dart';

class UserHomeScreen extends StatelessWidget {
  
  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        title: Text('Home Page'),
      actions: [
        IconButton(onPressed: () =>userController.signOut(),
         icon: Icon(Icons.logout))
      ],
      ),
    );
  }
}