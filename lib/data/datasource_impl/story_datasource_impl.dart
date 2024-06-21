import 'dart:io';

import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/data/datasources/story_datasource.dart';
import 'package:charterer/data/models/story_model.dart';
import 'package:charterer/data/models/user_model.dart';
import 'package:charterer/data/repositories/common_firebase_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
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
      var storyId = const Uuid().v1();
      String uid = auth.currentUser!.uid;

      String imageUrl = await commonFirebaseStorageRepository
          .storeFileToFirebase('/stories/$storyId$uid', storyImage);

      List<Contact> contacts = [];
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(
            withProperties: true, withPhoto: true);
      }
      List<String> uidWhoCanSee = [];
// looping through coontacts and checking if the contact is in the firestore
      for (int i = 0; i < contacts.length; i++) {
        var userDataFirebase = await firestore
            .collection('users')
            .where('phoneNumber', isEqualTo: contacts[i].phones[0].number)
            .get();
        if (userDataFirebase.docs.isNotEmpty) {
          // converting the data to UserModel
          var userData = UserModel.fromMap(userDataFirebase.docs[0].data());
          uidWhoCanSee.add(userData.uid);
        }
      }

      List<String> storyImageUrls = [];
      var storySnapshot = await firestore
          .collection('stories')
          .where('uid', isEqualTo: auth.currentUser!.uid)
          .get();

      if (storySnapshot.docs.isNotEmpty) {
        StoryModel storyModel =
            StoryModel.fromMap(storySnapshot.docs[0].data());
        storyImageUrls = storyModel.photoUrl;
        // if story image is already availabe then add the new image to the list
        storyImageUrls.add(imageUrl);
        await firestore
            .collection('stories')
            .doc(storySnapshot.docs[0].id)
            .update({
          'photoUrl': storyImageUrls,
        });
        return;
      } else {
        // if story image is not available then create a new story
        storyImageUrls = [imageUrl];
      }

      StoryModel storyModel = StoryModel(
        uid: auth.currentUser!.uid,
        username: username,
        profilePic: profilePic,
        phoneNumber: phoneNumber,
        photoUrl: storyImageUrls,
        whoCanSee: uidWhoCanSee,
        createdAt: DateTime.now(),
        storyId: storyId,
      );

      await firestore
          .collection('stories')
          .doc(storyId)
          .set(storyModel.toMap());
    } catch (e) {
      // ignore: use_build_context_synchronously
      Helpers.showSnackBar(context: context, content: e.toString());
    }
  }

  @override
  Future<List<StoryModel>> getStories(BuildContext context) {
    throw UnimplementedError();
  }
}
