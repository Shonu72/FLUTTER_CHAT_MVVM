import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/core/utils/enums.dart';
import 'package:charterer/presentation/screens/chats/widgets/cached_video_player.dart';
import 'package:charterer/presentation/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';

class DisplayTextImage extends StatelessWidget {
  final String message;
  final MessageEnum type;
  const DisplayTextImage({
    super.key,
    required this.message,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;
    final AudioPlayer audioPlayer = AudioPlayer();
    return SingleChildScrollView(
      child: type == MessageEnum.text
          ? AppText(
              text: message,
              color: whiteColor,
            )
          : type == MessageEnum.audio
              ? StatefulBuilder(builder: (context, setState) {
                  return IconButton(
                    constraints: const BoxConstraints(
                      minWidth: 60,
                    ),
                    onPressed: () async {
                      if (isPlaying) {
                        await audioPlayer.pause();
                        setState(() {
                          isPlaying = false;
                        });
                      } else {
                        await audioPlayer.play(UrlSource(message));
                        setState(() {
                          isPlaying = true;
                        });
                      }
                    },
                    icon: Icon(
                      isPlaying ? Icons.pause_circle : Icons.play_circle,
                      color: isPlaying ? whiteColor : Colors.yellowAccent,
                    ),
                  );
                })
              : type == MessageEnum.video
                  ? VideoPlayerItem(
                      videoUrl: message,
                    )
                  : type == MessageEnum.file
                      ? CachedNetworkImage(
                          imageUrl: message,
                        )
                      : CachedNetworkImage(
                          imageUrl: message,
                          height: 400,
                          fit: BoxFit.cover,
                        ),
    );
  }
}
