import 'dart:io';

import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/domain/repositories/group_repository.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class CreateGroupUseCase {
  final GroupRepository groupRepository;

  CreateGroupUseCase(this.groupRepository);

  Future<void> call(
      String name, File groupPic, List<Contact> selectedContact) async {
    try {
      return groupRepository.createGroup(name, groupPic, selectedContact);
    } catch (e) {
      print(e.toString());
      Helpers.toast(e.toString());
    }
  }
}
