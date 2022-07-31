import 'package:flutter/material.dart';
import 'package:flutter_firestore/app/app.dart';
import 'package:flutter_firestore/login/login.dart';
import 'package:flutter_firestore/tiles_overview/tiles_overview.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.unauthenticated:
      return [LoginPage.page()];

    case AppStatus.authenticated:
      return [TilesOverviewPage.page()];
  }
}
