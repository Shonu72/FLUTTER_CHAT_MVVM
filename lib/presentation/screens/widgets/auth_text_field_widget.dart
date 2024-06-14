import 'package:charterer/core/theme/colors.dart';
import 'package:flutter/material.dart';

class AuthTextFieldWidget extends StatefulWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final FormFieldValidator validator;
  final bool obscureText;
  final Icon prefixIcon;
  final IconData? suffixIcon;

  const AuthTextFieldWidget({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.controller,
    required this.validator,
    required this.keyboardType,
    this.obscureText = false,
    required this.prefixIcon,
    this.suffixIcon,
  });

  @override
  State<AuthTextFieldWidget> createState() => _AuthTextFieldWidgetState();
}

class _AuthTextFieldWidgetState extends State<AuthTextFieldWidget> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 5),
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        cursorColor: Colors.white,
        style: const TextStyle(color: whiteColor),
        obscureText: widget.obscureText ? !isVisible : false,
        decoration: InputDecoration(
          hintText: widget.hintText,
          label: Text(widget.labelText),
          suffixIcon: widget.obscureText
              ? IconButton(
                  onPressed: () {
                    if (widget.obscureText) {
                      setState(() => isVisible = !isVisible);
                    }
                  },
                  icon:
                      Icon(isVisible ? Icons.visibility : Icons.visibility_off))
              : widget.suffixIcon != null
                  ? Icon(widget.suffixIcon)
                  : null,
          prefixIcon: widget.prefixIcon,
          prefixIconColor: Colors.white,
          suffixIconColor: Colors.white,
          hintStyle: const TextStyle(color: Colors.white),
          labelStyle: const TextStyle(color: Colors.white),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
