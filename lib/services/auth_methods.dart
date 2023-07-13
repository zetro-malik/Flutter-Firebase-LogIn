
import 'dart:typed_data';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_task/controllers/user_controller.dart';
import 'package:job_task/services/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_task/models/user.dart' as model;
import 'package:get/get.dart';
import 'package:job_task/utils/utils.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  UserController userController = Get.put(UserController());


  signInWithGoogle()async{
  try{

    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

  final GoogleSignInAuthentication gAuth = await gUser!.authentication;

  final creds  =  GoogleAuthProvider.credential(
    accessToken: gAuth.accessToken,
    idToken: gAuth.idToken
  );
  await _auth.signInWithCredential(creds);
   
  }catch(e){
    customSnackBar("ERROR", e.toString());

  }
  }


  Future<model.User> getUserDetail() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snapshot =
        await _firestore.collection('Users').doc(currentUser.uid).get();
    return model.User.fromMap(snapshot.data() as Map<String, dynamic>);
  }

  //sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
    required Uint8List file,
  }) async {
    String res = 'some error occured';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          name.isNotEmpty ||
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(cred.user!.uid);

        String photoUrl =
            await StorageMethods().uploadImageToStorage('profilePics', file);

        model.User user = model.User(
            email: email,
            ID: cred.user!.uid,
            photoUrl: photoUrl,
            name: name,
            password: password);

        await _firestore
            .collection('Users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        //
        res = "success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'the email is badly formated';
      } else if (err.code == "email-already-in-use") {
        res = "bro ??? you alread have an account";
      }
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  resetPassword(email)async {
    await _auth.sendPasswordResetEmail(email:email );
  }

//logging in usser

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "success";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "please enter all the fields";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == "user-not-found") {
        res = "no such user";
      } else if (err.code == "wrong-password") {
        res = "wrong password";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
     if (GoogleSignIn().currentUser != null) {
      await GoogleSignIn().signOut();
    }

    try {
      await GoogleSignIn().disconnect();
    } catch (e) {
      print(e);
    }
    await _auth.signOut();
  }

  //sign up user
  Future<String> updateProfile({
    required String email,
    required String password,
    required String name,
    required Uint8List? file,
  }) async {
    String res = 'some error occured';
    try {
      String? photoUrl = "";
      if (file != null) {
        photoUrl = await StorageMethods().uploadImageToStorage('profilePics', file);
      } else {
        photoUrl = userController.user.value.photoUrl;
      }

      model.User user = model.User(
          email: email,
          ID: FirebaseAuth.instance.currentUser!.uid,
          photoUrl: photoUrl,
          name: name,
          password: password);

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(user.toJson());

      res = "success";
    } catch (err) {
      res = err.toString();
    }

    return res;
  }
}
