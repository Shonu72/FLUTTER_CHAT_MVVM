import 'dart:io';

import 'package:charterer/domain/usecases/create_group_usercase.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';

class GroupController extends GetxController {
  final CreateGroupUseCase createGroupUseCase;

  GroupController({required this.createGroupUseCase});

  Future<void> createGroup(
      String name, File groupPic, List<Contact> selectedContact) async {
    await createGroupUseCase(name, groupPic, selectedContact);
  }
}
