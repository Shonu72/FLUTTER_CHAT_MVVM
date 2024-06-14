import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../core/theme/colors.dart';
import '../../../core/utils/helpers.dart';
import '../custom_text_field.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  final String type;
  final String? hint;
  final int? maxLines;
  final bool isNumber;
  final ValueChanged<String>? onChanged;
  final bool isRequired;
  final TextInputAction? textInputAction;
  final String? icon;
  final Function()? onTap;
  final bool isReadableOnly;
  final double? scrollBottomPadding;
  final Color? titleColor;
  const TextFieldWidget({
    Key? key,
    required this.textEditingController,
    this.type = 'normal',
    this.hint,
    this.maxLines,
    this.isNumber = false,
    this.onChanged,
    this.isRequired = false,
    this.textInputAction,
    this.icon,
    this.onTap,
    this.isReadableOnly = false,
    this.scrollBottomPadding,
    this.titleColor,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool isVisible = false;

  DateTime selectedDate = DateTime.now();
  DateTime date = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      validator: (value) {
        if (widget.isRequired) {
          switch (widget.type) {
            case 'normal':
              return Helpers.validateField(value!);
            case 'email':
              return Helpers.validateEmail(value!);
            case 'phone':
              return Helpers.validatePhone(value!);
            default:
              return Helpers.validateField(value!);
          }
        }
        return null;
      },
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      inputFormatters: widget.isNumber
          ? [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ]
          : widget.type == "username"
              ? [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ]
              : null,
      input: widget.textEditingController,
      obscureText: widget.type == 'password' ? !isVisible : isVisible,
      hintText: widget.hint,
      textCapitalization: TextCapitalization.none,
      keyboardType: widget.isNumber
          ? TextInputType.number
          : widget.type == 'email'
              ? TextInputType.emailAddress
              : widget.textInputAction == TextInputAction.newline
                  ? TextInputType.multiline
                  : TextInputType.name,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      isReadableOnly: widget.isReadableOnly,
      maxLines: widget.maxLines ?? 1,
      scrollBottomPadding: widget.scrollBottomPadding ??
          MediaQuery.of(context).viewInsets.bottom,
      iconButton: widget.type == 'password'
          ? IconButton(
              padding: const EdgeInsets.all(0.0),
              icon: Icon(
                isVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: iconTintColor,
                size: 15,
              ),
              onPressed: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
            )
          : widget.icon != null
              ? IconButton(
                  padding: const EdgeInsets.all(0.0),
                  icon: SvgPicture.asset(
                    widget.icon!,
                  ),
                  onPressed: widget.onTap,
                  color: Colors.black,
                )
              : null,
    );
  }
}
