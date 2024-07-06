import 'package:charterer/data/models/chat_contact_model.dart';
import 'package:charterer/data/models/group_model.dart';
import 'package:charterer/data/models/messages_model.dart';
import 'package:charterer/domain/repositories/chat_repository.dart';

class GetChatContacts {
  final ChatRepository repository;

  GetChatContacts(this.repository);

  Stream<List<ChatContact>> call() {
    return repository.getChatContacts();
  }
}

class GetChatStream {
  final ChatRepository repository;

  GetChatStream(this.repository);

  Stream<List<Message>> call(String receiverUserId) {
    return repository.getChatStream(receiverUserId);
  }
}

class GetGroupChatStream {
  final ChatRepository repository;

  GetGroupChatStream(this.repository);

  Stream<List<Message>> call(String groupId) {
    return repository.getGroupChatStream(groupId);
  }
}

class GetChatGroupsUseCase {
  final ChatRepository repository;

  GetChatGroupsUseCase(this.repository);

  Stream<List<Group>> call() {
    return repository.getChatGroups();
  }
}
