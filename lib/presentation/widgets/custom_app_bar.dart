import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// import '../../core/theme/colors.dart';

PreferredSizeWidget appBar({
  required BuildContext context,
  String? title,
  IconData? otherIcon,
  Color? txtColor,
  Function()? onBack,
  bool isBackIcon = true,
}) {
  // final textTheme = Theme.of(context).textTheme;
  return PreferredSize(
    preferredSize: const Size(double.infinity, 70),
    child: SafeArea(
      child: Container(
        margin: const EdgeInsets.all(15),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                  textAlign: TextAlign.center,
                  title ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ),
            isBackIcon
                ? InkWell(
                    onTap: () {
                      if (onBack != null) {
                        onBack();
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child:  SizedBox(
                      width: 42,
                      height: 42,
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    ),
  );
}
