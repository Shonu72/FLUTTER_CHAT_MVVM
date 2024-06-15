import 'dart:io';

import 'package:charterer/data/datasources/firebase_auth_datasource.dart';
import 'package:charterer/data/models/user_model.dart';
import 'package:charterer/domain/usecases/auth_usecase.dart';

class AuthRepository with AuthUseCase {
  final AuthDataSource _dataSource;

  AuthRepository({
    required AuthDataSource dataSource,
  }) : _dataSource = dataSource;

  @override
  Future<UserModel?> getCurrentUser() async {
    return _dataSource.getCurrentUserData();
  }

  @override
  Future<void> signInWithEmailPassword(String email, String password) async {
    return _dataSource.signInWithEmailPassword(email, password);
  }

  @override
  Future<void> signUpWithEmailPassword(String email, String password,
      String name, String phoneNumber, String confirmPassword) async {
    return _dataSource.signUpWithEmailPassword(
        email, password, confirmPassword, name, phoneNumber);
  }

  @override
  Future<void> saveUserData(String name, File? profilePic) async {
    return _dataSource.saveUserDataToFirebase(name, profilePic);
  }

  @override
  Stream<UserModel> userData(String userId) {
    return _dataSource.userData(userId);
  }

  @override
  Future<void> setUserState(bool isOnline) async {
    return _dataSource.setUserState(isOnline);
  }

  @override
  Future<void> signOut() async {
    return _dataSource.signOut();
  }

}
