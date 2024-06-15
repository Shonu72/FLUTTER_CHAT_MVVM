import 'package:charterer/core/utils/failure.dart';
import 'package:charterer/domain/entities/user_entities.dart';
import 'package:dartz/dartz.dart';

abstract class FirebaseRepository {
  Future<Either<Failure, UserEntity>> register(UserEntity userEntity);
  Future<Either<Failure, UserEntity>> logIn(UserEntity userEntity);
  Future<Either<Failure, void>> logOut();
}
