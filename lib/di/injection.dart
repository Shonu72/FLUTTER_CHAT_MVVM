import 'package:charterer/data/datasource_impl/chat_remote_datasource_impl.dart';
import 'package:charterer/data/datasource_impl/contact_datasource_impl.dart';
import 'package:charterer/data/datasource_impl/firebase_auth_datasource_impl.dart';
import 'package:charterer/data/datasources/chat_remote_datasource.dart';
import 'package:charterer/data/datasources/contact_datasource.dart';
import 'package:charterer/data/repositories/chat_repository_impl.dart';
import 'package:charterer/data/repositories/contact_repository_impl.dart';
import 'package:charterer/data/repositories/firebase_repository_impl.dart';
import 'package:charterer/domain/repositories/chat_repository.dart';
import 'package:charterer/domain/repositories/contact_repository.dart';
import 'package:charterer/domain/usecases/chat_usecase.dart';
import 'package:charterer/domain/usecases/contact_usecase.dart';
import 'package:charterer/domain/usecases/send_file_msg_usecase.dart';
import 'package:charterer/domain/usecases/send_text_msg_usecase.dart';
import 'package:charterer/presentation/getx/controllers/auth_controller.dart';
import 'package:charterer/presentation/getx/controllers/chat_controller.dart';
import 'package:charterer/presentation/getx/controllers/contact_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DependencyInjector {
  static void inject() {
    injectDataSource();
    injectRepository();
    injectController();
    injectUseCase();
  }

  static void injectDataSource() {
    Get.lazyPut(() => FirebaseFirestore.instance);
    Get.lazyPut(() => FirebaseAuth.instance);
    Get.lazyPut<SelectContactRemoteDataSource>(
        () => SelectContactRemoteDataSourceImpl(firestore: Get.find()));
    Get.lazyPut<ChatRemoteDataSource>(() =>
        ChatRemoteDataSourceImpl(firestore: Get.find(), auth: Get.find()));
  }

  static void injectRepository() {
    Get.lazyPut<SelectContactRepository>(
        () => SelectContactRepositoryImpl(remoteDataSource: Get.find()));
    Get.lazyPut<ChatRepository>(
        () => ChatRepositoryImpl(Get.find<ChatRemoteDataSource>()));
  }

  static void injectUseCase() {
    //conatcts
    Get.lazyPut<GetContactsUseCase>(
        () => GetContactsUseCase(repository: Get.find()));

    Get.lazyPut<SelectContactUseCase>(
        () => SelectContactUseCase(repository: Get.find()));
    //chats
    Get.lazyPut(() => GetChatContacts(Get.find<ChatRepository>()));
    Get.lazyPut(() => SendTextMessage(Get.find<ChatRepository>()));
    Get.lazyPut(() => GetChatStream(Get.find<ChatRepository>()));
    Get.lazyPut(() => SendFileMsgUseCase(Get.find<ChatRepository>()));
  }

  static void injectController() {
    Get.lazyPut(() => AuthControlller(
        authRepository: AuthRepository(dataSource: FirebaseAuthDataSource())));
    Get.lazyPut<SelectContactController>(() => SelectContactController(
          getContactsUseCase: Get.find(),
          selectContactUseCase: Get.find(),
        ));
    Get.lazyPut(() => ChatController(
          getChatContactsUseCase: Get.find(),
          getChatStreamUseCase: Get.find(),
          sendTextMessageUseCase: Get.find(),
          sendFileMessageUseCase: Get.find(),
        ));
  }
}
