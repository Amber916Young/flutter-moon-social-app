import 'package:flutter/material.dart';
import 'package:moon/src/core/constant/app_color_resources.dart';
import 'package:moon/src/core/constant/app_dimensions.dart';

class CustomButtonGray extends StatelessWidget {
  final bool isHomeScreen;
  final Function? onTap;
  final String? btnTxt;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final double borderRadius;

  CustomButtonGray({
    Key? key,
    this.isHomeScreen = false,
    this.onTap,
    required this.btnTxt,
    this.backgroundColor,
    this.textStyle,
    this.borderRadius = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(btnTxt: btnTxt, onTap: onTap, textStyle: textStyle ?? Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorResources.colorNero, fontSize: Dimensions.fontSizeLarge), backgroundColor: ColorResources.colorLightGray, borderRadius: borderRadius);
  }
}

class CustomButtonWhite extends StatelessWidget {
  final bool isHomeScreen;
  final Function? onTap;
  final String? btnTxt;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final double borderRadius;

  CustomButtonWhite({
    Key? key,
    this.isHomeScreen = false,
    this.onTap,
    required this.btnTxt,
    this.backgroundColor,
    this.textStyle,
    this.borderRadius = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        btnTxt: btnTxt,
        borderSide: const BorderSide(
          color: ColorResources.colorLightGray, // Border color
          width: 1, // Border width
        ),
        onTap: onTap,
        textStyle: textStyle ?? Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge),
        backgroundColor: Colors.white,
        borderRadius: borderRadius);
  }
}

class CustomButtonReverse extends StatelessWidget {
  final bool isHomeScreen;
  final Function? onTap;
  final String? btnTxt;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final double borderRadius;

  CustomButtonReverse({
    Key? key,
    this.isHomeScreen = false,
    this.onTap,
    required this.btnTxt,
    this.backgroundColor,
    this.textStyle,
    this.borderRadius = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(btnTxt: btnTxt, onTap: onTap, textStyle: textStyle ?? Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge), backgroundColor: ColorResources.colorLightOrg, borderRadius: borderRadius);
  }
}

class CustomButton extends StatelessWidget {
  final bool isHomeScreen;
  final Function? onTap;
  final String? btnTxt;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final double borderRadius;
  final BorderSide? borderSide;

  CustomButton({
    Key? key,
    this.isHomeScreen = false,
    this.onTap,
    this.borderSide,
    required this.btnTxt,
    this.backgroundColor,
    this.textStyle,
    this.borderRadius = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shadowColor: isHomeScreen ? Theme.of(context).shadowColor : null,
      backgroundColor: onTap == null ? Theme.of(context).hintColor.withOpacity(0.7) : backgroundColor ?? Theme.of(context).primaryColor,
      minimumSize: Size(MediaQuery.of(context).size.width, isHomeScreen ? 80 : 50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      side: borderSide,
    );

    return TextButton(
      onPressed: onTap as void Function()?,
      style: flatButtonStyle,
      child: !isHomeScreen
          ? Text(btnTxt ?? "", style: textStyle ?? Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeLarge))
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
              child: Text(btnTxt ?? "", style: textStyle ?? Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeLarge)),

              /* Row(
                mainAxisAlignment: btnTxt?.split(';')[1] != null ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                children: [
                  Text(btnTxt?.split(';')[0] ?? "", style: textStyle ?? Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeLarge)),
                  btnTxt?.split(';')[1] != null ? Text(btnTxt?.split(';')[1] ?? "", style: textStyle ?? Theme.of(context).textTheme.displaySmall!.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeLarge)) : SizedBox(),
                ],
              ),*/
            ),
    );
  }
}
