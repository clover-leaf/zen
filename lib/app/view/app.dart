// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/app/app.dart';
import 'package:flutter_firestore/home/view/home_page.dart';
import 'package:iot_repository/iot_repository.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.iotRepository,
  });

  final IotRepository iotRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: iotRepository,
      child: BlocProvider(
        create: (context) => ThemeCubit(),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.select((ThemeCubit cubit) => cubit.state.isDark);
    if (isDark) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light, // dark text for status bar
          statusBarColor: Colors.transparent,
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark, // dark text for status bar
          statusBarColor: Colors.transparent,
        ),
      );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDark ? AppTheme.dark : AppTheme.light,
      home: const HomePage(),
    );
  }
}
