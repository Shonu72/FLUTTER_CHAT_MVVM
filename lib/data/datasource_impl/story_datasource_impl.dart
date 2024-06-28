// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/data/datasources/story_datasource.dart';
import 'package:charterer/data/models/story_model.dart';
import 'package:charterer/data/models/user_model.dart';
import 'package:charterer/data/repositories/common_firebase_repo.dart';
import 'package:charterer/presentation/getx/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class StoryDataSourceImpl implements StoryDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  StoryDataSourceImpl({
    required this.firestore,
    required this.auth,
  });

  @override
  Future<void> uploadStory({
    required String username,
    required String profilePic,
    required String phoneNumber,
    required File storyImage,
    required BuildContext context,
  }) async {
    try {
      final AuthControlller authController = Get.find<AuthControlller>();
      final currentUser = await authController.getCurrentUser();
      var storyId = const Uuid().v1();
      String uid = currentUser!.uid;
      // String phoneNumber = auth.currentUser!.phoneNumber!;
      String imageurl =
          await commonFirebaseStorageRepository.storeFileToFirebase(
        '/stories/$storyId$uid',
        storyImage,
      );
      List<Contact> contacts = [];

      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(
          withProperties: true,
          withPhoto: true,
        );
      }

      print("contacts length : ${contacts.length}");

      List<String> uidWhoCanSee = [];

      // for (int i = 0; i < contacts.length; i++) {
      var userDataFirebase = await firestore
          .collection('users')
          // .where('phoneNumber', isEqualTo: contacts[i].phones[0].number)
          .get();
      // print("userData: ${contacts[i].phones[0].number}");
      if (userDataFirebase.docs.isNotEmpty) {
        for (var doc in userDataFirebase.docs) {
          var userData = UserModel.fromMap(doc.data());
          if (userData.uid != currentUser.uid) {
            uidWhoCanSee.add(userData.uid);
            print("userData.uid: ${userData.uid}");
          }
        }
        // }
      }

      List<String> storyImageUrls = [];

      var storySnapshot = await firestore
          .collection('stories')
          .where(
            'uid',
            isEqualTo: currentUser.uid,
          )
          .get();

      if (storySnapshot.docs.isNotEmpty) {
        // converting snapshot to model
        StoryModel story = StoryModel.fromMap(storySnapshot.docs[0].data());
        storyImageUrls = story.photoUrl;
        storyImageUrls.add(imageurl);
        await firestore
            .collection('stories')
            .doc(storySnapshot.docs[0].id)
            .update({
          'photoUrl': storyImageUrls,
        });
        return;
      } else {
        storyImageUrls = [imageurl];
      }

      StoryModel story = StoryModel(
        uid: uid,
        username: username,
        phoneNumber: phoneNumber,
        photoUrl: storyImageUrls,
        createdAt: DateTime.now(),
        profilePic: profilePic,
        storyId: storyId,
        whoCanSee: uidWhoCanSee,
      );

      await firestore.collection('stories').doc(storyId).set(story.toMap());
      print("upload ho gya : ${story.toMap()}");
    } catch (e, stackTrace) {
      debugPrint("Error: ${e.toString()}");
      debugPrint("StackTrace: ${stackTrace.toString()}");
      Helpers.toast("Something went wrong, try again later");
    }
  }

  @override
  Future<List<StoryModel>> getStories() async {
    List<StoryModel> storyData = [];
    try {
      final AuthControlller authController = Get.find<AuthControlller>();
      final currentUser = await authController.getCurrentUser();
      List<Contact> contacts = [];
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(
            withProperties: true, withPhoto: true);
      }
      // for (int i = 0; i < contacts.length; i++) {
      var storySnapshot = await firestore
          .collection('stories')
          // .where(
          //   'phoneNumber',
          //   isEqualTo: contacts[i].phones[0].number.replaceAll(
          //         ' ',
          //         '',
          //       ),
          // )
          .where(
            'createdAt',
            isGreaterThan: DateTime.now()
                .subtract(const Duration(hours: 24))
                .millisecondsSinceEpoch,
          )
          .get();
      for (var tempData in storySnapshot.docs) {
        StoryModel tempStory = StoryModel.fromMap(tempData.data());
        if (tempStory.whoCanSee.contains(currentUser!.uid)) {
          storyData.add(tempStory);
        }
      }
      // }
    } catch (e) {
      print("loading me problem : ${e.toString()}");
      // Helpers.toast("loading me problem : ${e.toString()}");
    }
    debugPrint("storyData.length: ${storyData.length}");
    debugPrint("storyData.toString(): ${storyData.toString()}");
    return storyData;
  }
}
