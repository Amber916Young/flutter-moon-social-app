import 'package:flutter/material.dart';
import 'package:moon/src/core/constant/app_dimensions.dart';

class CustomDivider extends StatelessWidget {
  final double height;
  final Color color;

  const CustomDivider({Key? key, this.height = 1, this.color = Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

class CustomDividerWithText extends StatelessWidget {
  final String? middleText;
  const CustomDividerWithText({Key? key, this.middleText = "OR"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Expanded(child: Divider()),
      const SizedBox(
        width: Dimensions.paddingSizeSmall,
      ),
      Text(
        middleText ?? "OR",
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      const SizedBox(
        width: Dimensions.paddingSizeSmall,
      ),
      const Expanded(child: Divider()),
    ]);
  }
}
