import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({
    super.key,
    required this.initText,
    required this.labelText,
    required this.prefixIcon,
    required this.horizontalPadding,
    this.enabled = true,
    required this.onChanged,
  });

  final String labelText;
  final String? initText;
  final String prefixIcon;
  final bool enabled;
  final double horizontalPadding;
  final Function(String) onChanged;

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late TextEditingController _controller;
  late bool hasFocus;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    if (widget.initText != null) {
      _controller.text = widget.initText!;
    }
    hasFocus = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.horizontalPadding,
      ),
      child: Focus(
        onFocusChange: (focus) => setState(() {
          hasFocus = focus;
        }),
        child: TextField(
          controller: _controller,
          onChanged: widget.onChanged,
          cursorColor: const Color(0xff890e4f),
          style: textTheme.bodyMedium!.copyWith(
            color: const Color(0xff212121),
            fontWeight: FontWeight.w600,
          ),
          enabled: widget.enabled,
          // prefix icon
          decoration: InputDecoration(
            prefixIconConstraints: const BoxConstraints(
              minWidth: 64,
            ),
            prefixIcon: FittedBox(
              fit: BoxFit.scaleDown,
              child: SvgPicture.asset(
                widget.prefixIcon,
                height: 24,
                width: 24,
                color: widget.enabled
                    ? const Color(0xff676767)
                    : const Color(0xff989898),
              ),
            ),
            // background
            filled: true,
            fillColor: widget.enabled
                ? const Color(0xffe0e0e0)
                : const Color(0xfff5f5f5),
            // label
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: widget.labelText,
            labelStyle: textTheme.bodyMedium!.copyWith(
              color: hasFocus
                  ? const Color(0xff890e4f)
                  : widget.enabled
                      ? const Color(0xff5a5a5a)
                      : const Color(0xff989898),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xff890e4f),
                width: Space.globalBorderWidth.value,
              ),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xff9f9f9f),
                width: Space.globalBorderWidth.value,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xff828282),
                width: Space.globalBorderWidth.value,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
