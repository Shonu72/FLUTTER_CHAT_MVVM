import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/domain/usecases/contact_usecase.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:get/get.dart';

class SelectContactController extends GetxController {
  final GetContactsUseCase getContactsUseCase;
  final SelectContactUseCase selectContactUseCase;

  SelectContactController({
    required this.getContactsUseCase,
    required this.selectContactUseCase,
  });

  RxList<int> selectedContactsIndex = <int>[].obs;
  RxList<Contact> selectedGroupContacts = <Contact>[].obs;

  Future<List<Contact>> getContacts() async {
    return await getContactsUseCase();
  }

  void selectContact(Contact selectedContact) async {
    bool isFound = await selectContactUseCase(selectedContact);
    if (isFound) {
      print(selectedContact.displayName);
      print(selectedContact.id);
      print(selectedContact.phones);
    } else {
      Helpers.toast(
          "Contact not found for this app, Try adding them as a friend first.");
    }
  }

  void selectGroupContact(int index, Contact contact) {
    if (selectedContactsIndex.contains(index)) {
      selectedContactsIndex.remove(index);
      selectedGroupContacts.remove(contact);
    } else {
      selectedContactsIndex.add(index);
      selectedGroupContacts.add(contact);
    }
  }
}
