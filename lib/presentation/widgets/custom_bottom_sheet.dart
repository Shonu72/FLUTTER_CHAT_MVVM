import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/theme/colors.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget child;
  final double? initialChildSize;
  final double? maxChildSize;
  final double? minChildSize;
  final bool? isDismissible;
  final double? horizontalPadding;
  final double? sheetRadius;
  const CustomBottomSheet({Key? key, required this.child, this.initialChildSize, this.maxChildSize, this.minChildSize, this.isDismissible, this.horizontalPadding, this.sheetRadius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool dismiss = isDismissible ?? true;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        dismiss ? Navigator.of(context).pop() : null;
      },
      child: DraggableScrollableSheet(
        initialChildSize: initialChildSize ?? 0.5,
        maxChildSize: maxChildSize ?? 0.5,
        minChildSize: minChildSize ?? 0.5,
        builder:(_, controller) => Container(
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(sheetRadius ?? 40)),
            ),
            padding: EdgeInsets.only(left: horizontalPadding ?? 15, right: horizontalPadding ?? 15, top: 3.h, bottom: 0.h),
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                controller: dismiss ? controller : null,
                // assign controller here
                itemCount: 1,
                itemBuilder: (_, index) {
                  return child;
                }
      ),
    )));
  }
}
