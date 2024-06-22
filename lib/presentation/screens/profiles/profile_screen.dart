import 'package:cached_network_image/cached_network_image.dart';
import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/presentation/getx/controllers/auth_controller.dart';
import 'package:charterer/presentation/getx/routes/routes.dart';
import 'package:charterer/presentation/screens/auth/widgets/button_widget.dart';
import 'package:charterer/presentation/widgets/app_text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userController = Get.find<AuthControlller>();
  TextEditingController nameController = TextEditingController();
  final args = Get.arguments as Map<String, dynamic>;

  @override
  Widget build(BuildContext context) {
    final name = args['name'];
    final profilePic = args['profilePic'];
    final phoneNumber = args['phoneNumber'];
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: backgroundDarkColor,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 37, 34, 51),
        title: const AppText(
          text: "Profile",
          size: 24,
          color: Colors.white,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.editProfile);
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            CircleAvatar(
              radius: 60,
              backgroundImage: CachedNetworkImageProvider(profilePic),
              backgroundColor: Colors.blue,
            ),
            const SizedBox(
              height: 10,
            ),
            AppText(
              text: name,
              color: Colors.white,
              size: 30,
            ),
            AppText(
              text: user?.email ?? "User",
              color: Colors.grey,
            ),
            const SizedBox(
              height: 10,
            ),
            AppText(
              text: phoneNumber,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 10,
            ),
            AppButton(
                color: Colors.blue,
                text: "Sign Out",
                onPressed: () {
                  userController.signOut();
                  Helpers.saveUser(key: "isLoggedIn", value: false);
                  Get.offAllNamed(Routes.login);
                }),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
