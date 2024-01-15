import 'package:flutter/material.dart';
import 'package:moon/src/core/constant/app_dimensions.dart';

class TagWithIcon extends StatelessWidget {
  final String tagText;
  final IconData? iconData;
  final double? iconSize;
  final Color? color;
  TagWithIcon({required this.tagText,  this.iconSize=20, this.iconData,this.color = Colors.white,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
      padding: EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          iconData== null? const SizedBox():Icon(iconData,size: iconSize,),
          SizedBox(width:   iconData== null? 0:Dimensions.paddingSizeExtraSmall),
          Text(
            tagText,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: TagWithIcon(tagText: 'Lv.2', iconData: Icons.star),
        ),
      ),
    ),
  );
}
