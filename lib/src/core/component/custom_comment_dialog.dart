import 'package:flutter/material.dart';
import 'package:moon/localization/language_constrants.dart';
import 'package:moon/src/core/component/custom_button.dart';
import 'package:moon/src/core/component/custom_text_field.dart';

class CustomCommentPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text('取消'),
                ),
                SizedBox(
                  width: 80,
                  child: CustomButton(btnTxt: "发送", onTap: () {}),
                )
              ],
            ),
          ),
          Divider(thickness: 2, indent: 0, endIndent: 0),
          const CustomTextField(
            hintText: "表达善意才能收获善意",
            isShowBorder: false,
            inputType: TextInputType.text,
            inputAction: TextInputAction.done,
            maxLength: 800,
            maxLines: 8,
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.add_link_sharp),
                    Text(
                      "话题",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    Icon(Icons.forward_to_inbox_rounded),
                    Text(
                      "用户",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
