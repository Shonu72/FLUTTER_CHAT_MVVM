import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../core/theme/colors.dart';

class CustomButton extends StatelessWidget {
  final String? name;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final Function()? onTap;
  final double? top, bottom, left, right;
  final String? iconWidget;
  final bool outlineBtn;
  final double? radius;
  final double? height;

  const CustomButton({Key? key,
    this.color,
    required this.name,
    required this.onTap,
    this.outlineBtn = false,
    this.borderColor,
    this.textColor, this.iconWidget, this.top, this.bottom, this.left, this.right, this.radius, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;
    return SizedBox(

      width: double.infinity,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height ?? 5.5.h,
          margin: EdgeInsets.only(
              top: top ?? 0, left: left ?? 0, bottom: bottom ?? 0, right: right ?? 0),
          decoration: BoxDecoration(
            color: outlineBtn ? Colors.transparent : color ?? whiteColor ,
            border: Border.all(
              color: borderColor ?? Colors.transparent,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(radius ?? 14.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  child: iconWidget != null ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,),
                    child: SvgPicture.asset(
                      iconWidget!,
                      height: 19,
                      width: 19,
                    ),
                  ) : Container()),
              Text(name ?? 'Next',
                  textAlign: TextAlign.center,
                  style: textTheme.labelLarge?.copyWith(color: textColor ?? textCharcoalBlueColor)),
            ],
          ),
        ),
      ),
    );
  }
}
