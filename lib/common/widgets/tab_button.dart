
import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  const TabButton({
    super.key,
    required this.label,
    required this.tab,
    required this.selectedTab,
    required this.onTapped,
  });

  final String label;
  final dynamic tab;
  final dynamic selectedTab;
  final Function() onTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ),
        child: Container(
          alignment: Alignment.center,
          height: 48,
          decoration: tab == selectedTab
              ? const BoxDecoration(
                  color: Color(0xffF04243),
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                )
              : const BoxDecoration(
                  color: Color(0xffffffff),
                  // border: Border.all(
                  //   color: Theme.of(context).primaryColor.withAlpha(193),
                  //   width: 2,
                  // ),
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
            ),
            child: Text(
              label,
              style: tab == selectedTab
                  ? Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: const Color(0xffffffff))
                  : Theme.of(context).textTheme.headline5,
            ),
          ),
        ),
      ),
    );
  }
}
