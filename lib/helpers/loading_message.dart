import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoadingMessage(BuildContext context) {
  
  if (Platform.isAndroid) { //Android:
    showDialog(
      context: context, 
      barrierDismissible: false, // la persona no puede cancelarlo
      builder: (context) => AlertDialog(
        title: const Text('Just a moment.'),
        content: Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(top: 6),
          child: const Column(
            children: [
              Text('Calculating your trip...'),
              SizedBox(height: 12),
              CircularProgressIndicator(strokeWidth: 2, color: Colors.black)
            ],
          ),
        ),
      ),
    );
    return;
  }

  // IOS:
  showCupertinoDialog(
    context: context, 
    builder: (context) => const CupertinoAlertDialog(
      title: Text('Just a moment.'),
      content: CupertinoActivityIndicator(),
    ),
  );

}