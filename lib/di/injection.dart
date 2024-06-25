import 'package:charterer/data/datasource_impl/chat_remote_datasource_impl.dart';
import 'package:charterer/data/datasource_impl/contact_datasource_impl.dart';
import 'package:charterer/data/datasource_impl/firebase_auth_datasource_impl.dart';
import 'package:charterer/data/datasource_impl/group_data_source_impl.dart';
import 'package:charterer/data/datasource_impl/story_datasource_impl.dart';
import 'package:charterer/data/datasources/chat_remote_datasource.dart';
import 'package:charterer/data/datasources/contact_datasource.dart';
import 'package:charterer/data/datasources/firebase_auth_datasource.dart';
import 'package:charterer/data/datasources/group_data_source.dart';
import 'package:charterer/data/datasources/story_datasource.dart';
import 'package:charterer/data/repositories/chat_repository_impl.dart';
import 'package:charterer/data/repositories/contact_repository_impl.dart';
import 'package:charterer/data/repositories/firebase_repository_impl.dart';
import 'package:charterer/data/repositories/group_repo_impl.dart';
import 'package:charterer/data/repositories/story_repository_impl.dart';
import 'package:charterer/domain/repositories/chat_repository.dart';
import 'package:charterer/domain/repositories/contact_repository.dart';
import 'package:charterer/domain/repositories/firebase_repository.dart';
import 'package:charterer/domain/repositories/group_repository.dart';
import 'package:charterer/domain/repositories/story_repository.dart';
import 'package:charterer/domain/usecases/chat_usecase.dart';
import 'package:charterer/domain/usecases/contact_usecase.dart';
import 'package:charterer/domain/usecases/create_group_usercase.dart';
import 'package:charterer/domain/usecases/firebase_auth_usecase.dart';
import 'package:charterer/domain/usecases/get_story_usecase.dart';
import 'package:charterer/domain/usecases/mark_as_seen_usecase.dart';
import 'package:charterer/domain/usecases/send_file_msg_usecase.dart';
import 'package:charterer/domain/usecases/send_text_msg_usecase.dart';
import 'package:charterer/domain/usecases/upload_story_usecase.dart';
import 'package:charterer/presentation/getx/controllers/auth_controller.dart';
import 'package:charterer/presentation/getx/controllers/chat_controller.dart';
import 'package:charterer/presentation/getx/controllers/contact_controller.dart';
import 'package:charterer/presentation/getx/controllers/group_controller.dart';
import 'package:charterer/presentation/getx/controllers/message_reply_controller.dart';
import 'package:charterer/presentation/getx/controllers/story_controller.dart';
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
    // auth
    Get.lazyPut<AuthDataSource>(
        () => FirebaseAuthDataSource(auth: Get.find(), firestore: Get.find()));
    // contacts
    Get.lazyPut<SelectContactRemoteDataSource>(
        () => SelectContactRemoteDataSourceImpl(firestore: Get.find()));
    // chats
    Get.lazyPut<ChatRemoteDataSource>(() =>
        ChatRemoteDataSourceImpl(firestore: Get.find(), auth: Get.find()));
    //stories
    Get.lazyPut<StoryDataSource>(
        () => StoryDataSourceImpl(firestore: Get.find(), auth: Get.find()));
    Get.lazyPut<GroupDataSource>(
        () => GroupDataSourceImpl(auth: Get.find(), firestore: Get.find()));
  }

  static void injectRepository() {
    Get.lazyPut<FirebaseRepository>(
        () => AuthRepositoryImpl(dataSource: Get.find()));
    Get.lazyPut<SelectContactRepository>(
        () => SelectContactRepositoryImpl(remoteDataSource: Get.find()));
    Get.lazyPut<ChatRepository>(
        () => ChatRepositoryImpl(Get.find<ChatRemoteDataSource>()));
    Get.lazyPut<StoryRepository>(() =>
        StoryRepositoryImpl(storyDataSource: Get.find<StoryDataSource>()));
    Get.lazyPut<GroupRepository>(
        () => GroupRepoImpl(dataSource: Get.find<GroupDataSource>()));
  }

  static void injectUseCase() {
    Get.lazyPut(() => GetCurrentUserUseCase(repository: Get.find()));
    Get.lazyPut(() => SignInWithEmailPasswordUseCase(repository: Get.find()));
    Get.lazyPut(() => SignUpWithEmailPasswordUseCase(repository: Get.find()));
    Get.lazyPut(() => UserDataUseCase(repository: Get.find()));
    Get.lazyPut(() => SetUserStateUseCase(repository: Get.find()));
    Get.lazyPut(() => SignOutUseCase(repository: Get.find()));
    //conatcts
    Get.lazyPut<GetContactsUseCase>(
        () => GetContactsUseCase(repository: Get.find()));

    Get.lazyPut<SelectContactUseCase>(
        () => SelectContactUseCase(repository: Get.find()));
    // Get.lazyPut<SelectGroupContactUseCase>(
    //     () => SelectGroupContactUseCase(repository: Get.find()));
    //chats
    Get.lazyPut(() => GetChatContacts(Get.find<ChatRepository>()));
    Get.lazyPut(() => SendTextMessage(Get.find<ChatRepository>()));
    Get.lazyPut(() => GetChatStream(Get.find<ChatRepository>()));
    Get.lazyPut(() => GetGroupChatStream(Get.find<ChatRepository>()));
    Get.lazyPut(() => SendFileMsgUseCase(Get.find<ChatRepository>()));
    Get.lazyPut(() => MarkAsSeenUseCase(Get.find<ChatRepository>()));
    Get.lazyPut(() => UploadStoryUseCase(Get.find<StoryRepository>()));
    Get.lazyPut(() => GetStoryUseCase(Get.find<StoryRepository>()));
    Get.lazyPut(() => CreateGroupUseCase(Get.find<GroupRepository>()));
    Get.lazyPut(() => GetChatGroupsUseCase(Get.find<ChatRepository>()));
  }

  static void injectController() {
    Get.lazyPut<AuthControlller>(() => AuthControlller(
          getCurrentUserUseCase: Get.find<GetCurrentUserUseCase>(),
          signInWithEmailPasswordUseCase: Get.find(),
          signUpWithEmailPasswordUseCase: Get.find(),
          userDataUseCase: Get.find(),
          setUserStateUseCase: Get.find(),
          signOutUseCase: Get.find(),
        ));
    Get.lazyPut<SelectContactController>(() => SelectContactController(
          // selectGroupContactUseCase: Get.find(),
          getContactsUseCase: Get.find(),
          selectContactUseCase: Get.find(),
        ));
    Get.lazyPut(() => ChatController(
          getChatContactsUseCase: Get.find(),
          getChatStreamUseCase: Get.find(),
          getGroupChatStreamUseCase: Get.find(),
          sendTextMessageUseCase: Get.find(),
          sendFileMessageUseCase: Get.find(),
          setChatMessageSeen: Get.find(),
          getChatGroupsUseCase: Get.find(),
        ));

    Get.lazyPut(() => MessageReplyController());
    Get.lazyPut(() => StoryController(
        uploadStoryUseCase: Get.find(), getStoryUseCase: Get.find()));

    Get.lazyPut(() => GroupController(createGroupUseCase: Get.find()));
  }
}
