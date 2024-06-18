import 'package:charterer/data/datasource_impl/contact_datasource_impl.dart';
import 'package:charterer/data/datasource_impl/firebase_auth_datasource_impl.dart';
import 'package:charterer/data/datasources/contact_datasource.dart';
import 'package:charterer/data/repositories/contact_repository_impl.dart';
import 'package:charterer/data/repositories/firebase_repository_impl.dart';
import 'package:charterer/domain/repositories/contact_repository.dart';
import 'package:charterer/domain/usecases/contact_usecase.dart';
import 'package:charterer/presentation/getx/controllers/auth_controller.dart';
import 'package:charterer/presentation/getx/controllers/contact_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DependencyInjector {
  static void inject() {
    injectDataSource();
    injectRepository();
    injectController();
    injectUseCase();
  }

  static void injectDataSource() {
    Get.lazyPut<SelectContactRemoteDataSource>(() =>
        SelectContactRemoteDataSourceImpl(
            firestore: FirebaseFirestore.instance));
  }

  static void injectRepository() {
    Get.lazyPut<SelectContactRepository>(
        () => SelectContactRepositoryImpl(remoteDataSource: Get.find()));
  }

  static void injectUseCase() {
    Get.lazyPut<GetContactsUseCase>(
        () => GetContactsUseCase(repository: Get.find()));

    Get.lazyPut<SelectContactUseCase>(
        () => SelectContactUseCase(repository: Get.find()));
  }

  static void injectController() {
    Get.lazyPut(() => AuthControlller(
        authRepository: AuthRepository(dataSource: FirebaseAuthDataSource())));
    Get.lazyPut<SelectContactController>(() => SelectContactController(
          getContactsUseCase: Get.find(),
          selectContactUseCase: Get.find(),
        ));
  }
}
