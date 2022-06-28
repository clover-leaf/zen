part of 'home_cubit.dart';

enum HomeTab { overview, dashboard, notice, task, configure }

extension HomeTabX on HomeTab {
  String getName() {
    switch (this) {
      case HomeTab.overview:
        return 'Home';
      case HomeTab.dashboard:
        return 'Dashboard';
      case HomeTab.notice:
        return 'Notices';
      case HomeTab.task:
        return 'Tasks';
      case HomeTab.configure:
        return 'Setting';
    }
  }
}

class HomeState extends Equatable {
  const HomeState({
    this.tab = HomeTab.overview,
  });

  final HomeTab tab;

  @override
  List<Object> get props => [tab];
}
