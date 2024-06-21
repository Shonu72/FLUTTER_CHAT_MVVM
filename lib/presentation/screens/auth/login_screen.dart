import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/presentation/getx/controllers/auth_controller.dart';
import 'package:charterer/presentation/getx/routes/routes.dart';
import 'package:charterer/presentation/screens/auth/widgets/auth_text_field_widget.dart';
import 'package:charterer/presentation/screens/auth/widgets/button_widget.dart';
import 'package:charterer/presentation/widgets/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController mailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final userController = Get.find<AuthControlller>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Get.dialog(const CustomLoadingWidget(),
                        barrierDismissible: false);
                    await userController.signInWithEmailPassword(
                        mailController.text, passwordController.text);

                    Helpers.saveUser(key: "isLoggedIn", value: true);
                    Get.toNamed(Routes.mainPage);
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
                      Get.toNamed(Routes.signup);
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
}
