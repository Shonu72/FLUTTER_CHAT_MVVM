import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/domain/entities/auth_service.dart';
import 'package:charterer/presentation/getx/controllers/auth_controller.dart';
import 'package:charterer/presentation/getx/routes/routes.dart';
import 'package:charterer/presentation/screens/login_screen.dart';
import 'package:charterer/presentation/screens/main_page.dart';
import 'package:charterer/presentation/screens/sign_up_screen.dart';
import 'package:charterer/presentation/screens/widgets/auth_text_field_widget.dart';
import 'package:charterer/presentation/screens/widgets/button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController mailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool _isSigningIn = false;
  AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void validateForm() {
      if (_formKey.currentState!.validate()) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MainPage(),
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: backgroundDarkColor,
      appBar: AppBar(
        backgroundColor: backgroundDarkColor,
        title: const Text("CHATTER", style: TextStyle(color: textWhiteColor)),
        centerTitle: true,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back,
        //     color: Colors.white,
        //   ),
        // )
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Welcome back to Chatter",
                style: TextStyle(color: textWhiteColor, fontSize: 30),
              ),
              const SizedBox(height: 20),
              AuthTextFieldWidget(
                prefixIcon: const Icon(Icons.email),
                keyboardType: TextInputType.emailAddress,
                hintText: "Email",
                labelText: "Enter your mail",
                controller: mailController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter email";
                  }
                  return null;
                },
              ),
              AuthTextFieldWidget(
                prefixIcon: const Icon(Icons.lock),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                hintText: "Password",
                labelText: "Enter password",
                controller: passwordController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter password";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              AppButton(
                color: Colors.blue,
                text: "Login",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // _login();
                     Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainPage()));
                    
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: textLightColor,
                thickness: 0.4,
                indent: 20,
                endIndent: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 20),
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: textWhiteColor, fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(color: primaryColor, fontSize: 18),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getLoggedInStatus() async {
    setState(() {});
  }

  void _signIn() async {
    setState(() {
      _isSigningIn = true;
    });

    User? user = await FirebaseAuthHelper.signInUsingEmailPassword(
      email: mailController.text,
      password: passwordController.text,
    );

    setState(() {
      _isSigningIn = false;
    });

    if (user != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('loggedIn', true);
      getLoggedInStatus();
      Get.offNamed(Routes.mainPage);
    }
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      await authController
          .login(
              email: mailController.text.trim(),
              password: passwordController.text.trim(),
              context: context)
          .then((success) async {
        if (success.status) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('loggedIn', true);
          getLoggedInStatus();
          Get.offNamed(Routes.mainPage);
        } else {
          Get.snackbar("Error", "Invalid email or password",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white);
        }
      });
    }
  }
}
