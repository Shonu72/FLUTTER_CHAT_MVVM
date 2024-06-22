import 'dart:io';

import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/presentation/getx/controllers/auth_controller.dart';
import 'package:charterer/presentation/getx/routes/routes.dart';
import 'package:charterer/presentation/screens/auth/widgets/auth_text_field_widget.dart';
import 'package:charterer/presentation/screens/auth/widgets/button_widget.dart';
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
  File? image;

  void selectImage() async {
    image = await Helpers.pickImageFromGallery(context);
    setState(() {});
  }

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
              Stack(
                children: [
                  image == null
                      ? const CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png',
                          ),
                          radius: 64,
                          backgroundColor: Colors.blue,
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(
                            image!,
                          ),
                          radius: 64,
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ],
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
                    // Get.dialog(const CustomLoadingWidget(),
                    //     barrierDismissible: false);

                    await userController.signUpWithEmailPassword(
                      image,
                      nameController.text,
                      mailController.text,
                      "+91${phoneController.text}",
                      passwordController.text,
                      confirmPasswordController.text,
                    );
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
