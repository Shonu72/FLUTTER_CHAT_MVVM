import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/presentation/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<Contact>? _contacts;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      setState(() => _contacts = contacts);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDarkColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new,
              size: 24, color: textWhiteColor),
        ),
        backgroundColor:
            backgroundDarkColor.withBlue(backgroundDarkColor.blue - 20),
        title: const AppText(text: 'Contacts', size: 24, color: textWhiteColor),
      ),
      body: _permissionDenied
          ? const Center(
              child: AppText(
                text: 'Permission denied',
                size: 24,
                color: textWhiteColor,
              ),
            )
          : _contacts == null
              ? const Center(
                  child: CircularProgressIndicator(
                    color: textWhiteColor,
                  ),
                )
              : ListView.builder(
                  itemCount: _contacts!.length,
                  itemBuilder: (context, index) {
                    final contact = _contacts![index];
                    final image = contact.photo != null
                        ? MemoryImage(contact.photo!)
                        : null;
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: image,
                        child: image == null ? const Icon(Icons.person) : null,
                      ),
                      title: Text(
                        contact.displayName,
                        style: const TextStyle(color: textWhiteColor),
                      ),
                      // subtitle: Text(
                      //   contact.phones.isNotEmpty
                      //       ? contact.phones.first.number
                      //       : 'No phone number',
                      //   style: const TextStyle(color: textWhiteColor),
                      // ),
                      onTap: () {},
                    );
                  },
                ),
    );
  }
}
