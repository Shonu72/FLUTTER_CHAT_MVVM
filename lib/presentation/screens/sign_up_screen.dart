import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/domain/entities/auth_service.dart';
import 'package:charterer/presentation/getx/controllers/auth_controller.dart';
import 'package:charterer/presentation/getx/routes/routes.dart';
import 'package:charterer/presentation/screens/login_screen.dart';
import 'package:charterer/presentation/screens/main_page.dart';
import 'package:charterer/presentation/screens/widgets/auth_text_field_widget.dart';
import 'package:charterer/presentation/screens/widgets/button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController mailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isSigningUp = false;

  AuthController authController = Get.find<AuthController>();

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
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: textWhiteColor,
            ),
          )),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Register to Chatter",
                style: TextStyle(color: textWhiteColor, fontSize: 30),
              ),
              const SizedBox(height: 20),
              AuthTextFieldWidget(
                prefixIcon: const Icon(Icons.person),
                keyboardType: TextInputType.name,
                hintText: "Name",
                labelText: "Enter your name",
                controller: nameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter name";
                  }
                  return null;
                },
              ),
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
                prefixIcon: const Icon(Icons.phone_android_outlined),
                keyboardType: TextInputType.number,
                hintText: "Phone Number",
                labelText: "Enter your phone number",
                controller: phoneController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter phone";
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
              AuthTextFieldWidget(
                prefixIcon: const Icon(Icons.lock),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                hintText: "Confirm Password",
                labelText: "Confirm your password",
                controller: confirmPasswordController,
                validator: (value) {
                  if (passwordController.text !=
                      confirmPasswordController.text) {
                    return "Password does not match";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              AppButton(
                color: Colors.blue,
                text: "Register",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _register();
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.grey,
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
                    "Already have an account?",
                    style: TextStyle(color: textWhiteColor, fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.offNamed(Routes.login);
                    },
                    child: const Text(
                      "login",
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

  void _signUp() async {
    setState(() {
      _isSigningUp = true;
    });

    User? user = await FirebaseAuthHelper.registerUsingEmailPassword(
      name: nameController.text,
      email: mailController.text,
      phone: phoneController.text,
      password: passwordController.text,
      confirmpassword: confirmPasswordController.text,
    );

    setState(() {
      _isSigningUp = false;
    });

    if (user != null) {
      print("User registered successfully");
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Account Created "),
        ),
      );
      Get.toNamed(Routes.mainPage, arguments: user);
    }
  }

  Future<void> _register() async {
    var body = {
      "name": nameController.text.trim(),
      "email": mailController.text.trim(),
      "phone": phoneController.text.trim(),
      "password": passwordController.text.trim(),
      "confirmpassword": confirmPasswordController.text.trim(),
    };

  }
}
