import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_task/controllers/user_controller.dart';
import 'package:job_task/services/firestore_methods.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_task/views/user_home_screen.dart';
import 'package:job_task/views/user_login_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  
 
  @override
  Widget build(BuildContext context) {
    /*
      made user side with getx 
      made admin side without getx
    */
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return  UserHomeScreen();
                  
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.deepPurpleAccent,
                ),
              );
            }

            return  UserLoginScreen();
          },
    )
    );
  }
}