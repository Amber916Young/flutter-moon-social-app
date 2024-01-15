import 'package:flutter/material.dart';
import 'package:moon/main.dart';
import 'package:moon/src/core/component/custom_snackbar.dart';
import 'package:moon/src/core/data/model/response/error_response.dart';
import 'package:moon/src/core/route/routes.dart';
import 'package:moon/src/features/auth/presentation/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class ApiChecker {
  static String checkError(ErrorResponse error) {
    //&& ModalRoute.of(Get.context!)?.settings.name != Routes.getLoginRoute()
    if (error.errors![0].code == '' || error.errors![0].code == '401' || error.errors![0].code == 'auth-001') {
      // Provider.of<AuthProvider>(Get.context!, listen: false).clearSharedData();
      // Navigator.pushNamedAndRemoveUntil(Get.context!, Routes.getMainRoute(), (route) => false);
    } else {
      showCustomSnackBar(error.errors![0].message);
    }
    return error.errors![0].message ?? "";
  }
}
