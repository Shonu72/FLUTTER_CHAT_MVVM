import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/domain/usecases/contact_usecase.dart';
import 'package:charterer/presentation/getx/routes/routes.dart';
import 'package:get/get.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter/material.dart';

class SelectContactController extends GetxController {
  final GetContactsUseCase getContactsUseCase;
  final SelectContactUseCase selectContactUseCase;

  SelectContactController({
    required this.getContactsUseCase,
    required this.selectContactUseCase,
  });

  Future<List<Contact>> getContacts() async {
    return await getContactsUseCase();
  }

  void selectContact(Contact selectedContact) async {
    bool isFound = await selectContactUseCase(selectedContact);
    if (isFound) {
      print(selectedContact.displayName);
      print(selectedContact.id);
      print(selectedContact.phones);
      // Get.toNamed(Routes.chatPage, arguments: {
      //   'name': selectedContact.displayName,
      //   'uid': selectedContact.id,
      // });
    } else {
      Helpers.toast(
          "Contact not found for this app, Try adding them as a friend first.");
    }
  }
}
