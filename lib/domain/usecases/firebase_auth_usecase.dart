import 'dart:io';

import 'package:charterer/data/models/user_model.dart';
import 'package:charterer/domain/repositories/firebase_repository.dart';

class GetCurrentUserUseCase {
  final FirebaseRepository repository;

  GetCurrentUserUseCase({required this.repository});

  Future<UserModel?> call() async {
    return await repository.getCurrentUser();
  }
}

class SignInWithEmailPasswordUseCase {
  final FirebaseRepository repository;

  SignInWithEmailPasswordUseCase({required this.repository});

  Future<void> call(String email, String password) async {
    return await repository.signInWithEmailPassword(email, password);
  }
}

class SignUpWithEmailPasswordUseCase {
  final FirebaseRepository repository;

  SignUpWithEmailPasswordUseCase({required this.repository});

  Future<void> call(File profilePic, String name, String email,
      String phoneNumber, String password, String confirmPassword) async {
    return await repository.signUpWithEmailPassword(
        profilePic, name, email, phoneNumber, password, confirmPassword);
  }
}

class UserDataUseCase {
  final FirebaseRepository repository;

  UserDataUseCase({required this.repository});

  Stream<UserModel> call(String userId) {
    return repository.userData(userId);
  }
}

class SetUserStateUseCase {
  final FirebaseRepository repository;

  SetUserStateUseCase({required this.repository});

  Future<void> call(bool isOnline) async {
    return await repository.setUserState(isOnline);
  }
}

class SignOutUseCase {
  final FirebaseRepository repository;

  SignOutUseCase({required this.repository});

  Future<void> call() async {
    return await repository.signOut();
  }
}
