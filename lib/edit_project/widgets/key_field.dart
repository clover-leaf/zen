import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_firestore/edit_project/bloc/bloc.dart';
import 'package:flutter_firestore/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KeyField extends StatelessWidget {
  const KeyField({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final state = context.watch<EditProjectBloc>().state;
    final key = state.key;
    final status = state.status;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Space.contentPaddingHorizontal.value,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: !status.isSaving
                  ? const Color(0xffe0e0e0)
                  : const Color(0xfff5f5f5),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: SvgPicture.asset(
                    Assets.icons.tag,
                    color: !status.isSaving
                        ? const Color(0xff676767)
                        : const Color(0xff989898),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (key == null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Text(
                          'Project key',
                          style: textTheme.bodyMedium!.copyWith(
                            color: const Color(0xff5a5a5a),
                          ),
                        ),
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Project key',
                            style: textTheme.labelSmall!.copyWith(
                              color: !status.isSaving
                                  ? const Color(0xff5a5a5a)
                                  : const Color(0xff989898),
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.2,
                            ),
                          ),
                          Text(
                            key,
                            style: textTheme.bodyMedium!.copyWith(
                              color: const Color(0xff212121),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: Space.globalBorderWidth.value,
            color: const Color(0xff828282),
          ),
        ],
      ),
    );
  }
}
