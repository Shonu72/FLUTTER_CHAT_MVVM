import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/presentation/screens/widgets/auth_text_field_widget.dart';
import 'package:charterer/presentation/screens/widgets/button_widget.dart';
import 'package:charterer/presentation/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        title: const AppText(
          text: "Edit Profile",
          size: 24,
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/boy.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          AuthTextFieldWidget(
              hintText: "Name",
              labelText: "Enter your name",
              controller: nameController,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter email";
                }
                return null;
              },
              keyboardType: TextInputType.name,
              prefixIcon: Icon(Icons.person)),
          AuthTextFieldWidget(
              hintText: "Phone number",
              labelText: "Enter your phone number",
              controller: phoneController,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter phone number";
                }
                return null;
              },
              keyboardType: TextInputType.number,
              prefixIcon: Icon(Icons.phone_android_outlined)),
          SizedBox(
            height: 10,
          ),
          AppButton(
              color: textTunaBlueColor,
              text: "Save",
              onPressed: () {
                Get.back();
              })
        ],
      ),
    );
  }
}
