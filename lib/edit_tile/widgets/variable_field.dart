import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/edit_tile/bloc/bloc.dart';
import 'package:flutter_firestore/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_api/iot_api.dart';

class VariableField extends StatelessWidget {
  const VariableField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final state = context.watch<EditTileBloc>().state;

    final status = state.status;
    final deviceID = state.deviceID;
    final hintDevice = state.deviceView[deviceID];
    final enabled =
        !status.isSaving && hintDevice != null && hintDevice.jsonEnable;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Space.contentPaddingHorizontal.value,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 16,
                  ),
                  child: SvgPicture.asset(
                    Assets.icons.code,
                    color: enabled
                        ? const Color(0xff676767)
                        : const Color(0xff989898),
                  ),
                ),
                Text(
                  'JSON variable',
                  style: textTheme.bodyMedium!.copyWith(
                    color: enabled
                        ? const Color(0xff676767)
                        : const Color(0xff989898),
                  ),
                ),
              ],
            ),
          ),
          if (hintDevice == null)
            Text(
              'Please choose monitored device...',
              style:
                  textTheme.bodySmall!.copyWith(color: const Color(0xff989898)),
            )
          else if (!hintDevice.jsonEnable)
            Text(
              'This device has no JSON variable setting',
              style:
                  textTheme.bodySmall!.copyWith(color: const Color(0xff989898)),
            )
          else
            SizedBox(
              height: hintDevice.jsonVariables.length * 48,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: hintDevice.jsonVariables.length,
                itemBuilder: (context, index) {
                  final jsonVariable = hintDevice.jsonVariables[index];
                  return VariableBox(
                    jsonVariable: jsonVariable,
                    textTheme: textTheme,
                    enabled: enabled,
                  );
                },
              ),
            )
        ],
      ),
    );
  }
}

class VariableBox extends StatelessWidget {
  const VariableBox({
    super.key,
    required this.jsonVariable,
    required this.textTheme,
    required this.enabled,
  });

  final JsonVariable jsonVariable;
  final TextTheme textTheme;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditTileBloc>().state;
    final tileData = state.tileData;
    final jsonVariableId = tileData.getFieldId();

    return MyElevatedButton(
      height: 48,
      bgColor: jsonVariableId == jsonVariable.id
          ? const Color(0xffe0e0e0)
          : const Color(0xffffffff),
      onPressed: () {
        if (enabled) {
          final newTileData = tileData.setFieldId(jsonVariable.id);
          context.read<EditTileBloc>().add(EditTileDataChanged(newTileData));
        }
      },
      child: Row(
        children: [
          Expanded(
            child: Text(
              jsonVariable.name,
              style: textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            jsonVariable.jsonExtraction,
            style: textTheme.bodyMedium!.copyWith(
              color:
                  enabled ? const Color(0xff676767) : const Color(0xff989898),
            ),
          ),
        ],
      ),
    );
  }
}
