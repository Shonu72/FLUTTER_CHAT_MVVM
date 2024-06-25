// data/datasources/contact_datasource_impl.dart
import 'package:charterer/data/datasources/contact_datasource.dart';
import 'package:charterer/data/models/user_model.dart';
import 'package:charterer/presentation/getx/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';

class SelectContactRemoteDataSourceImpl
    implements SelectContactRemoteDataSource {
  final FirebaseFirestore firestore;

  SelectContactRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission(readonly: true)) {
        contacts = await FlutterContacts.getContacts(
            withProperties: true, withPhoto: true);
      }
    } catch (e) {
      print(e.toString());
    }
    return contacts;
  }

  @override
  Future<bool> selectContact(Contact selectedContact) async {
    try {
      var userCollection = await firestore.collection('users').get();
      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        String selectedPhoneNum =
            selectedContact.phones[0].number.replaceAll(' ', '');
        if (selectedPhoneNum == userData.phoneNumber) {
          print('Selected contact: ${userData.phoneNumber}');
          print('Selected contact: ${userData.uid}');
          print('Selected contact: ${userData.profilePic}');
          Get.toNamed(Routes.chatPage, arguments: {
            'name': selectedContact.displayName,
            'uid': userData.uid,
            'profilePic': userData.profilePic,
          });
          return true;
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  // @override
  // void selectGroupContact(int index, Contact groupContact) {
  //   List<int> selectedContactsIndex = [];
  //   if (selectedContactsIndex.contains(index)) {
  //     selectedContactsIndex.removeAt(index);
  //   } else {
  //     selectedContactsIndex.add(index);
  //   }
  // }
}
