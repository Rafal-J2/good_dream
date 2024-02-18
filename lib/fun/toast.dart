//show text
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toast() {
  Fluttertoast.cancel();
  Fluttertoast.showToast(

      msg:"6 sounds can be played at the same time.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black, //Colors.black45
      textColor: Colors.white,
      fontSize: 16.0);
}

void toast3() {
  Fluttertoast.showToast(
      msg: "The time has started",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white, //Colors.white70
      textColor: Colors.black,
      fontSize: 16.0);
}