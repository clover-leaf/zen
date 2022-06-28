import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Space.searchbarHeight.value,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(Space.globalBorderRadius.value),
        ),
        color: const Color(0xFFF0F1F2),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: Space.searchbarContentPaddingLeft.value),
        child: Row(
          children: [
            SvgPicture.asset(
              SvgIcon.search.getPath(),
              height: 20,
              width: 20,
              color: const Color(0xFF4D4D4D),
            ),
            SizedBox(
              width: Space.searchbarContentPaddingLeft.value,
            ),
            SizedBox(
              width: Space.searchbarTextWidth.value,
              height: Space.searchbarHeight.value,
              child: TextField(
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF4D4D4D),
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
    );
  }
}
