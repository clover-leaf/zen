import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(24),
          ),
          border: Border.all(
            color: const Color(0xffee345f),
            width: 1.6,
          ),
          color: const Color(0xffffffff),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            children: [
              const FaIcon(
                FontAwesomeIcons.magnifyingGlass,
                size: 16,
                color: Color(0xff7a7a7a),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: Space.searchbarTextWidth.value,
                height: Space.searchbarHeight.value,
                child: TextField(
                  autocorrect: false,
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: Color(0xff7a7a7a),
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF242424),
                  ),
                  onSubmitted: (_) {},
                  textInputAction: TextInputAction.search,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
