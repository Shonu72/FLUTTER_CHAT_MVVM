import 'dart:io';

import 'package:charterer/data/datasources/firebase_auth_datasource.dart';
import 'package:charterer/data/models/user_model.dart';
import 'package:charterer/data/repositories/common_firebase_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthDataSource implements AuthDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseAuthDataSource({required this.auth, required this.firestore});

  @override
  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser!.uid).get();

    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    print("userData.data:  ${userData.data()}");
    print(user);
    return user;
  }

  @override
  Future<void> signInWithEmailPassword(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }
  }

  @override
  Future<void> signUpWithEmailPassword(
      File? profilePic,
      String name,
      String email,
      String phoneNumber,
      String password,
      String confirmPassword) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uid = auth.currentUser!.uid;
      String photoUrl =
          'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png';

      if (profilePic != null) {
        // Handle profile pic upload
        photoUrl = await commonFirebaseStorageRepository.storeFileToFirebase(
            "profilePic/$uid", profilePic);
      }
      var user = UserModel(
        name: name,
        uid: uid,
        profilePic: photoUrl,
        isOnline: true,
        phoneNumber: phoneNumber,
        groupId: const [],
      );
      await firestore.collection('users').doc(uid).set(user.toMap());
    } on FirebaseAuthException catch (e) {
      print("This went wrong $e");
    }
  }

  @override
  Stream<UserModel> userData(String userId) {
    return firestore.collection('users').doc(userId).snapshots().map(
          (event) => UserModel.fromMap(
            event.data()!,
          ),
        );
  }

  @override
  Future<void> setUserState(bool isOnline) async {
    await firestore.collection('users').doc(auth.currentUser!.uid).update({
      'isOnline': isOnline,
    });
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }
}
