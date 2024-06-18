import 'package:charterer/domain/repositories/contact_repository.dart';
import 'package:flutter_contacts/contact.dart';

class GetContactsUseCase {
  final SelectContactRepository repository;

  GetContactsUseCase({required this.repository});

  Future<List<Contact>> call() async {
    return await repository.getContacts();
  }
}

class SelectContactUseCase {
  final SelectContactRepository repository;

  SelectContactUseCase({required this.repository});

  Future<bool> call(Contact selectedContact) async {
    return await repository.selectContact(selectedContact);
  }
}
