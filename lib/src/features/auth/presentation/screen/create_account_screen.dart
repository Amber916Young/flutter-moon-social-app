import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moon/localization/language_constrants.dart';
import 'package:moon/src/core/component/custom_app_bar.dart';
import 'package:moon/src/core/component/custom_button.dart';
import 'package:moon/src/core/component/custom_card.dart';
import 'package:moon/src/core/component/custom_snackbar.dart';
import 'package:moon/src/core/component/custom_text_field.dart';
import 'package:moon/src/core/constant/app_color_resources.dart';
import 'package:moon/src/core/constant/app_dimensions.dart';
import 'package:moon/src/core/helper/email_checker.dart';
import 'package:moon/src/core/helper/responsive_helper.dart';
import 'package:moon/src/core/route/app_router.dart';
import 'package:moon/src/features/auth/data/model/signup_model.dart';
import 'package:moon/src/features/auth/presentation/provider/auth_provider.dart';
import 'package:moon/src/features/auth/presentation/widget/cancel_process_dialog.dart';
import 'package:provider/provider.dart';

class CreateAccountScreen extends StatefulWidget {
  final String email;

  const CreateAccountScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final SignUpModel signUpModel = SignUpModel();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _dateOfBirthFocus = FocusNode();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  String? _countryDialCode = "86";

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isPhone = EmailChecker.isNotValid(widget.email);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {},
      child: Scaffold(
        appBar: (ResponsiveHelper.isDesktop(context)
            ? const PreferredSize(preferredSize: Size.fromHeight(80), child: SizedBox())
            : CustomAppBar(
                context: context,
                title: getTranslated('create_account', context),
                onBackPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const ExitRegistrationDialog(),
                  );
                },
              )) as PreferredSizeWidget?,
        body: CustomCardForm(
            child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponsiveHelper.isMobile()
                  ? const SizedBox()
                  : const SizedBox(
                      height: Dimensions.paddingSizeExtraLarge,
                    ),
              ResponsiveHelper.isMobile()
                  ? const SizedBox()
                  : Center(
                      child: Text(
                        getTranslated('create_account', context)!,
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Theme.of(context).primaryColor, height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                    ),
              Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getTranslated('first_name', context)!,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ColorResources.getHintColor(context)),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    CustomTextField(
                      hintText: 'Enter your first name',
                      isShowBorder: true,
                      controller: _firstNameController,
                      focusNode: _firstNameFocus,
                      nextFocus: _lastNameFocus,
                      inputType: TextInputType.name,
                      capitalization: TextCapitalization.words,
                    ),
                  ],
                ),
              ),

              // Last Name TextField
              Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getTranslated('last_name', context)!,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ColorResources.getHintColor(context)),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    CustomTextField(
                      hintText: 'Enter your last name',
                      isShowBorder: true,
                      controller: _lastNameController,
                      focusNode: _lastNameFocus,
                      nextFocus: _usernameFocus,
                      inputType: TextInputType.name,
                      capitalization: TextCapitalization.words,
                    ),
                  ],
                ),
              ),

              // Username TextField
              Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getTranslated('user_name', context)!,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ColorResources.getHintColor(context)),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    CustomTextField(
                      hintText: 'Enter your username',
                      isShowBorder: true,
                      controller: _usernameController,
                      focusNode: _usernameFocus,
                      nextFocus: _emailFocus,
                      inputType: TextInputType.name,
                      capitalization: TextCapitalization.words,
                    ),
                  ],
                ),
              ),

              // Email TextField
              Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getTranslated('email', context)!,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ColorResources.getHintColor(context)),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    CustomTextField(
                      hintText: getTranslated('demo_gmail', context),
                      isShowBorder: true,
                      controller: _emailController,
                      focusNode: _emailFocus,
                      nextFocus: _phoneFocus,
                      inputType: TextInputType.emailAddress,
                    ),
                  ],
                ),
              ),

              // Phone TextField
              Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getTranslated('number', context)!,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ColorResources.getHintColor(context)),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    CustomTextField(
                      hintText: getTranslated('enter_phone_number', context)!,
                      isShowBorder: true,
                      controller: _phoneController,
                      focusNode: _phoneFocus,
                      nextFocus: _passwordFocus,
                      inputType: TextInputType.phone,
                    ),
                  ],
                ),
              ),

              // Date of Birth TextField
              Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date of Birth',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ColorResources.getHintColor(context)),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    InkWell(
                      child: CustomTextField(
                        hintText: 'Enter your date of birth',
                        isShowBorder: true,
                        readOnly: true,
                        controller: _dateOfBirthController,
                        focusNode: _dateOfBirthFocus,
                        inputType: TextInputType.datetime,
                        nextFocus: _passwordFocus,
                      ),
                      onTap: () => _selectDate(context),
                    )
                  ],
                ),
              ),

              // Password TextField
              Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getTranslated('password', context)!,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ColorResources.getHintColor(context)),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    CustomTextField(
                      hintText: getTranslated('password_hint', context),
                      isShowBorder: true,
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      nextFocus: _dateOfBirthFocus,
                      inputType: TextInputType.visiblePassword,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getTranslated('confirm_password', context)!,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ColorResources.getHintColor(context)),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                    CustomTextField(
                      hintText: getTranslated('password_hint', context),
                      isShowBorder: true,
                      isPassword: true,
                      controller: _confirmPasswordController,
                      focusNode: _confirmPasswordFocus,
                      isShowSuffixIcon: true,
                      inputAction: TextInputAction.done,
                    ),
                  ],
                ),
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  authProvider.registrationErrorMessage!.isNotEmpty ? CircleAvatar(backgroundColor: Theme.of(context).primaryColor, radius: 5) : const SizedBox.shrink(),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      authProvider.registrationErrorMessage ?? "",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  )
                ],
              ),

              // for signup button
              const SizedBox(height: 10),
              !authProvider.isLoading
                  ? CustomButton(
                      btnTxt: getTranslated('signup', context),
                      onTap: () async {
                        String firstName = _firstNameController.text.trim();
                        String lastName = _lastNameController.text.trim();
                        String number = _countryDialCode! + _phoneController.text.trim();
                        String email = _emailController.text.trim();
                        String password = _passwordController.text.trim();
                        String confirmPassword = _confirmPasswordController.text.trim();

                        if (firstName.isEmpty) {
                          showCustomSnackBar(getTranslated('enter_first_name', context));
                        } else if (lastName.isEmpty) {
                          showCustomSnackBar(getTranslated('enter_last_name', context));
                        } else if (number.isEmpty) {
                          showCustomSnackBar(getTranslated('enter_phone_number', context));
                        } else if (EmailChecker.isNotValid(email)) {
                          showCustomSnackBar(getTranslated('enter_valid_email', context));
                        } else if (password.isEmpty) {
                          showCustomSnackBar(getTranslated('enter_password', context));
                        } else if (password.length < 6) {
                          showCustomSnackBar(getTranslated('password_should_be', context));
                        } else if (confirmPassword.isEmpty) {
                          showCustomSnackBar(getTranslated('enter_confirm_password', context));
                        } else if (password != confirmPassword) {
                          showCustomSnackBar(getTranslated('password_did_not_match', context));
                        } else {
                          SignUpModel signUpModel = SignUpModel(
                            firstName: firstName,
                            lastName: lastName,
                            email: email,
                            password: password,
                            phone: widget.email,
                          );
                          // await authProvider.registration(signUpModel).then((status) async {
                          //   if (status) {
                          //     GoRouter.of(context).go(RouteUri.main);
                          //   }
                          // });
                        }
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    )),

              // for already an account
              const SizedBox(height: 11),
              InkWell(
                onTap: () {
                  GoRouter.of(context).go(RouteUri.login);

                  // Navigator.pushReplacementNamed(context, Routes.getLoginRoute());
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        getTranslated('already_have_account', context)!,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor.withOpacity(0.7)),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeSmall),
                      Text(
                        getTranslated('login', context)!,
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: Dimensions.fontSizeSmall, color: ColorResources.getGreyBunkerColor(context)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
