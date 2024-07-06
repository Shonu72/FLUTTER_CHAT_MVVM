import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      this.input,
      this.hintText,
      this.length,
      this.onTap,
      this.labelText,
      this.helperText,
      this.onSaved,
      this.validator,
      this.preFilledValue,
      this.onFieldSubmitted,
      this.isReadableOnly = false,
      this.onChanged,
      this.keyboardType,
      this.inputFormatters,
      this.textInputAction,
      this.enabled = true,
      this.textSize,
      this.errorText,
      this.maxLines = 1,
      this.textCapitalization,
      this.borderRadius = 4,
      this.borderColor = Colors.grey,
      this.focusedBorderColor = Colors.grey,
      this.enabledBorderColor = Colors.grey,
      this.onEditingComplete,
      this.focusNode,
      this.iconButton,
      this.obscureText = false,
      this.scrollBottomPadding})
      : super(key: key);
  final TextEditingController? input;
  final String? hintText, labelText, helperText, preFilledValue, errorText;
  final TextInputAction? textInputAction;
  final int? length, maxLines;
  final Function()? onTap;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final Function()? onEditingComplete;
  final bool isReadableOnly, enabled;
  final double? textSize;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final double borderRadius;
  final Color? borderColor, focusedBorderColor, enabledBorderColor;
  final FocusNode? focusNode;
  final IconButton? iconButton;
  final bool obscureText;
  final double? scrollBottomPadding;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TextFormField(
      focusNode: widget.focusNode,
      controller: widget.input,
      onTap: widget.onTap,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      onEditingComplete: widget.onEditingComplete,
      onChanged: widget.onChanged,
      initialValue: widget.preFilledValue,
      enabled: widget.enabled,
      readOnly: widget.isReadableOnly,
      maxLength: widget.length,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      textCapitalization: widget.textCapitalization!,
      obscureText: widget.obscureText,
      // maxLengthEnforced: true,
      style: textTheme.headlineMedium?.copyWith(
          color: widget.isReadableOnly ? textInputTitleColor : textBlackColor),
      scrollPadding: EdgeInsets.only(bottom: widget.scrollBottomPadding!),

      decoration: InputDecoration(
          suffixIcon: widget.iconButton,
          counterText: '',
          filled: true,
          fillColor: Colors.black.withOpacity(0.1),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: textFieldColor, width: 0.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: textFieldColor, width: 0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: textFieldColor, width: 0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: textErrorColor, width: 0.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: textErrorColor, width: 0.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          labelStyle: textTheme.headlineMedium?.copyWith(
            color: Colors.black.withOpacity(0.6),
          ),
          errorStyle: textTheme.headlineSmall?.copyWith(color: Colors.red),
          hintText: widget.hintText,
          errorText: widget.errorText,
          hintStyle: const TextStyle(color: Colors.white),
          labelText: widget.labelText,
          helperText: widget.helperText),
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      cursorColor: textBlackColor,
    );
  }
}
