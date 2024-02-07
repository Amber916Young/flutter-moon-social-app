import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moon/src/core/route/app_router.dart';
import '../../../../../localization/language_constrants.dart';
import '../../../../core/component/custom_dialog.dart';

class ExitRegistrationDialog extends StatelessWidget {
  const ExitRegistrationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      buttonTextTrue: getTranslated('confirm', context),
      buttonTextFalse: getTranslated('cancel', context),
      description: 'Are you sure you want to exit the registration flow?',
      icon: Icons.contact_support,
      title: getTranslated('exit_register_flow', context),
      onTapTrue: () {
        Navigator.of(context).pop();

        if (GoRouter.of(context).canPop()) {
          GoRouter.of(context).pop();
        } else {
          GoRouter.of(context).go(RouteUri.register);
        }
      },
      onTapFalse: () => Navigator.of(context).pop(),
    );
  }
}
