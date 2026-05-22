import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void notifyMaxSoundsReached([String? message]) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message ?? "6 sounds can be played at the same time.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black, 
      textColor: Colors.white,
      fontSize: 16.0);
}

void notificationStartCountdown([String? message]) {
  Fluttertoast.showToast(
      msg: message ?? "The time has started",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0);
}

