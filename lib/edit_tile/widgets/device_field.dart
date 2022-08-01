import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_firestore/edit_tile/bloc/edit_tile_bloc.dart';
import 'package:flutter_firestore/edit_tile/widgets/widgets.dart';
import 'package:flutter_firestore/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_api/iot_api.dart';

class DeviceField extends StatelessWidget {
  const DeviceField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTileBloc>().state;
    final status = state.status;
    final deviceView = state.deviceView;
    final project = state.project;

    final deviceID = state.deviceID;
    final hintDevice = state.deviceView[deviceID];

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (!status.isSaving) {
          showModalBottomSheet<void>(
            context: context,
            builder: (_) => DeviceListSheet(
              project: project,
              paddingTop: MediaQuery.of(context).viewPadding.top,
              deviceView: deviceView,
              onTapped: (deviceID) => context
                  .read<EditTileBloc>()
                  .add(EditTileDeviceIdChanged(deviceID)),
            ),
            isScrollControlled: true,
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Space.contentPaddingHorizontal.value,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
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
                      Assets.icons.cast,
                      color: !status.isSaving
                          ? const Color(0xff676767)
                          : const Color(0xff989898),
                    ),
                  ),
                  DeviceDetailText(
                    project: project,
                    hintDevice: hintDevice,
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
      ),
    );
  }
}

class DeviceDetailText extends StatelessWidget {
  const DeviceDetailText({
    super.key,
    required this.project,
    required this.hintDevice,
  });

  final Project project;
  final Device? hintDevice;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTileBloc>().state;
    final textTheme = Theme.of(context).textTheme;
    final status = state.status;

    if (hintDevice == null) {
      return Text(
        'choose device...',
        style: textTheme.bodyMedium!.copyWith(
          color: const Color(0xff5a5a5a),
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              '${project.key}.${hintDevice!.key}',
              style: textTheme.labelSmall!.copyWith(
                color: !status.isSaving
                    ? const Color(0xff5a5a5a)
                    : const Color(0xff989898),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ),
          Text(
            hintDevice!.name,
            style: textTheme.bodyMedium!.copyWith(
              color: const Color(0xff212121),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    }
  }
}
