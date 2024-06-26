import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/presentation/widgets/app_text_widget.dart';
import 'package:charterer/presentation/widgets/call_history_tile.dart';
import 'package:flutter/material.dart';

class CallHistoryScreen extends StatelessWidget {
  const CallHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:
            backgroundDarkColor.withBlue(backgroundDarkColor.blue - 20),
        appBar: AppBar(
            backgroundColor: backgroundDarkColor,
            title: const AppText(
              text: "Call Screen",
              color: textWhiteColor,
              size: 20,
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: whiteColor,
              ),
            )),
        body: Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return CallHistoryTile(
                  image: "assets/images/boy.png",
                  name: "Client $index",
                  calltype: "Incoming",
                  time: "12:50 PM",
                  icon: Icons.call,
                );
              },
            )));
  }
}
