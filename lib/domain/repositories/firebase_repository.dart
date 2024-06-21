import 'dart:io';

import 'package:charterer/data/models/user_model.dart';

abstract class FirebaseRepository {
  Future<UserModel?> getCurrentUser();
  Future<void> signInWithEmailPassword(String email, String password);
  Future<void> signUpWithEmailPassword(
      File? profilePic,
      String name,
      String email,
      String phoneNumber,
      String password,
      String confirmPassword);
  Stream<UserModel> userData(String userId);
  Future<void> setUserState(bool isOnline);
  Future<void> signOut();
}
