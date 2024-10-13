import 'package:flutter/material.dart';

class CustomSnackbar extends SnackBar {
  CustomSnackbar({
    super.key,
    required String msg,
    String btnLabel = 'OK',
    super.duration = const Duration(seconds: 2),
    VoidCallback? onBtnPressed
  }) : super(
    content: Text(msg),
    action: SnackBarAction(
      label: btnLabel, 
      onPressed: () {
        if (onBtnPressed != null) {
          onBtnPressed();
        }
      }
    )
  );
}