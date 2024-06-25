import 'dart:io';

import 'package:flutter_contacts/flutter_contacts.dart';

abstract class GroupRepository {
  Future<void> createGroup(
    String name,
    File groupPic,
    List<Contact> selectedContact,
  );
}
