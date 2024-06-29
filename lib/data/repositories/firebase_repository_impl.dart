import 'dart:io';

import 'package:charterer/data/datasources/firebase_auth_datasource.dart';
import 'package:charterer/data/models/user_model.dart';
import 'package:charterer/domain/repositories/firebase_repository.dart';

class AuthRepositoryImpl implements FirebaseRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<UserModel?> getCurrentUser() async {
    return await dataSource.getCurrentUserData();
  }

  @override
  Future<void> signInWithEmailPassword(String email, String password) async {
    return dataSource.signInWithEmailPassword(email, password);
  }

  @override
  Future<void> signUpWithEmailPassword(
      File? profilePic,
      String name,
      String email,
      String phoneNumber,
      String password,
      String confirmPassword) async {
    return dataSource.signUpWithEmailPassword(
        profilePic, name, email, phoneNumber, password, confirmPassword);
  }

  @override
  Stream<UserModel> userData(String userId) {
    return dataSource.userData(userId);
  }

  @override
  Future<void> setUserState(bool isOnline, String pushToken) async {
    return dataSource.setUserState(isOnline, pushToken);
  }

  @override
  Future<void> signOut() async {
    return dataSource.signOut();
  }
}
