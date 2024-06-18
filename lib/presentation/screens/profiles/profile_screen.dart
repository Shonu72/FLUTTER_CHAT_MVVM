import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/presentation/getx/controllers/auth_controller.dart';
import 'package:charterer/presentation/getx/routes/routes.dart';
import 'package:charterer/presentation/screens/auth/widgets/button_widget.dart';
import 'package:charterer/presentation/widgets/app_text_widget.dart';
import 'package:charterer/presentation/widgets/profile_setting_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userController = Get.find<AuthControlller>();

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
        body: Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 34, 51),
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
          )),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                user?.photoURL ??
                    'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png',
              ),
              backgroundColor: Colors.blue,
            ),
            const SizedBox(
              height: 10,
            ),
            AppText(
              text: user?.displayName ?? "User",
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
            AppButton(
                color: Colors.blue,
                text: "Edit Profile",
                onPressed: () {
                  Get.toNamed(Routes.editProfile);
                }),
            const SizedBox(
              height: 20,
            ),
            const Divider(
                color: Colors.grey, thickness: 0.5, indent: 10, endIndent: 10),
            ProfileSettingWidget(
                onTap: () {
                  userController.signOut();
                  Helpers.saveUser(key: "isLoggedIn", value: false);
                  Get.offAllNamed(Routes.login);
                },
                text: "Logout",
                icon: Icons.logout_outlined),
          ],
        ),
      ),
    ));
  }
}
