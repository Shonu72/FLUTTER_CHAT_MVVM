import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/presentation/getx/controllers/contact_controller.dart';
import 'package:charterer/presentation/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  TextEditingController groupNameController = TextEditingController();
  final controller = Get.find<SelectContactController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDarkColor,
      appBar: AppBar(
        backgroundColor:
            backgroundDarkColor.withBlue(backgroundDarkColor.blue + 20),
        title: const AppText(
          text: "Create Group",
          color: whiteColor,
          size: 24,
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Stack(
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundColor: whiteColor,
                  backgroundImage: AssetImage("assets/images/boy.png"),
                  // child: Icon(
                  //   Icons.camera_alt,
                  //   color: backgroundDarkColor,
                  // ),
                ),
                Positioned(
                  right: 10,
                  bottom: 20,
                  child: Icon(
                    Icons.add_a_photo_sharp,
                    color: whiteColor,
                    size: 30,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                style: const TextStyle(color: whiteColor),
                controller: groupNameController,
                cursorColor: whiteColor,
                decoration: const InputDecoration(
                    hintText: 'Enter Group Name',
                    hintStyle: TextStyle(color: whiteColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: whiteColor,
                      ),
                    )),
              ),
            ),
            Container(
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No contacts found'));
                        }
                        final contacts = snapshot.data!;
                        return ListView.builder(
                          itemCount: contacts.length,
                          itemBuilder: (context, index) {
                            final contact = contacts[index];
                            final image = contact.photo != null
                                ? MemoryImage(contact.photo!)
                                : null;
                            return ListTile(
                              tileColor: backgroundDarkColor
                                  .withBlue(backgroundDarkColor.blue + 20),
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
                                // controller.selectContact(contact);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.done,
          color: Colors.white,
        ),
      ),
    );
  }
}
