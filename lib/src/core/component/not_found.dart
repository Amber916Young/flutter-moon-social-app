import 'package:flutter/material.dart';
import 'package:moon/src/core/helper/responsive_helper.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: !ResponsiveHelper.isDesktop(context) && height < 600 ? height : height - 400),
              child: Center(
                child: TweenAnimationBuilder(
                  curve: Curves.bounceOut,
                  duration: const Duration(seconds: 2),
                  tween: Tween<double>(begin: 12.0, end: 30.0),
                  builder: (BuildContext context, dynamic value, Widget? child) {
                    return Text('Page Not Found', style: TextStyle(fontWeight: FontWeight.bold, fontSize: value));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
