import 'package:flutter/material.dart';

class CheckBox extends StatelessWidget {
  const CheckBox({this.value, this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          return onChanged(!value);
        },
        child: value
            ? Image.asset('images/filled_check.png')
            : Image.asset('images/empty_check.png'));
  }
}
