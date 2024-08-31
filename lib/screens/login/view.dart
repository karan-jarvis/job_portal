import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_portal/main.dart';
import 'package:job_portal/main.dart';

import 'package:job_portal/screens/login/logic.dart';
import 'package:job_portal/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';


class LoginScreen extends StatefulWidget {

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const String kaylogin = 'login';
  final LoginController loginController = Get.put(LoginController());
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginController.whereToGo(kaylogin);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          // decoration: GradientDecoration.getBackground(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 70),
                const Text(
                  "Welcome To Medit",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 35,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Relax your mind with Medit",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.all(15),
                  child: Form(
                    key: loginController.formKey2,
                    child: Column(
                      children: [
                        /* Lottie.asset(
                          height: 300,
                          'asset/Animation - 1714198298188.json',
                          fit: BoxFit.cover,
                        ),*/
                        TextFormField(
                          controller: loginController.logEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter your Email',
                            labelStyle: const TextStyle(color: Colors.white),
                            hintStyle: const TextStyle(color: Colors.white),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            suffixIcon: const Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter an email address.";
                            }
                            if (!RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$")
                                .hasMatch(value)) {
                              return "Invalid email address.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        Obx(() => TextFormField(
                              obscureText:
                                  !loginController.passwordVisible.value,
                              controller: loginController.logPasswordController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your Password',
                                hintStyle: const TextStyle(color: Colors.white),
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    loginController.passwordVisible.toggle();
                                  },
                                  icon: Icon(
                                    loginController.passwordVisible.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter a password.";
                                }
                                if (value.length < 6) {
                                  return "Password must be at least 6 characters long.";
                                }
                                return null;
                              },
                            )),
                        const SizedBox(height: 15),
                        InkWell(
                          onTap: () async {
                            // loginController.logIn();
                             var sharedPref =
                                 await SharedPreferences.getInstance();
                                 sharedPref.setBool(_LoginScreenState.kaylogin, true);
                            loginController.logIn();
                          },
                          child: Container(
                            height: 55,
                            width: 390,
                            decoration: BoxDecoration(
                              color: AppColors.buttonColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "LogIn",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Get.to(ForgotPage());
                            },
                            child: Text(
                              "Forgot Password ?",
                              style: TextStyle(
                                color: AppColors.buttonColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "If You Don't have an account?",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                // Get.to(SignupScreen());
                              },
                              child: const Text(
                                "SignUp",
                                style: TextStyle(color: AppColors.buttonColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 45,
                      child: Container(
                        height: 0.10,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                      ),
                    ),
                    const Expanded(
                      flex: 10,
                      child: Center(
                        child: Text(
                          "OR",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 45,
                      child: Container(
                        height: 0.10,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 50)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () async {

                      var sharedPref =
                          await SharedPreferences.getInstance();
                      sharedPref.setBool(MyHomePage().kaylogin, true);
                      loginController.signInWithGoogle();
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Image(
                                image: AssetImage(
                                    "assets/images/google_icon.png")),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "LOGIN IN WITH GOOGLE",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
