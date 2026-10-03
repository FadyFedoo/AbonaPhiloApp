import 'package:flutter/material.dart';

import '../core/constants.dart';

class DefaultRadioButton extends StatelessWidget {
  const DefaultRadioButton(
      {super.key,
      required this.value,
      required this.selectedValue,
      required this.onChanged});

  final String? value;
  final String? selectedValue;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Radio<String?>.adaptive(
      activeColor: primaryColor,
      fillColor: MaterialStateProperty.all(primaryColor),
      value: value,
      groupValue: selectedValue,
      onChanged: onChanged,
    );
  }
}
