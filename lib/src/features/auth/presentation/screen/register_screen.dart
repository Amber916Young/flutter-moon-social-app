import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:moon/localization/language_constrants.dart';
import 'package:moon/src/core/component/custom_app_bar.dart';
import 'package:moon/src/core/component/custom_button.dart';
import 'package:moon/src/core/component/custom_card.dart';
import 'package:moon/src/core/component/custom_loading.dart';
import 'package:moon/src/core/component/custom_snackbar.dart';
import 'package:moon/src/core/component/custom_text_field.dart';
import 'package:moon/src/core/constant/app_color_resources.dart';
import 'package:moon/src/core/constant/app_dimensions.dart';
import 'package:moon/src/core/constant/images.dart';
import 'package:moon/src/core/helper/responsive_helper.dart';
import 'package:moon/src/core/route/routes.dart';
import 'package:moon/src/features/auth/presentation/provider/auth_provider.dart';
import 'package:moon/src/features/auth/presentation/widget/code_picker_widget.dart';
import 'package:provider/provider.dart';
import 'package:moon/src/features/auth/presentation/widget/policy_term_view.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController? _numberController;
  final FocusNode _numberFocus = FocusNode();
  String? countryCode = "CN";

  @override
  void initState() {
    super.initState();
    _numberController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isBackButtonExist: true,
        context: context,
        title: getTranslated('signup', context)!,
      ),
      body: CustomCardForm(
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(Images.logo, width: 120, height: 120),
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault),

              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), border: Border(bottom: BorderSide(width: 1, color: Theme.of(context).primaryColor))),
                child: Row(children: [
                  CodePickerWidget(
                    onChanged: (CountryCode value) {
                      countryCode = value.code;
                    },
                    initialSelection: countryCode,
                    favorite: [countryCode!],
                    showDropDownButton: true,
                    padding: EdgeInsets.zero,
                    showFlagMain: true,
                    textStyle: TextStyle(color: Theme.of(context).textTheme.displayLarge!.color),
                  ),
                  Expanded(
                      child: CustomTextField(
                    hintText: getTranslated('number_hint', context),
                    isShowBorder: false,
                    controller: _numberController,
                    focusNode: _numberFocus,
                    inputType: TextInputType.phone,
                    inputAction: TextInputAction.done,
                  )),
                ]),
              ),

              const SizedBox(
                height: Dimensions.paddingSizeExtraLarge,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  authProvider.verificationMessage!.isNotEmpty ? CircleAvatar(backgroundColor: Theme.of(context).primaryColor, radius: 5) : const SizedBox.shrink(),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      authProvider.verificationMessage ?? "",
                      style: Theme.of(context).textTheme.displayMedium!.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  )
                ],
              ),
              // for continue button
              const SizedBox(
                height: Dimensions.paddingSizeDefault,
              ),
              CustomButton(
                btnTxt: getTranslated('get_verify_code', context),
                onTap: () {
                  String numberChk = _numberController!.text.trim();
                  String countryCodeStr = CountryCode.fromCountryCode(countryCode!).dialCode!;
                  if (countryCodeStr == "+353") {
                    if (numberChk.isNotEmpty && numberChk[0] == '0') {
                      numberChk = numberChk.substring(1);
                    }
                  }
                  // String countryCode;
                  String number = '$countryCodeStr$numberChk';

                  if (numberChk.isEmpty) {
                    showCustomSnackBar(getTranslated('enter_phone_number', context));
                  } else {
                    // authProvider.checkPhone(number).then((value) async {
                    //   if (value) {
                    //     authProvider.updatePhone(number);
                    //     if (authProvider.verificationMessage == 'active') {
                    //       Navigator.pushNamed(context, Routes.getVerifyRoute('sign-up', number));
                    //     } else {
                    //       Navigator.pushNamed(context, Routes.getCreateAccountRoute(number));
                    //     }
                    //   }
                    // });
                  }
                },
              ),
              const SizedBox(
                height: Dimensions.paddingSizeLarge,
              ),
              InkWell(
                onTap: () {
                  authProvider.toggleAgree();
                },
                child: Row(
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(color: authProvider.isAgreePolicy ? Theme.of(context).primaryColorLight : Colors.white, border: Border.all(color: authProvider.isAgreePolicy ? Colors.transparent : Theme.of(context).primaryColor), borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                      child: authProvider.isAgreePolicy ? const Icon(Icons.done, color: Colors.white, size: 17) : const SizedBox.shrink(),
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    const PolicyWidget(),
                  ],
                ),
              ),

              const SizedBox(
                height: Dimensions.paddingSizeExtraLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
