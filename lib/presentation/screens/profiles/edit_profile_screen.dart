import 'dart:io';

import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/presentation/getx/controllers/auth_controller.dart';
import 'package:charterer/presentation/screens/auth/widgets/auth_text_field_widget.dart';
import 'package:charterer/presentation/screens/auth/widgets/button_widget.dart';
import 'package:charterer/presentation/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final authController = Get.find<AuthControlller>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  File? image;

void selectImage() async {
    image = await Helpers.pickImageFromGallery(context);
    setState(() {});
  }

void storeUserData() async{
  final name = nameController.text;
  final phone = phoneController.text;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        title: const AppText(
          text: "Complete your Profile",
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
              image == null
                  ? const CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png',
                      ),
                      radius: 64,
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
