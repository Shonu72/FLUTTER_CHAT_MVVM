import 'dart:io';

import 'package:charterer/data/datasources/group_data_source.dart';
import 'package:charterer/domain/repositories/group_repository.dart';
import 'package:flutter_contacts/contact.dart';

class GroupRepoImpl implements GroupRepository {
  final GroupDataSource dataSource;

  GroupRepoImpl({required this.dataSource});

  @override
  Future<void> createGroup(
      String name, File groupPic, List<Contact> selectedContact) async {
    return await dataSource.createGroup(name, groupPic, selectedContact);
  }
}
