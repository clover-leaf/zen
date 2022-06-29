import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/device_detail/device_detail.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iot_api/iot_api.dart';

class DeviceDetailPage extends StatelessWidget {
  const DeviceDetailPage({super.key, required this.device});

  static PageRoute route({required Device device}) {
    return MaterialPageRoute<void>(
      builder: (context) => DeviceDetailPage(
        device: device,
      ),
    );
  }

  final Device device;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DeviceDetailBloc(device: device),
      child: const DeviceDetailView(),
    );
  }
}

class DeviceDetailView extends StatelessWidget {
  const DeviceDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((DeviceDetailBloc bloc) => bloc.state.status);
    final device = context.select((DeviceDetailBloc bloc) => bloc.state.device);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffffffff),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          Space.contentPaddingLeft.value,
          Space.contentPaddingTop.value +
              MediaQuery.of(context).viewPadding.top,
          Space.contentPaddingRight.value,
          Space.contentPaddingBottom.value,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: const FaIcon(
                      FontAwesomeIcons.angleLeft,
                      color: Color(0xff183153),
                    ),
                  ),
                ),
                Text(
                  device.deviceName?.toString() ?? 'No name',
                  style: const TextStyle(
                    color: Color(0xff183153),
                    fontSize: 22,
                  ),
                ),
                const OptionButton()
              ],
            ),
            if (status == DeviceDetailStatus.initial)
              const CircularProgressIndicator()
            else
              Column()
          ],
        ),
      ),
    );
  }
}
