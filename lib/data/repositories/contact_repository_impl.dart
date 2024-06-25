// data/repositories/contact_repository_impl.dart
import 'package:charterer/data/datasources/contact_datasource.dart';
import 'package:charterer/domain/repositories/contact_repository.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class SelectContactRepositoryImpl implements SelectContactRepository {
  final SelectContactRemoteDataSource remoteDataSource;

  SelectContactRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Contact>> getContacts() async {
    return await remoteDataSource.getContacts();
  }

  @override
  Future<bool> selectContact(Contact selectedContact) async {
    return await remoteDataSource.selectContact(selectedContact);
  }

  // @override
  // void selectGroupContact(int index, Contact groupContact) {
  //   remoteDataSource.selectGroupContact(index, groupContact);
  // }
}
