import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void notifyMaxSoundsReached() {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: "6 sounds can be played at the same time.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black, 
      textColor: Colors.white,
      fontSize: 16.0);
}

void notificationStartCountdown() {
  Fluttertoast.showToast(
      msg: "The time has started",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0);
}
