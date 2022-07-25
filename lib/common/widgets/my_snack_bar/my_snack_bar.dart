import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/widgets/my_snack_bar/snack_bar_type.dart';

class MySnackBar extends StatelessWidget {
  const MySnackBar({
    super.key,
  });

  static SnackBar showSnackBar({
    required BuildContext context,
    required SnackBarType snackBarType,
    required String content,
  }) {
    final textTheme = Theme.of(context).textTheme;
    late Color backgroundColor;
    late Color contentColor;
    if (snackBarType.isWarning()) {
      backgroundColor = const Color(0xfffffcf4);
      contentColor = const Color(0xff8c6d1f);
    } else if (snackBarType.isError()) {
      backgroundColor = const Color(0xfff9e5e6);
      contentColor = const Color(0xff881b1b);
    } else if (snackBarType.isInfo()) {
      backgroundColor = const Color(0xffe3fcec);
      contentColor = const Color(0xff197741);
    }

    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      margin: EdgeInsets.zero,
      elevation: 0,
      content: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 16,
            ),
            decoration: ShapeDecoration(
              shape: const StadiumBorder(),
              color: backgroundColor,
            ),
            child: Text(
              content,
              style: textTheme.labelMedium!.copyWith(
                color: contentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
