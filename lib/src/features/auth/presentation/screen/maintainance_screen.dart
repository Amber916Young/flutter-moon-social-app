import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moon/localization/language_constrants.dart';
import 'package:moon/src/core/component/custom_button.dart';
import 'package:moon/src/core/constant/app_dimensions.dart';
import 'package:moon/src/core/constant/images.dart';
import 'package:moon/src/core/route/app_router.dart';
// import 'package:moon/src/features/splash/presentation/provider/splash_provider.dart';

import 'package:provider/provider.dart';

class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({Key? key}) : super(key: key);

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  @override
  void initState() {
    Future(() {
      // if (!Provider.of<SplashProvider>(context, listen: false).configModel!.maintenanceMode!) {
      //   GoRouter.of(context).go(RouteUri.main);
      // }
    });

    super.initState();
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
            const SizedBox(height: 50),
            CustomButton(
              btnTxt: getTranslated('back_menu', context),
              onTap: () {
                GoRouter.of(context).go(RouteUri.main);
              },
            )
          ]),
        ),
      ),
    );
  }
}
