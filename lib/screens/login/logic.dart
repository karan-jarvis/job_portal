import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:job_portal/screens/job_listing/view.dart';
import 'package:job_portal/screens/login/view.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:medit_app/view/bottom_bar_screen/bottombar.dart';

class LoginController extends GetxController {

  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController logEmailController = TextEditingController();
  final TextEditingController logPasswordController = TextEditingController();
  bool isLoading = false;

  var passwordVisible = false.obs;
  bool get isEmailValid => EmailValidator.validate(logEmailController.text);

  void logIn() async {
    if (formKey2.currentState!.validate()) {
      formKey2.currentState!.save();

      isLoading = true ;

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: logEmailController.text.trim(),
            password: logPasswordController.text.trim());
        Fluttertoast.showToast(
            msg:"Login successful",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );

        // Get.to(const BottomNavBarScreen());
        Get.to(JobListingPage());

      } on FirebaseAuthException catch (e) {
        isLoading = false;

        if (e.code == 'user-not-found') {

          Fluttertoast.showToast(
              msg:  "No user found for that email",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white.withOpacity(0.5),
              textColor: Colors.black,
              fontSize: 16.0
          );

        } else if (e.code == 'wrong-password') {

          Fluttertoast.showToast(
              msg: "Wrong password "
                  "provided.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white.withOpacity(0.5),
              textColor: Colors.black,
              fontSize: 16.0
          );
        } else {
          Fluttertoast.showToast(
              msg:  "Username or Password is incorrect",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white.withOpacity(0.5),
              textColor: Colors.black,
              fontSize: 16.0
          );

        }
      }
    }
  }


  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User cancelled the sign-in process
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      // Logging user details for debugging purposes
      if (kDebugMode) {
        print("User signed in: ${user?.displayName}, ${user?.email}");
      }

      // Store user data
    //  await storeData(user?.email ?? '', user?.displayName ?? googleUser.id);

      // Navigate to the login screen or any other screen after successful sign-in
      Get.to(() => JobListingPage());
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to sign in with Google: ${e.message}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }

      Fluttertoast.showToast(
        msg: "An unexpected error occurred: $error",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
  whereToGo(keyLogin) async {

    var sharedPref =  await SharedPreferences.getInstance();
    var isLoggedIn =  sharedPref.getBool(keyLogin);

    Timer(
        const Duration(seconds: 5),
    () {
          if(isLoggedIn!=null){
            if(isLoggedIn){
             Get.to(JobListingPage());
            }else{
            Get.to(LoginScreen());
            }
          }else {
            Get.to(LoginScreen());
          }
  });}

}
