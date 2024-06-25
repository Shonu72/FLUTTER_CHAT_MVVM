import 'package:flutter_contacts/flutter_contacts.dart';

abstract class SelectContactRepository {
  Future<List<Contact>> getContacts();
  Future<bool> selectContact(Contact selectedContact);
  // void selectGroupContact(int index, Contact groupContact);
}
