import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_firestore/edit_tile/bloc/edit_tile_bloc.dart';
import 'package:flutter_firestore/edit_tile/widgets/sheet/sheet.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeviceField extends StatelessWidget {
  const DeviceField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final state = context.watch<EditTileBloc>().state;

    final hintDeviceID =
        state.isEditted ? state.deviceID : state.initTileConfig?.deviceID;
    final hintDevice = state.mqttDeviceView[hintDeviceID];
    final hintBroker = state.brokerView[hintDevice?.brokerID];
    final hintDeviceTitle = hintDevice?.title;
    final hintFullUrl =
        '${hintBroker?.url}:${hintBroker?.port}/${hintDevice?.topic}';

    final titleStyle = textTheme.bodyMedium!.copyWith(
      color: const Color(0xff212121),
      fontWeight: FontWeight.w600,
    );
    final subtitleStyle = textTheme.labelSmall!.copyWith(
      color: const Color(0xff5a5a5a),
      fontWeight: FontWeight.w600,
      letterSpacing: 0.2,
    );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (!state.status.isSaving) {
          showModalBottomSheet<void>(
            context: context,
            builder: (_) => DeviceListSheet(
              paddingTop: MediaQuery.of(context).viewPadding.top,
              brokerView: state.brokerView,
              mqttDeviceView: state.mqttDeviceView,
              onTapped: (mqttDeviceID) => context
                  .read<EditTileBloc>()
                  .add(EditTileDeviceIdChanged(mqttDeviceID)),
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
              decoration: const BoxDecoration(
                color: Color(0xffe0e0e0),
                borderRadius: BorderRadius.only(
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
                      MyIcon.cast.getPath(),
                      color: const Color(0xff676767),
                    ),
                  ),
                  if (hintDeviceID == null || hintDeviceID == '')
                    Text(
                      'choose device...',
                      style: textTheme.bodyMedium!.copyWith(
                        color: const Color(0xff5a5a5a),
                      ),
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            hintFullUrl,
                            style: subtitleStyle,
                          ),
                        ),
                        Text(
                          hintDeviceTitle ?? 'device title',
                          style: titleStyle,
                        ),
                      ],
                    )
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
