import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/edit_device/bloc/bloc.dart';
import 'package:flutter_firestore/edit_device/widgets/widgets.dart';
import 'package:flutter_firestore/gen/assets.gen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_api/iot_api.dart';

class JsonVariableField extends StatelessWidget {
  const JsonVariableField({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditDeviceBloc>().state;
    final jsonEnable = state.jsonEnable;
    final jsonVariables = state.jsonVariables;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: Space.contentPaddingHorizontal.value,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'JSON variables',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: jsonEnable
                            ? const Color(0xff5a5a5a)
                            : const Color(0xff989898),
                      ),
                ),
              ),
              Switch(
                value: jsonEnable,
                activeColor: const Color(0xfff17d18),
                activeTrackColor: const Color(0xfffab981),
                onChanged: (newEnable) {
                  context
                      .read<EditDeviceBloc>()
                      .add(EditDeviceJsonEnableChanged(jsonEnable: newEnable));
                },
              )
            ],
          ),
          Text(
            'Payload is in JSON format',
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  height: 0.7,
                  letterSpacing: 0,
                  color: jsonEnable
                      ? const Color(0xff5a5a5a)
                      : const Color(0xff989898),
                ),
          ),
          SizedBox(height: Space.contentItemGap.value),
          SizedBox(
            height: jsonVariables.length * 48,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: jsonVariables.length,
              itemBuilder: (context, index) {
                final jsonVariable = jsonVariables[index];
                return _VariableBox(
                  jsonVariable: jsonVariable,
                  enabled: jsonEnable,
                );
              },
            ),
          ),
          SizedBox(height: Space.contentItemGap.value),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () => showModalBottomSheet<void>(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: const Color(0xffffffff),
                context: context,
                builder: (_) => JsonExtractionSheet(
                  initJsonVariable: null,
                  onSaved: (jsonVariable) => context.read<EditDeviceBloc>().add(
                        EditDeviceJsonVariableSaved(jsonVariable: jsonVariable),
                      ),
                  onDeleted: (jsonVariable) =>
                      context.read<EditDeviceBloc>().add(
                            EditDeviceJsonVariableDeleted(
                              jsonVariable: jsonVariable,
                            ),
                          ),
                ),
              ),
              child: Container(
                height: 48,
                width: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: jsonEnable
                      ? const Color(0xfffab981)
                      : const Color(0xff989898),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  Assets.icons.add,
                  color: const Color(0xffffffff),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VariableBox extends StatelessWidget {
  const _VariableBox({
    required this.jsonVariable,
    required this.enabled,
  });

  final JsonVariable jsonVariable;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MyElevatedButton(
      height: 48,
      onPressed: () {
        if (enabled) {
          showModalBottomSheet<void>(
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: const Color(0xffffffff),
            context: context,
            builder: (_) => JsonExtractionSheet(
              initJsonVariable: jsonVariable,
              onSaved: (jsonVariable) => context.read<EditDeviceBloc>().add(
                    EditDeviceJsonVariableSaved(jsonVariable: jsonVariable),
                  ),
              onDeleted: (jsonVariable) => context.read<EditDeviceBloc>().add(
                    EditDeviceJsonVariableDeleted(jsonVariable: jsonVariable),
                  ),
            ),
          );
        }
      },
      child: Row(
        children: [
          Expanded(
            child: Text(
              jsonVariable.name,
              style: textTheme.bodyMedium!.copyWith(
                color:
                    enabled ? const Color(0xff212121) : const Color(0xff676767),
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
