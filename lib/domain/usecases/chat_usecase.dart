import 'package:charterer/data/models/chat_contact_model.dart';
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
