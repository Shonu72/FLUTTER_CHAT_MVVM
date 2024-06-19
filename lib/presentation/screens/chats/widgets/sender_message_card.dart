import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/core/utils/enums.dart';
import 'package:charterer/presentation/screens/chats/widgets/display_text_img.dart';
import 'package:flutter/material.dart';

class SenderMessageCard extends StatelessWidget {
  final String message;
  final String date;
  final MessageEnum type;

  const SenderMessageCard(
      {Key? key, required this.message, required this.date, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: textLightColor,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: type == MessageEnum.text
                    ? const EdgeInsets.only(
                        left: 10,
                        right: 60,
                        top: 5,
                        bottom: 20,
                      )
                    : const EdgeInsets.only(
                        left: 1,
                        top: 1,
                        right: 1,
                        bottom: 25,
                      ),
                child: DisplayTextImage(message: message, type: type),
              ),
              Positioned(
                bottom: 2,
                right: 10,
                child: Text(
                  date,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[400],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
