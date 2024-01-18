import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moon/src/core/component/custom_icon_botton.dart';
import 'package:moon/src/core/constant/app_dimensions.dart';

class UserHeaderWidget extends StatefulWidget {
  final String username;
  final String imageUrl;
  final String time;

  const UserHeaderWidget({
    Key? key,
    required this.username,
    required this.imageUrl,
    required this.time,
  }) : super(key: key);

  @override
  State<UserHeaderWidget> createState() => _UserHeaderWidgetState();
}

class _UserHeaderWidgetState extends State<UserHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.imageUrl),
                  radius: 18,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.username,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          widget.time,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ),
                CustomIconButton(icon: Icons.more_vert, size: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
