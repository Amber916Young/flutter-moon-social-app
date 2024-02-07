import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:moon/localization/language_constrants.dart';
import 'package:moon/src/core/component/custom_button.dart';
import 'package:moon/src/core/component/custom_card.dart';
import 'package:moon/src/core/component/custom_snackbar.dart';
import 'package:moon/src/core/component/custom_text_field.dart';
import 'package:moon/src/core/constant/app_color_resources.dart';
import 'package:moon/src/core/constant/app_dimensions.dart';
import 'package:moon/src/core/constant/images.dart';
import 'package:moon/src/core/helper/responsive_helper.dart';
import 'package:moon/src/core/route/app_router.dart';
import 'package:moon/src/features/auth/data/model/user_log_model.dart';
import 'package:moon/src/features/auth/presentation/provider/auth_provider.dart';
import 'package:moon/src/features/auth/presentation/widget/code_picker_widget.dart';
import 'package:provider/provider.dart';
import 'package:moon/src/core/component/custom_card.dart';
import 'package:moon/src/core/constant/images.dart';
import 'package:moon/src/features/auth/presentation/widget/policy_term_view.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _phoneNumberFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>();
  String? countryCode = "CN";

  Future<void> getUserData() async {
    // UserLogModel? userData = await Provider.of<AuthProvider>(context, listen: false).getUserData();

    if (context.mounted) {
      // if (userData != null) {
      //   _passwordController.text = userData.password ?? '';
      //   if (userData.phoneNumber != null) {
      //     _phoneNumberController.text = userData.phoneNumber!;
      //     countryCode = userData.countryCode;
      //   }
      //   setState(() {
      //     _passwordController.text;
      //     _phoneNumberController.text;
      //     countryCode;
      //   });
      // }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        getUserData();
      }
    });
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomCardForm(
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) => Form(
          key: _formKeyLogin,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(Images.logo, width: 120, height: 120),
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault),

              Center(
                child: Text(
                  getTranslated('women_support_transmits', context)!,
                  style: Theme.of(context).textTheme.headlineSmall!,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeExtraLarge),
              const SizedBox(height: Dimensions.paddingSizeExtraLarge),

              CustomTextField(
                hintText: getTranslated('login_hint', context),
                isShowBorder: false,
                isPassword: false,
                labelText: getTranslated('login_hint', context),
                isShowSuffixIcon: true,
                focusNode: _phoneNumberFocus,
                controller: _phoneNumberController,
                nextFocus: _passwordFocus,
                inputAction: TextInputAction.done,
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge),

              const SizedBox(height: Dimensions.paddingSizeSmall),
              CustomTextField(
                hintText: getTranslated('password_hint', context),
                isShowBorder: false,
                isPassword: true,
                labelText: getTranslated('password', context)!,
                isShowSuffixIcon: true,
                focusNode: _passwordFocus,
                controller: _passwordController,
                inputAction: TextInputAction.done,
              ),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      authProvider.toggleRememberMe();
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(color: authProvider.isActiveRememberMe ? Theme.of(context).primaryColorLight : Colors.white, border: Border.all(color: authProvider.isActiveRememberMe ? Colors.transparent : Theme.of(context).primaryColor), borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
                          child: authProvider.isActiveRememberMe ? const Icon(Icons.done, color: Colors.white, size: 17) : const SizedBox.shrink(),
                        ),
                        const SizedBox(width: Dimensions.paddingSizeSmall),
                        Text(
                          getTranslated('remember_me', context)!,
                          style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: ColorResources.getHintColor(context)),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              authProvider.loginErrorMessage!.isNotEmpty
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        authProvider.loginErrorMessage!.isNotEmpty ? CircleAvatar(backgroundColor: Theme.of(context).primaryColor, radius: 5) : const SizedBox.shrink(),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            authProvider.loginErrorMessage ?? "",
                            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        )
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(
                height: Dimensions.paddingSizeDefault,
              ),
              !authProvider.isLoading
                  ? CustomButton(
                      btnTxt: getTranslated('login', context),
                      onTap: () async {
                        String? dialCode;
                        if (countryCode != null) {
                          dialCode = CountryCode.fromCountryCode(countryCode!).dialCode!;
                        }
                        String email = dialCode! + _phoneNumberController.text.trim();

                        String password = _passwordController.text.trim();
                        if (_phoneNumberController.text.isEmpty) {
                          showCustomSnackBar(getTranslated('enter_phone_number', context));
                        } else if (password.isEmpty) {
                          showCustomSnackBar(getTranslated('enter_password', context));
                        } else if (password.length < 6) {
                          showCustomSnackBar(getTranslated('password_should_be', context));
                        } else {
                          SmartDialog.showLoading();
                          await Future.delayed(const Duration(seconds: 1));
                          SmartDialog.dismiss();
                          if (context.mounted) {
                            GoRouter.of(context).go(RouteUri.main);
                          }

                          // authProvider.login(email, password).then((status) async {
                          //   if (status) {
                          //
                          //     // if (authProvider.isActiveRememberMe) {
                          //     //   authProvider.saveUserNumberAndPassword(UserLogModel(
                          //     //     countryCode: countryCode,
                          //     //     phoneNumber: _phoneNumberController.text,
                          //     //     email: null,
                          //     //     password: password,
                          //     //   ));
                          //     // } else {
                          //     //   authProvider.clearUserLog();
                          //     // }
                          //   } else {
                          //     showCustomSnackBar(authProvider.loginErrorMessage);
                          //   }
                          // });
                        }
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    )),

              // for create an account
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
                height: Dimensions.paddingSizeLarge,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      GoRouter.of(context).go(RouteUri.phoneLogin);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                      child: Text(
                        getTranslated('phone_login', context)!,
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: Dimensions.fontSizeSmall),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      GoRouter.of(context).go(RouteUri.createAccount);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                      child: Text(
                        getTranslated('create_an_account', context)!,
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: Dimensions.fontSizeSmall),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: Dimensions.paddingSizeLarge,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                      onTap: () {},
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
                        ),
                        child: const Icon(
                          Icons.wechat,
                          color: ColorResources.successColor,
                          size: 30,
                        ),
                      )),
                  InkWell(
                      onTap: () {},
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
                        ),
                        child: const Icon(
                          Icons.apple,
                          color: ColorResources.colorNero,
                          size: 30,
                        ),
                      )),
                ],
              ),
              const SizedBox(
                height: Dimensions.paddingSizeExtraExtraLarge,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
