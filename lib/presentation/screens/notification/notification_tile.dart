import 'package:cached_network_image/cached_network_image.dart';
import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/presentation/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  final String image;
  final String notificationTitle;
  final String message;
  final String date;
  final VoidCallback onTap;
  const NotificationTile(
      {super.key,
      required this.image,
      required this.notificationTitle,
      required this.message,
      required this.date,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: ListTile(
        tileColor: textCharcoalBlueColor,
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: CachedNetworkImageProvider(image),
        ),
        title: Row(
          children: [
            const AppText(text: "sent by ~ ", color: textWhiteColor, size: 14),
            AppText(
              text: notificationTitle,
              color: textWhiteColor,
              size: 18,
            ),
            const Spacer(),
            AppText(text: "~ ( $date )", color: textWhiteColor, size: 14),
            // 8360617749
          ],
        ),
        subtitle: Row(
          children: [
            AppText(text: message, color: textWhiteColor, size: 14),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
