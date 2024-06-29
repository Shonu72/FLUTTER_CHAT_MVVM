import 'dart:io';

import 'package:charterer/data/models/user_model.dart';
import 'package:charterer/domain/usecases/firebase_auth_usecase.dart';
import 'package:get/get.dart';

class AuthControlller extends GetxController {
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final SignInWithEmailPasswordUseCase signInWithEmailPasswordUseCase;
  final SignUpWithEmailPasswordUseCase signUpWithEmailPasswordUseCase;
  final UserDataUseCase userDataUseCase;
  final SetUserStateUseCase setUserStateUseCase;
  final SignOutUseCase signOutUseCase;

  AuthControlller({
    required this.getCurrentUserUseCase,
    required this.signInWithEmailPasswordUseCase,
    required this.signUpWithEmailPasswordUseCase,
    required this.userDataUseCase,
    required this.setUserStateUseCase,
    required this.signOutUseCase,
  });

  Future<UserModel?> getCurrentUser() async {
    UserModel? user = await getCurrentUserUseCase();
    return user;
  }

  Future<void> signInWithEmailPassword(String email, String password) async {
    await signInWithEmailPasswordUseCase(email, password);
  }

  Future<void> signUpWithEmailPassword(
      File? profilePic,
      String name,
      String email,
      String phoneNumber,
      String password,
      String confirmPassword) async {
    await signUpWithEmailPasswordUseCase(
        profilePic!, name, email, phoneNumber, password, confirmPassword);
  }

  Stream<UserModel> userData(String userId) {
    return userDataUseCase(userId);
  }

  Future<void> setUserState(bool isOnline, String pushToken) async {
    await setUserStateUseCase(isOnline, pushToken);
  }

  Future<void> signOut() async {
    await signOutUseCase();
  }
}
