import 'package:flutter/material.dart';
import 'package:flutter_firestore/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyEmptyPage extends StatelessWidget {
  const MyEmptyPage({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 128),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SvgPicture.asset(Assets.icons.empty),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              message,
              style: textTheme.titleMedium!.copyWith(
                color: const Color(0xff5a5a5a),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
