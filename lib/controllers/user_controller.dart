import 'dart:io';

import 'package:job_task/models/attendance.dart';
import 'package:job_task/services/auth_methods.dart';
import 'package:job_task/services/firestore_methods.dart';
import 'package:job_task/views/user_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user.dart';

import '../utils/utils.dart';

class UserController extends GetxController {
  var user = User(ID: '', email: '', password: '', photoUrl: '', name: '').obs;
  final attendanceList = RxList<Attendance>([]).obs;

  RxString imageFile = ''.obs;
  RxBool isLoading = false.obs;

  void signOut() {
    AuthMethods().signOut();
  }

  Future<void> selectImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = pickedFile.path.toString();
      update();
    }
  }

  signInWithGoogle() async {
    await AuthMethods().signInWithGoogle();
  }

  resetPassword(email) async {
    if (email == ""){
      customSnackBar("Enter Valid Email", "");
      return;
    }
    await AuthMethods().resetPassword(email);
    Get.dialog(AlertDialog(
      title: Text('Password Reset link has been sent to $email'),
      actions: [
        TextButton(
          child: const Text("Close"),
          onPressed: () => Get.back(),
        ),
      ],
    ));
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;

    String response =
        await AuthMethods().loginUser(email: email, password: password);
    response == "success"
        ? customSnackBar("Log In Successful!", "")
        : customSnackBar("ERROR", response);

    user.value = await AuthMethods().getUserDetail();
    isLoading.value = false;
  }

  Future<void> updateUser(
      String name, String email, String password, String filePath) async {
    isLoading.value = true;

    String response = await AuthMethods().updateProfile(
        email: email,
        password: password,
        name: name,
        file: filePath.isEmpty ? null : fileToUint8List(filePath));
    response == "success"
        ? customSnackBar("Updated....", "")
        : customSnackBar("ERROR", response);

    isLoading.value = false;
  }

  Future<void> signup(
      String name, String email, String password, String filePath) async {
    if (email.isEmpty || password.isEmpty || name.isEmpty || filePath.isEmpty) {
      customSnackBar("Input all fields", "");

      return;
    }

    isLoading.value = true;

    String response = await AuthMethods().signUpUser(
        email: email,
        password: password,
        name: name,
        file: fileToUint8List(filePath));
    response == "success"
        ? customSnackBar("Sign Up Successful!", "")
        : customSnackBar("ERROR", response);

    isLoading.value = false;
  }

  void setUser(User obj) {
    user.value = obj;
    update();
  }
}
