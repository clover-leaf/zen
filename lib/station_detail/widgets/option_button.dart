import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OptionButton extends StatelessWidget {
  const OptionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 40,
      child: PopupMenuButton<Widget>(
        padding: EdgeInsets.zero,
        elevation: 2,
        icon: const FaIcon(
          FontAwesomeIcons.ellipsis,
          color: Color(0xff183153),
          size: 24,
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            child: const Text(
              'Edit',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff183153),
              ),
            ),
            onTap: () => Navigator.pop(context),
          ),
          PopupMenuItem(
            child: const Text(
              'Pin',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff183153),
              ),
            ),
            onTap: () => Navigator.pop(context),
          ),
          PopupMenuItem(
            child: const Text(
              'Delete',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff183153),
              ),
            ),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
