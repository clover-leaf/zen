import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState());

  void toggle() {
    emit(
      ThemeState(
        status: ThemeStatus.success,
        isDark: !state.isDark,
      ),
    );
  }
}
