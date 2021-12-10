import 'package:flutter/material.dart';

abstract class UiUtils {
  static InputDecoration buildInputDecoration({
    BuildContext context,
    String hintText,
    String errorText,
    String suffixText,
    String labelText,
    bool isDense = true,
  }) {
    return InputDecoration(
      hintText: hintText,
      suffixText: suffixText,
      labelText: labelText,
      fillColor: Colors.white,
      isDense: isDense,
      filled: true,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      errorBorder: errorText == null
          ? null
          : OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Theme.of(context).errorColor,
              ),
            ),
      errorText: errorText,
    );
  }

  static Color mapStatusIdToColor(int id) {
    switch (id) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.blue;
      case 4:
        return Colors.blue.shade900;
      case 5:
        return Colors.lightGreen.shade300;
      case 6:
        return Colors.green;
      case 7:
        return Colors.red;
      default:
        return null;
    }
  }
}
