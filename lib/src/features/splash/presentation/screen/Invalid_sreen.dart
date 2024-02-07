import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moon/localization/language_constrants.dart';
import 'package:moon/src/core/component/custom_snackbar.dart';
import 'package:moon/src/core/constant/app_dimensions.dart';
import 'package:moon/src/core/constant/images.dart';
import 'package:moon/src/core/route/app_router.dart';

class InvalidJumpScreen extends StatefulWidget {
  const InvalidJumpScreen({Key? key}) : super(key: key);

  @override
  State<InvalidJumpScreen> createState() => _InvalidJumpScreenState();
}

class _InvalidJumpScreenState extends State<InvalidJumpScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        showCustomSnackBar('${getTranslated('you_have_to_select_branch', context)}', isToast: true, isError: true, duration: 3000);
        GoRouter.of(context).go(RouteUri.splash);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(Images.maintenance, width: 200, height: 200),
            Text(
              getTranslated('maintenance_mode', context)!,
              style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Text(
              getTranslated('maintenance_text', context)!,
              textAlign: TextAlign.center,
            ),
          ]),
        ),
      ),
    );
  }
}
