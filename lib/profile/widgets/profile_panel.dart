import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/constants/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePanel extends StatelessWidget {
  const ProfilePanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffe1dddc),
      height: 256,
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 96,
            width: 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color: const Color(0xffF04243),
              ),
              color: const Color(0xffe4cccc),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SvgPicture.asset(
                SvgIcon.profile.getPath(),
                color: const Color(0xffF04243),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Thang Nguyen',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          )
        ],
      ),
    );
  }
}
