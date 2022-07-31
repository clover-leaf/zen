import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/constants/constants.dart';

class MyOutlineButton extends StatefulWidget {
  const MyOutlineButton({
    super.key,
    required this.content,
    required this.onPressed,
    this.padding = EdgeInsets.zero,
    this.innerPadding = const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
    this.textColor = const Color(0xff212121),
    this.primaryColor,
  });

  final EdgeInsets padding;
  final String content;
  final Function() onPressed;
  final Color textColor;
  final Color? primaryColor;
  final EdgeInsets innerPadding;

  @override
  State<MyOutlineButton> createState() => _MyOutlineButtonState();
}

class _MyOutlineButtonState extends State<MyOutlineButton> {
  late Color textColor;
  late Color borderColor;
  late Color primaryColor;

  @override
  void initState() {
    textColor = widget.textColor;
    borderColor = widget.textColor;
    primaryColor = widget.primaryColor ?? const Color(0xff890e4f);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Padding(
      padding: widget.padding,
      // ignore: use_decorated_box
      child: Container(
        // alignment: Alignment.centerLeft,
        decoration: ShapeDecoration(
          shape: StadiumBorder(
            side: BorderSide(
              color: borderColor,
              width: Space.globalBorderWidth.value,
            ),
          ),
        ),
        child: Material(
          shape: const StadiumBorder(),
          child: InkWell(
            onTap: widget.onPressed,
            customBorder: const StadiumBorder(),
            highlightColor: primaryColor.withAlpha(193),
            splashColor: primaryColor,
            onHighlightChanged: (value) {
              setState(() {
                textColor = value ? const Color(0xffffffff) : widget.textColor;
                borderColor =
                    value ? primaryColor.withAlpha(193) : widget.textColor;
              });
            },
            child: Padding(
              padding: widget.innerPadding,
              child: Text(
                widget.content,
                style: textTheme.titleSmall!.copyWith(
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
