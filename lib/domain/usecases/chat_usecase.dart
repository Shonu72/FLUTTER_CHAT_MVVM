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


// class SendFileMessage {
//   final ChatRepository repository;
//   SendFileMessage(this.repository);
//   void call({
//     required BuildContext context,
//     required File file,
//     required String receiverUserId,
//     required MessageEnum messageEnum,
//   }) {
//     repository.sendFileMessage(
//       context: context,
//       file: file,
//       receiverUserId: receiverUserId,
//       messageEnum: messageEnum,
//     );
//   }
// }

// class SetChatMessageSeen {
//   final ChatRepository repository;
//   SetChatMessageSeen(this.repository);
//   void call({
//     required BuildContext context,
//     required String receiverUserId,
//     required String messageId,
//   }) {
//     repository.setChatMessageSeen(
//       context: context,
//       receiverUserId: receiverUserId,
//       messageId: messageId,
//     );
//   }
// }
