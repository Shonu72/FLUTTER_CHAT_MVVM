// common_firebase_storage_repository.dart
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

final commonFirebaseStorageRepository = CommonFirebaseStorageRepository(
  firebaseStorage: FirebaseStorage.instance,
);

class CommonFirebaseStorageRepository extends GetxController {
  final FirebaseStorage firebaseStorage;
  CommonFirebaseStorageRepository({
    required this.firebaseStorage,
  });

  Future<String> storeFileToFirebase(String ref, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<List<Map<String, dynamic>>> getDataFromFirebase(
      String collectionPath) async {
    // Get a reference to the Firestore collection
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection(collectionPath);

    // Fetch the documents from the collection
    QuerySnapshot querySnapshot = await collectionRef.get();

    // Convert the documents to a list of maps
    List<Map<String, dynamic>> documents = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    return documents;
  }
}
