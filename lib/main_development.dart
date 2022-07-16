// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.
import 'package:flutter_firestore/app/app.dart';
import 'package:flutter_firestore/bootstrap.dart';
import 'package:http/http.dart' as http;
import 'package:iot_repository/iot_repository.dart';
import 'package:remote_storage_iot_api/remote_storage_iot_api.dart';

void main() {
  final iotApi = RemoteStorageIotApi(
    httpClient: http.Client(),
    schema: 'iz',
  );
  final iotRepository = IotRepository(api: iotApi);
  bootstrap(
    () => App(iotRepository: iotRepository),
  );
}
