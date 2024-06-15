import 'dart:io';
import 'package:charterer/data/models/user_model.dart';

abstract class AuthDataSource {
  Future<UserModel?> getCurrentUserData();
  Future<void> signInWithEmailPassword(String email, String password);
  Future<void> signUpWithEmailPassword(
      String name, String email,
      File? profilePic, String phoneNumber, String password, String confirmPassword);
  Future<void> saveUserDataToFirebase(String name, File? profilePic);
  Stream<UserModel> userData(String userId);
  Future<void> setUserState(bool isOnline);
  Future<void> signOut();
}
