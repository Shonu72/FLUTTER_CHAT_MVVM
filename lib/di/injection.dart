import 'package:charterer/data/datasource_impl/chat_remote_datasource_impl.dart';
import 'package:charterer/data/datasource_impl/contact_datasource_impl.dart';
import 'package:charterer/data/datasource_impl/firebase_auth_datasource_impl.dart';
import 'package:charterer/data/datasource_impl/group_data_source_impl.dart';
import 'package:charterer/data/datasource_impl/make_call_datasource_impl.dart';
import 'package:charterer/data/datasource_impl/story_datasource_impl.dart';
import 'package:charterer/data/datasources/chat_remote_datasource.dart';
import 'package:charterer/data/datasources/contact_datasource.dart';
import 'package:charterer/data/datasources/firebase_auth_datasource.dart';
import 'package:charterer/data/datasources/group_data_source.dart';
import 'package:charterer/data/datasources/make_call_datasource.dart';
import 'package:charterer/data/datasources/story_datasource.dart';
import 'package:charterer/data/repositories/call_repo_impl.dart';
import 'package:charterer/data/repositories/chat_repository_impl.dart';
import 'package:charterer/data/repositories/contact_repository_impl.dart';
import 'package:charterer/data/repositories/firebase_repository_impl.dart';
import 'package:charterer/data/repositories/group_repo_impl.dart';
import 'package:charterer/data/repositories/story_repository_impl.dart';
import 'package:charterer/domain/repositories/call_repository.dart';
import 'package:charterer/domain/repositories/chat_repository.dart';
import 'package:charterer/domain/repositories/contact_repository.dart';
import 'package:charterer/domain/repositories/firebase_repository.dart';
import 'package:charterer/domain/repositories/group_repository.dart';
import 'package:charterer/domain/repositories/story_repository.dart';
import 'package:charterer/domain/usecases/chat_usecase.dart';
import 'package:charterer/domain/usecases/contact_usecase.dart';
import 'package:charterer/domain/usecases/create_group_usercase.dart';
import 'package:charterer/domain/usecases/end_call_usecase.dart';
import 'package:charterer/domain/usecases/end_group_call_usecase.dart';
import 'package:charterer/domain/usecases/firebase_auth_usecase.dart';
import 'package:charterer/domain/usecases/get_call_usecase.dart';
import 'package:charterer/domain/usecases/get_story_usecase.dart';
import 'package:charterer/domain/usecases/make_call_usecase.dart';
import 'package:charterer/domain/usecases/make_group_call_usecase.dart';
import 'package:charterer/domain/usecases/mark_as_seen_usecase.dart';
import 'package:charterer/domain/usecases/send_file_msg_usecase.dart';
import 'package:charterer/domain/usecases/send_text_msg_usecase.dart';
import 'package:charterer/domain/usecases/upload_story_usecase.dart';
import 'package:charterer/presentation/getx/controllers/auth_controller.dart';
import 'package:charterer/presentation/getx/controllers/call_controller.dart';
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
    injectUseCase();
    injectController();
  }

  static void injectDataSource() {
    Get.put(FirebaseFirestore.instance);
    Get.put(FirebaseAuth.instance);
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
    Get.lazyPut<MakeCallDataSource>(
        () => MakeCallDataSourceImpl(firestore: Get.find(), auth: Get.find()));
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
    Get.lazyPut<CallRepository>(
        () => MakeCallRepoImpl(Get.find<MakeCallDataSource>()));
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
    Get.lazyPut(() => MakeCallUseCase(Get.find<CallRepository>()));
    Get.lazyPut(() => GetCallStreamUseCase(Get.find<CallRepository>()));
    Get.lazyPut(() => MakeGroupCallUseCase(Get.find<CallRepository>()));
    Get.lazyPut(() => EndCallUseCase(Get.find<CallRepository>()));
    Get.lazyPut(() => EndGroupCallUseCase(Get.find<CallRepository>()));
  }

  static void injectController() {
    Get.lazyPut<AuthControlller>(() => AuthControlller(
          getCurrentUserUseCase: Get.find<GetCurrentUserUseCase>(),
          signInWithEmailPasswordUseCase:
              Get.find<SignInWithEmailPasswordUseCase>(),
          signUpWithEmailPasswordUseCase:
              Get.find<SignUpWithEmailPasswordUseCase>(),
          userDataUseCase: Get.find<UserDataUseCase>(),
          setUserStateUseCase: Get.find<SetUserStateUseCase>(),
          signOutUseCase: Get.find<SignOutUseCase>(),
        ));
    Get.lazyPut<SelectContactController>(() => SelectContactController(
          // selectGroupContactUseCase: Get.find(),
          getContactsUseCase: Get.find<GetContactsUseCase>(),
          selectContactUseCase: Get.find<SelectContactUseCase>(),
        ));
    Get.lazyPut<ChatController>(() => ChatController(
          getChatContactsUseCase: Get.find<GetChatContacts>(),
          getChatStreamUseCase: Get.find<GetChatStream>(),
          getGroupChatStreamUseCase: Get.find<GetGroupChatStream>(),
          sendTextMessageUseCase: Get.find<SendTextMessage>(),
          sendFileMessageUseCase: Get.find<SendFileMsgUseCase>(),
          setChatMessageSeen: Get.find<MarkAsSeenUseCase>(),
          getChatGroupsUseCase: Get.find<GetChatGroupsUseCase>(),
        ));

    Get.lazyPut<MessageReplyController>(() => MessageReplyController());
    Get.lazyPut<StoryController>(() => StoryController(
          uploadStoryUseCase: Get.find<UploadStoryUseCase>(),
          getStoryUseCase: Get.find<GetStoryUseCase>(),
        ));

    Get.lazyPut<GroupController>(() => GroupController(
          createGroupUseCase: Get.find<CreateGroupUseCase>(),
        ));

    Get.lazyPut(() => CallController(
        getCallStreamUseCase: Get.find<GetCallStreamUseCase>(),
        makeCallUseCase: Get.find<MakeCallUseCase>(),
        makeGroupCallUseCase: Get.find<MakeGroupCallUseCase>(),
        endCallUseCase: Get.find<EndCallUseCase>(),
        endGroupCallUseCase: Get.find<EndGroupCallUseCase>()));
  }
}
