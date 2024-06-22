import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/presentation/getx/controllers/contact_controller.dart';
import 'package:charterer/presentation/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SelectContactController>();
    return Scaffold(
      backgroundColor: backgroundDarkColor,
      appBar: AppBar(
          backgroundColor:
              backgroundDarkColor.withBlue(backgroundDarkColor.blue + 20),
          title: const AppText(
            text: 'Select Contacts',
            color: whiteColor,
            size: 24,
          ),
          leading: IconButton(
            onPressed: () {
              // Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: whiteColor,
            ),
          )),
      body: 
      FutureBuilder<List<Contact>>(
        future: controller.getContacts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No contacts found'));
          }
          final contacts = snapshot.data!;
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              final image =
                  contact.photo != null ? MemoryImage(contact.photo!) : null;
              return ListTile(
                tileColor:
                    backgroundDarkColor.withBlue(backgroundDarkColor.blue + 20),
                leading: CircleAvatar(
                    backgroundImage: image,
                    child: image == null
                        ? const Icon(
                            Icons.person,
                            color: whiteColor,
                          )
                        : null),
                title: AppText(
                  text: contact.displayName,
                  color: whiteColor,
                  size: 16,
                ),
              subtitle: Text(
                        contact.phones.isNotEmpty
                            ? contact.phones.first.number
                            : 'No phone number',
                        style: const TextStyle(color: textWhiteColor),
                      ),
                onTap: () {
                  controller.selectContact(contact);
                },
              );
            },
          );
        },
      ),
   
    );
  }
}
