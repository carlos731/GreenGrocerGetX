import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:motion_toast/motion_toast.dart';

import '../config/custom_colors.dart';

class UtilsServices {
  // R$ valor formatado
  String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'pt_BR');

    return numberFormat.format(price);
  }

  // Data formatada
  String formatDateTime(DateTime dateTime) {
    initializeDateFormatting();
    DateFormat dateFormat = DateFormat.yMd('pt_BR').add_Hm();
    return dateFormat.format(dateTime);
  }

  // Método usando fluttertoast

  /*
  void showToast({
    required String message,
    bool isError = false,
    required context,
  }) {
    Fluttertoast.showToast(
      msg: "Green s",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: isError ? Colors.red : Colors.white,
      textColor: Colors.black,
      fontSize: 14.0,
    );
  }
  */
  // Método para exibição de alertas usando MotionToast
  void showToast(
      {required String message,
      bool isError = false,
      bool isInfo = false,
      required context,
      required double width,
      required double height}) {
    MotionToast(
      icon: Icons.info,
      primaryColor: isError ? Colors.red : CustomColors.customSwatchColor,
      // title: const Text("Custom Toast"),
      description: Text(message),
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(vertical: 40),
    ).show(context);
  }
}
