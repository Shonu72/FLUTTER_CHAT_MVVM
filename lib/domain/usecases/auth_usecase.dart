import 'dart:io';

import 'package:charterer/data/models/user_model.dart';

abstract class AuthUseCase {
  Future<UserModel?> getCurrentUser();
  Future<void> signInWithEmailPassword(String email, String password);
  Future<void> signUpWithEmailPassword(String email, String password, String name, String phoneNumber, String confirmPassword);
  Future<void> saveUserData(String name, File? profilePic);
  Stream<UserModel> userData(String userId);
  Future<void> setUserState(bool isOnline);
  Future<void> signOut();
}
