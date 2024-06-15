import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/presentation/getx/controllers/auth_controller.dart';
import 'package:charterer/presentation/getx/routes/routes.dart';
import 'package:charterer/presentation/screens/login_screen.dart';
import 'package:charterer/presentation/screens/main_page.dart';
import 'package:charterer/presentation/screens/widgets/auth_text_field_widget.dart';
import 'package:charterer/presentation/screens/widgets/button_widget.dart';
import 'package:charterer/presentation/widgets/custom_loading_widget.dart';
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

  final userController = Get.find<AuthControlller>();

  @override
  Widget build(BuildContext context) {
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Get.dialog(const CustomLoadingWidget(),
                        barrierDismissible: false);

                    // User? user = await authController.register(
                    //   name: nameController.text,
                    //   email: mailController.text,
                    //   password: passwordController.text,
                    //   confirmpassword: confirmPasswordController.text,
                    //   phone: phoneController.text,
                    // );
                    await userController.signUpWithEmailPassword(
                        nameController.text,
                        mailController.text,
                        phoneController.text,
                        passwordController.text,
                        confirmPasswordController.text);
                    Helpers.saveUser(key: "isLoggedIn", value: true);
                    Helpers.toast("Account creation Successful");
                    Get.toNamed(Routes.mainPage);
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
}
