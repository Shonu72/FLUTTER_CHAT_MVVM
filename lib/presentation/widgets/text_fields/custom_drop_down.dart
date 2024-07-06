import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/theme/colors.dart';
import '../../../core/utils/helpers.dart';

class BuildDropdown extends StatefulWidget {
  final ValueChanged<dynamic>? onChanged;
  final dynamic defaultValue, selectedValue, dropdownHint;
  final List<DropdownMenuItem<dynamic>>? itemsList;
  final double? height;
  final double? width;
  final bool isRequired;
  final bool isMultiple;
  final List? selectedItemList;
  const BuildDropdown(
      {Key? key,
      this.itemsList,
      this.defaultValue,
      this.dropdownHint,
      this.onChanged,
      this.height,
      this.selectedValue,
      this.width,
      this.isRequired = false,
      this.isMultiple = false,
      this.selectedItemList})
      : super(key: key);

  @override
  State<BuildDropdown> createState() => _BuildDropdownState();
}

class _BuildDropdownState extends State<BuildDropdown> {
  final String _value = '';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DropdownButtonFormField2(
      value: _value.isEmpty ? widget.defaultValue : _value,
      isExpanded: true,
      hint: Text(
        widget.dropdownHint ?? 'Select',
        style: const TextStyle(color: Colors.white, fontSize: 20),
        overflow: TextOverflow.ellipsis,
      ),
      iconSize: 20,
      buttonHeight: 55,
      buttonPadding: const EdgeInsets.only(left: 0, right: 10),
      items: widget.itemsList,
      onChanged: widget.onChanged,
      validator: (dynamic value) {
        if (widget.isRequired) {
          if (widget.isMultiple) {
            if (widget.selectedItemList!.isEmpty) {
              return Helpers.validateField(value.toString());
            } else {
              return null;
            }
          } else {
            return Helpers.validateField(value.toString());
          }
        }
        return null;
      },
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white,
      ),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: const Color.fromARGB(255, 39, 36, 52),
      ),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        contentPadding: EdgeInsets.zero,
        fillColor: Colors.black.withOpacity(0.1),
        hintStyle: const TextStyle(color: Colors.white),
        labelStyle: const TextStyle(color: Colors.white),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: textFieldColor, width: widget.isMultiple ? 0 : 0.5),
          borderRadius: widget.isMultiple
              ? widget.selectedItemList!.isNotEmpty
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0))
                  : BorderRadius.circular(8.0)
              : BorderRadius.circular(8.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: textFieldColor, width: widget.isMultiple ? 0 : 0.5),
          borderRadius: widget.isMultiple
              ? widget.selectedItemList!.isNotEmpty
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0))
                  : BorderRadius.circular(8.0)
              : BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: textFieldColor, width: widget.isMultiple ? 0 : 0.5),
          borderRadius: widget.isMultiple
              ? widget.selectedItemList!.isNotEmpty
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0))
                  : BorderRadius.circular(8.0)
              : BorderRadius.circular(8.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: textErrorColor, width: 0.5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: textErrorColor, width: 0.5),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
