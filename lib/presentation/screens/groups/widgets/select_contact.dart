import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/presentation/getx/controllers/contact_controller.dart';
import 'package:charterer/presentation/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';

class SelectGroupContact extends StatefulWidget {
  const SelectGroupContact({super.key});

  @override
  State<SelectGroupContact> createState() => _SelectGroupContactState();
}

class _SelectGroupContactState extends State<SelectGroupContact> {
  final controller = Get.find<SelectContactController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText(
            text: 'Select Contacts',
            color: whiteColor,
            size: 20,
          ),
          const Divider(
            thickness: 0.2,
            color: lightGreyColor,
          ),
          SizedBox(
            height: 400,
            child: FutureBuilder<List<Contact>>(
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
                    return InkWell(
                      onTap: () {
                        controller.selectGroupContact(index, contact);
                      },
                      child: Obx(() {
                        return ListTile(
                          tileColor: backgroundDarkColor
                              .withBlue(backgroundDarkColor.blue + 20),
                          leading:
                              controller.selectedContactsIndex.contains(index)
                                  ? IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.done,
                                        color: whiteColor,
                                      ))
                                  : null,
                          title: AppText(
                            text: contact.displayName,
                            color: whiteColor,
                            size: 16,
                          ),
                          // subtitle: Text(
                          //   contact.phones.isNotEmpty
                          //       ? contact.phones.first.number
                          //       : 'No phone number',
                          //   style: const TextStyle(color: textWhiteColor),
                          // ),
                        );
                      }),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
