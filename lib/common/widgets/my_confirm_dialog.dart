import 'package:flutter/material.dart';

class MyConfirmDialog extends StatelessWidget {
  const MyConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 8,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: SizedBox(
        width: 384,
        child: AspectRatio(
          aspectRatio: 3.4,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              24,
              16,
              16,
              12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Discard changes?',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: const Color(0xff212121),
                  ),
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ConfirmButton(
                      text: 'Cancel',
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    const SizedBox(width: 12),
                    ConfirmButton(
                      text: 'Discard',
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({super.key, required this.text, this.onPressed});
  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      highlightColor: const Color(0xfff9e5e6),
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: const Color(0xff890e4f),
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
