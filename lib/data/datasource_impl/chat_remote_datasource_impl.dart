import 'dart:io';

import 'package:charterer/core/utils/enums.dart';
import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/data/datasources/chat_remote_datasource.dart';
import 'package:charterer/data/models/chat_contact_model.dart';
import 'package:charterer/data/models/messages_model.dart';
import 'package:charterer/data/models/user_model.dart';
import 'package:charterer/data/repositories/common_firebase_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatRemoteDataSourceImpl({
    required this.firestore,
    required this.auth,
  });

  @override
  Stream<List<ChatContact>> getChatContacts() {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap((event) async {
      List<ChatContact> contacts = [];
      for (var document in event.docs) {
        var chatContact = ChatContact.fromMap(document.data());
        var userData = await firestore
            .collection('users')
            .doc(chatContact.contactId)
            .get();
        var user = UserModel.fromMap(userData.data()!);

        contacts.add(
          ChatContact(
            name: user.name,
            profilePic: user.profilePic,
            contactId: chatContact.contactId,
            timeSent: chatContact.timeSent,
            lastMessage: chatContact.lastMessage,
          ),
        );
      }
      return contacts;
    });
  }

  @override
  Stream<List<Message>> getChatStream(String receiverUserId) {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverUserId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<Message> messages = [];
      for (var document in event.docs) {
        messages.add(Message.fromMap(document.data()));
      }
      return messages;
    });
  }

  @override
  Future<void> sendTextMessage({
    required BuildContext context,
    required String text,
    required String receiverUserId,
  }) async {
    var timeSent = DateTime.now();
    var messageId = const Uuid().v1();

    var senderUserData =
        await firestore.collection('users').doc(auth.currentUser!.uid).get();
    var senderUser = UserModel.fromMap(senderUserData.data()!);

    var receiverUserData =
        await firestore.collection('users').doc(receiverUserId).get();
    var receiverUser = UserModel.fromMap(receiverUserData.data()!);

    await _saveDataToContactsSubcollection(
      senderUser,
      receiverUser,
      text,
      timeSent,
      receiverUserId,
      false,
    );

    await _saveMessageToMessageSubcollection(
      receiverUserId: receiverUserId,
      text: text,
      timeSent: timeSent,
      messageId: messageId,
      username: senderUser.name,
      messageType: MessageEnum.text,
      senderUsername: senderUser.name,
      receiverUserName: receiverUser.name,
    );
  }

  Future<void> _saveDataToContactsSubcollection(
    UserModel senderUserData,
    UserModel receiverUserData,
    String text,
    DateTime timeSent,
    String receiverUserId,
    bool isGroupChat,
  ) async {
    var senderChatContact = ChatContact(
      name: receiverUserData.name,
      profilePic: receiverUserData.profilePic,
      contactId: receiverUserData.uid,
      timeSent: timeSent,
      lastMessage: text,
    );

    var receiverChatContact = ChatContact(
      name: senderUserData.name,
      profilePic: senderUserData.profilePic,
      contactId: senderUserData.uid,
      timeSent: timeSent,
      lastMessage: text,
    );

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverUserId)
        .set(senderChatContact.toMap());

    await firestore
        .collection('users')
        .doc(receiverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set(receiverChatContact.toMap());
  }

  Future<void> _saveMessageToMessageSubcollection({
    required String receiverUserId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required String username,
    required MessageEnum messageType,
    required String senderUsername,
    required String receiverUserName,
  }) async {
    final message = Message(
      senderId: auth.currentUser!.uid,
      recieverid: receiverUserId,
      text: text,
      type: messageType,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
    );

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverUserId)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());

    await firestore
        .collection('users')
        .doc(receiverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());
  }

  @override
  Future<void> sendFileMessage({
    required BuildContext context,
    required File file,
    required String receiverUserId,
    // required UserModel senderUserData,
    required MessageEnum messageEnum,
  }) async {
    try {
      var timeSent = DateTime.now();
      var messageId = const Uuid().v1();
      var senderUserData =
          await firestore.collection('users').doc(auth.currentUser!.uid).get();
              var senderUser = UserModel.fromMap(senderUserData.data()!);

      String fileUrl = await commonFirebaseStorageRepository.storeFileToFirebase(
          'chat/${messageEnum.type}/${senderUser.uid}/$receiverUserId/$messageId',
          file);

      UserModel receiverUserData;
      var userDataMap =
          await firestore.collection('users').doc(receiverUserId).get();
      receiverUserData = UserModel.fromMap(userDataMap.data()!);

      String contactMsg;

      switch (messageEnum) {
        case MessageEnum.image:
          contactMsg = '📸 Image';
          break;
        case MessageEnum.audio:
          contactMsg = '🎵 Audio';
          break;
        case MessageEnum.video:
          contactMsg = '📸 Video';
          break;
        case MessageEnum.file:
          contactMsg = '📎 File';
          break;
        default:
          contactMsg = '📸 Image';
      }

    await  _saveDataToContactsSubcollection(senderUser, receiverUserData,
          contactMsg, timeSent, receiverUserId, false);

      _saveMessageToMessageSubcollection(
          receiverUserId: receiverUserId,
          text: fileUrl,
          timeSent: timeSent,
          messageId: messageId,
          username: senderUser.name,
          messageType: messageEnum,
          senderUsername: senderUser.name,
          receiverUserName: receiverUserData.name);
    } catch (e) {
      // ignore: use_build_context_synchronously
      Helpers.showSnackBar(context: context, content: e.toString());
    }
  }
}
