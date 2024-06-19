import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/core/utils/enums.dart';
import 'package:charterer/presentation/screens/chats/widgets/cached_video_player.dart';
import 'package:charterer/presentation/widgets/app_text_widget.dart';
import 'package:file_preview/file_preview.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
    return type == MessageEnum.text
        ? AppText(
            text: message,
            color: whiteColor,
          )
        : type == MessageEnum.video
            ? VideoPlayerItem(
                videoUrl: message,
              )
            : type == MessageEnum.file
                ? FilePreviewWidget(
                    width: 100,
                    height: 30,
                    path: message,
                  )
                : CachedNetworkImage(
                    imageUrl: message,
                  );
  }
}
