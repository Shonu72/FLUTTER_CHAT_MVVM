import 'dart:io';

import 'package:file_picker/file_picker.dart';
// import 'package:enough_giphy_flutter/enough_giphy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'failure.dart';

enum RequestType { get, post, delete }

class Helpers {
  static toast(String text) {
    return Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static saveUser({required String key, required bool value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static validateEmail(String value) {
    if (value.isEmpty) {
      return "field required";
    }
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@'
        r'((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]'
        r'+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(value)) {
      return null;
    }
    return 'invalid email';
  }

  static validateField(String value) {
    if (value.isEmpty || value == 'null') {
      return "field required";
    }
    return null;
  }

  static validatePhone(String value) {
    if (value.length < 10 || value.length > 10) {
      return 'Please Enter Valid Mobile Number';
    } else {
      return null;
    }
  }

  static showSnackBar(
      {required BuildContext context, required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }

  static Future<File?> pickImageFromGallery(BuildContext context) async {
    File? image;
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        image = File(pickedImage.path);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, content: e.toString());
    }
    return image;
  }

  static Future<File?> pickVideoFromGallery(BuildContext context) async {
    File? video;
    try {
      final pickedVideo =
          await ImagePicker().pickVideo(source: ImageSource.gallery);

      if (pickedVideo != null) {
        video = File(pickedVideo.path);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, content: e.toString());
    }
    return video;
  }

  static Future<File?> pickFiles(BuildContext context) async {
    File? file;
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );

      if (result != null && result.files.single.path != null) {
        file = File(result.files.single.path!);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context: context, content: e.toString());
    }
    return file;
  }
 static Future<bool> checkPermissions() async {
    PermissionStatus cameraStatus = await Permission.camera.status;
    PermissionStatus microphoneStatus = await Permission.microphone.status;
    return cameraStatus.isGranted && microphoneStatus.isGranted;
  }

static  Future<void> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
    ].request();

    if (statuses[Permission.camera]!.isDenied ||
        statuses[Permission.microphone]!.isDenied) {
      Helpers.toast("Permissions are required to make a call");
    }
  }
  static String convertFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    }
    return "Unknown error occurred";
  }

  static loader() {
    SmartDialog.showLoading();
  }

  static hideLoader() {
    SmartDialog.dismiss();
  }
}
