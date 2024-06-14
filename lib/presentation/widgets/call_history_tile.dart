import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/presentation/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';

class CallHistoryTile extends StatelessWidget {
  final String image;
  final String name;
  final String time;
  final IconData icon;
  final String calltype;
  const CallHistoryTile(
      {super.key,
      required this.image,
      required this.name,
      required this.time,
      required this.icon, required this.calltype});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: ListTile(
        tileColor: textCharcoalBlueColor,
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(image),
        ),
        title: AppText(text: name, color: textWhiteColor),
        subtitle: Row(
          children: [
            AppText(text: calltype, color: textWhiteColor, size: 14),
            const SizedBox(
              width: 5,
            ),
            AppText(text: time, color: textWhiteColor, size: 14)
          ],
        ),
        trailing: const Icon(
          Icons.call,
          color: iconWhiteColor,
        ),
      ),
    );
  }
}
