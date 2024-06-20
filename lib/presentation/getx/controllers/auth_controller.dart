import 'dart:io';

import 'package:get/get.dart';

import 'package:charterer/data/models/user_model.dart';
import 'package:charterer/data/repositories/firebase_repository_impl.dart';

class AuthControlller extends GetxController {
  final AuthRepository authRepository;
  AuthControlller({
    required this.authRepository,
  });

  // AuthRepository(dataSource: FirebaseAuthDataSource());

  final user = Rxn<UserModel>();

  Rxn<UserModel> get currentUser => user;

  Future<void> getCurrentUser() async {
    user.value = await authRepository.getCurrentUser();
    print("user: ${user.value!.profilePic}");
  }

  Future<void> signInWithEmailPassword(String email, String password) async {
    await authRepository.signInWithEmailPassword(email, password);
  }

  Future<void> signUpWithEmailPassword(
      File? profilePic,
      String name,
      String email,
      String phoneNumber,
      String password,
      String confirmPassword) async {
    await authRepository.signUpWithEmailPassword(
        profilePic, name, email, phoneNumber, password, confirmPassword);
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
