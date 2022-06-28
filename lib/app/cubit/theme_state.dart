part of 'theme_cubit.dart';

enum ThemeStatus { initial, success }

class ThemeState extends Equatable {
  const ThemeState({
    this.status = ThemeStatus.initial,
    this.isDark = false,
  });

  final ThemeStatus status;
  final bool isDark;

  @override
  List<Object> get props => [status, isDark];
}
