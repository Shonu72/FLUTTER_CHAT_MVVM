import 'dart:io';

import 'package:charterer/data/datasource_impl/firebase_auth_datasource_impl.dart';
import 'package:charterer/data/models/user_model.dart';
import 'package:charterer/data/repositories/firebase_repository_impl.dart';
import 'package:get/get.dart';

class AuthControlller extends GetxController {
  final AuthRepository authRepository =
      AuthRepository(dataSource: FirebaseAuthDataSource());

  final user = Rxn<UserModel>();

  Rxn<UserModel> get currentUser => user;

  Future<void> getCurrentUser() async {
    user.value = await authRepository.getCurrentUser();
  }

  Future<void> signInWithEmailPassword(String email, String password) async {
    await authRepository.signInWithEmailPassword(email, password);
  }

  Future<void> signUpWithEmailPassword(String email, String password,
      String name, String phoneNumber, String confirmPassword) async {
    await authRepository.signUpWithEmailPassword(
        email, password, name, phoneNumber, confirmPassword);
  }

  Future<void> saveUserData(String name, File? profilePic) async {
    await authRepository.saveUserData(name, profilePic);
  }

  Stream<UserModel> userData(String userId) {
    return authRepository.userData(userId);
  }

  Future<void> setUserState(bool isOnline) async {
    await authRepository.setUserState(isOnline);
  }

  Future<void> signOut() async {
    await authRepository.signOut();
  }
}
