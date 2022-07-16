# Flutter Firestore

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

Generated by the [Very Good CLI][very_good_cli_link] 🤖

An example firestore app.

---

## Todo

- [29] create home page | 1h30 - 70% | thêm pin destination and so on
- [29] create device list page | 2h - 90% | test với api sau khi tạo data mẫu chuẩn chỉ
- [29] create device page | 2h - 20%| tạo ui nhìn đc đc là đủ
- [29][30] create dashboard page | 2h - 90%|

- [30] create add/edit device page | 2h - 0%|
- [30] create login page | 1h - 0%|
- [30] create station list page | 1h30
- [30] create station page | 1h
- [30] create add/edit station page | 1h

- [ ] tạo data mẫu



## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*Flutter Firestore works on iOS, Android, Web, and Windows._

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```
