import 'dart:io';

import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/data/datasources/group_data_source.dart';
import 'package:charterer/data/models/group_model.dart';
import 'package:charterer/data/repositories/common_firebase_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:uuid/uuid.dart';

class GroupDataSourceImpl implements GroupDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  GroupDataSourceImpl({
    required this.auth,
    required this.firestore,
  });

  @override
  Future<void> createGroup(
      String name, File groupPic, List<Contact> selectedContact) async {
    try {
      List<String> uids = [];
      for (int i = 0; i < selectedContact.length; i++) {
        var userCollection = await firestore
            .collection('users')
            .where(
              'phoneNumber',
              isEqualTo: selectedContact[i].phones[0].number.replaceAll(
                    ' ',
                    '',
                  ),
            )
            .get();

        print("userCollection: ${userCollection.docs}");

        if (userCollection.docs.isNotEmpty && userCollection.docs[0].exists) {
          uids.add(userCollection.docs[0].data()['uid']);
        } else {
          Helpers.toast(
            "Contact not found for this app, Try adding them as a friend first.",
          );
          return;
        }
      }
      var groupId = const Uuid().v1();
      String profileUrl =
          await commonFirebaseStorageRepository.storeFileToFirebase(
        'group/$groupId',
        groupPic,
      );

      Group group = Group(
        senderId: auth.currentUser!.uid,
        name: name,
        groupId: groupId,
        lastMessage: '',
        groupPic: profileUrl,
        membersUid: [auth.currentUser!.uid, ...uids],
        timeSent: DateTime.now(),
      );

      await firestore.collection('groups').doc(groupId).set(group.toMap());
      Helpers.toast("Group Created Successfully");
    } catch (e) {
      print("Error: ${e.toString()}");
      Helpers.toast(e.toString());
    }
  }
}
