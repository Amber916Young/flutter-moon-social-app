import 'package:moon/main.dart';
import 'package:moon/src/core/component/custom_snackbar.dart';
import 'package:moon/src/core/data/model/response/error_response.dart';
import 'package:moon/src/features/auth/presentation/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class ApiChecker {
  static String checkError(ErrorResponse error) {
    if (error.errors![0].code == '' || error.errors![0].code == 'authentication-failed' || error.errors![0].code == '401' || error.errors![0].code == 'auth-001') {
      // Provider.of<AuthProvider>(Get.context!, listen: false).clearSharedData().then((condition) {
      //   Provider.of<ProfileProvider>(Get.context!, listen: false).clearUserInfo();
      // });
    } else {
      showCustomSnackBar(error.errors![0].message);
    }
    return error.errors![0].message ?? "";
  }
}
