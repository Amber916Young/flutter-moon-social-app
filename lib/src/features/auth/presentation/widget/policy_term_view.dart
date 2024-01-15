import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moon/localization/language_constrants.dart';
import 'package:moon/src/core/constant/app_color_resources.dart';
import 'package:moon/src/core/constant/app_dimensions.dart';
import 'package:moon/src/core/constant/app_text_styles.dart';
import 'package:moon/localization/language_constrants.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher_string.dart';

class PolicyWidget extends StatelessWidget {
  const PolicyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * .7, // or set a specific width
        child: RichText(
          softWrap: true,
          textAlign: TextAlign.start,
          text: TextSpan(
              text: '${getTranslated('by_continuing_you_agree_to_our', context)} ',
              children: [
                TextSpan(text: '${getTranslated('terms_of_service', context)} ', recognizer: TapGestureRecognizer()..onTap = () async {}, style: textBold.copyWith(color: Theme.of(context).primaryColorLight)),
                TextSpan(text: '${getTranslated('and', context)} '),
                TextSpan(text: '${getTranslated('privacy_policy', context)} ', recognizer: TapGestureRecognizer()..onTap = () async {}, style: textBold.copyWith(color: Theme.of(context).primaryColorLight)),
              ],
              style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: ColorResources.getHintColor(context))),
          textScaler: const TextScaler.linear(0.9),
        ));
  }
}
