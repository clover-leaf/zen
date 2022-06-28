import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/device_overview/device_overview.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final filter = 
      context.select((DeviceOverviewBloc bloc) => bloc.state.filter);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // onTap: () => showDialog<ExamOverviewFilter>(
      //   context: context,
      //   builder: (context) => FilterDialog(
      //     filter: filter,
      //   ),
      // ).then((editFilter) {
      //   if (editFilter != null && editFilter != filter) {
      //     context
      //         .read<ExamOverviewBloc>()
      //         .add(ExamOverviewFilterChanged(editFilter));
      //   }
      // }),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            fit: StackFit.passthrough,
            children: [
              Container(
                alignment: Alignment.center,
                height: Space.iconBoxHeight.value,
                width: Space.iconBoxWidth.value,
                child: SvgPicture.asset(
                  SvgIcon.filter.getPath(),
                  height: 24,
                  width: 24,
                  color: const Color(0xFF626364),
                ),
              ),
              if (filter.statusFilter != DeviceOverviewStatusFilter.all)
                Positioned(
                  top: 3,
                  right: 3,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: const Color(0xFFFF8566),
                    ),
                  ),
                ),
            ],
          ),
          const Text(
            'Filter',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF242424),
            ),
          ),
        ],
      ),
    );
  }
}
