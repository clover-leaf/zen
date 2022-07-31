
// import 'package:flutter_firestore/tiles_overview/bloc/tiles_overview_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:iot_repository/iot_repository.dart';
// import 'package:mocktail/mocktail.dart';

// class MockIotRepository extends Mock implements IotRepository {}

// void main() {
//   late MockIotRepository mockRepository;
//   group('TilesOverviewBloc', () {
//     setUp(() {
//       mockRepository = MockIotRepository();
//     });
//     TilesOverviewBloc buildBloc() {
//       return TilesOverviewBloc(repository: mockRepository);
//     }
//     group('constructor', () {
//       test('working properly', () {
//         expect(buildBloc, returnsNormally);
//       });
//       test('has the correct initial state', () {
//         expect(buildBloc().state, TilesOverviewState());
//       });
//     });
//   });
// }
