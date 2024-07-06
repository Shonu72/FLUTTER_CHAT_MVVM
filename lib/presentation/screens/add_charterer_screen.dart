import 'dart:io';

import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/data/models/user_model.dart';
import 'package:charterer/data/repositories/common_firebase_repo.dart';
import 'package:charterer/presentation/getx/controllers/auth_controller.dart';
import 'package:charterer/presentation/screens/auth/widgets/auth_text_field_widget.dart';
import 'package:charterer/presentation/screens/auth/widgets/button_widget.dart';
import 'package:charterer/presentation/screens/main_page.dart';
import 'package:charterer/presentation/widgets/app_text_widget.dart';
import 'package:charterer/presentation/widgets/custom_loading_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/theme/colors.dart';
import '../widgets/body_padding_widget.dart';
import '../widgets/text_fields/custom_drop_down.dart';

class AddCharterer extends StatefulWidget {
  const AddCharterer({Key? key}) : super(key: key);

  @override
  State<AddCharterer> createState() => _AddChartererState();
}

class _AddChartererState extends State<AddCharterer> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController website = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();
  final userController = Get.find<AuthControlller>();
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  final ImagePicker picker = ImagePicker();
  File? image;
  bool _isLoading = false;

  Future<void> pickImage() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  Future<void> saveContact() async {
    if (await FlutterContacts.requestPermission()) {
      Uint8List? imageBytes;
      if (image != null) {
        imageBytes = await image!.readAsBytes();
      }

      final contact = Contact()
        ..photo = imageBytes
        ..name.first = fullName.text
        ..phones = [Phone("+91${mobileNumber.text}")]
        ..emails = [Email(email.text)]
        ..addresses = [
          Address(address.text, city: city.text, state: state.text),
        ]
        ..websites = [Website(website.text)];

      await contact.insert();
    } else {
      Helpers.toast('Permission to access contacts is not granted');
      print('Permission to access contacts is not granted');
    }
  }

  Future<void> saveChaterer(File? profilePic, String name, String email,
      String phoneNumber, String password, String confirmPassword) async {
    await auth.createUserWithEmailAndPassword(
        email: email, password: passwordController.text);
    String uid = auth.currentUser!.uid;
    String photoUrl =
        'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';

    if (image != null) {
      photoUrl = await commonFirebaseStorageRepository.storeFileToFirebase(
          "profilePic/$uid", image!);
    }
    String pushToken = await FirebaseMessaging.instance.getToken() ?? '';

    var user = UserModel(
      name: name,
      uid: uid,
      profilePic: photoUrl,
      isOnline: true,
      phoneNumber: phoneNumber,
      groupId: const [],
      pushToken: pushToken,
    );
    await firestore.collection('users').doc(uid).set(user.toMap());
  }

  void clearTextFields() {
    fullName.clear();
    email.clear();
    country.clear();
    mobileNumber.clear();
    address.clear();
    state.clear();
    city.clear();
    website.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  @override
  void dispose() {
    fullName.dispose();
    email.dispose();
    country.dispose();
    mobileNumber.dispose();
    address.dispose();
    state.dispose();
    city.dispose();
    website.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDarkColor,
      appBar: AppBar(
        backgroundColor:
            backgroundDarkColor.withBlue(backgroundDarkColor.blue + 20),
        title: const AppText(
          text: "Add Charterer",
          color: whiteColor,
          size: 24,
        ),
        leading: IconButton(
            onPressed: () {
              Get.to(const MainPage(initialIndex: 0));
            },
            icon: const Icon(
              Icons.arrow_back,
              color: whiteColor,
            )),
      ),
      body: BodyPaddingWidget(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: image == null
                          ? const AssetImage('assets/images/boy.png')
                          : FileImage(image!) as ImageProvider,
                      radius: 80,
                    ),
                    Positioned(
                      right: 5,
                      bottom: 10,
                      child: IconButton(
                        onPressed: pickImage,
                        icon: const Icon(
                          Icons.add_a_photo_sharp,
                          color: whiteColor,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                AuthTextFieldWidget(
                  prefixIcon: const Icon(Icons.person),
                  keyboardType: TextInputType.name,
                  hintText: "Full name",
                  labelText: "Enter your full name",
                  controller: fullName,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter full name";
                    }
                    return null;
                  },
                ),
                AuthTextFieldWidget(
                  prefixIcon: const Icon(Icons.email),
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Email",
                  labelText: "Enter your email",
                  controller: email,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter email";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: BuildDropdown(
                    selectedValue: country,
                    dropdownHint: "select country",
                    isRequired: true,
                    itemsList: ['India']
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      country.text = value!;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                AuthTextFieldWidget(
                  prefixIcon: const Icon(Icons.phone_android_outlined),
                  keyboardType: TextInputType.phone,
                  hintText: "Phone number",
                  labelText: "Enter your phone number",
                  controller: mobileNumber,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter phone number";
                    }
                    return null;
                  },
                ),
                AuthTextFieldWidget(
                  prefixIcon: const Icon(Icons.home),
                  keyboardType: TextInputType.streetAddress,
                  hintText: "Address",
                  labelText: "Enter your address",
                  controller: address,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter address";
                    }
                    return null;
                  },
                ),
                AuthTextFieldWidget(
                  prefixIcon: const Icon(Icons.home),
                  keyboardType: TextInputType.text,
                  hintText: "State",
                  labelText: "Enter your state",
                  controller: state,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter state";
                    }
                    return null;
                  },
                ),
                AuthTextFieldWidget(
                  prefixIcon: const Icon(Icons.location_city_rounded),
                  keyboardType: TextInputType.text,
                  hintText: "City",
                  labelText: "Enter your city",
                  controller: city,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter city";
                    }
                    return null;
                  },
                ),
                AuthTextFieldWidget(
                  prefixIcon: const Icon(Icons.web_sharp),
                  keyboardType: TextInputType.url,
                  hintText: "Website",
                  labelText: "Enter your website",
                  controller: website,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter website";
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
                const SizedBox(
                  height: 10,
                ),
                _isLoading
                    ? const Center(child: CustomLoadingWidget())
                    : AppButton(
                        color: Colors.blue,
                        text: "Add Charterer",
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            setState(() {
                              _isLoading = true;
                            });
                            await saveContact();
                            // await userController.signUpWithEmailPassword(
                            //   image,
                            //   fullName.text.trim(),
                            //   email.text.trim(),
                            //   "+91${mobileNumber.text.trim()}",
                            //   passwordController.text.trim(),
                            //   confirmPasswordController.text.trim(),
                            // );
                            saveChaterer(
                              image,
                              fullName.text.trim(),
                              email.text.trim(),
                              "+91${mobileNumber.text.trim()}",
                              passwordController.text.trim(),
                              confirmPasswordController.text.trim(),
                            );

                            Helpers.toast(
                                "Charterer added to contacts successfully");
                            clearTextFields();
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        },
                      ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
