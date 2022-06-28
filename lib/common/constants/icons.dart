enum SvgIcon {
  profile,
  overview,
  dashboard,
  notification,
  configure,
  search,
  filter,
  clock,
  star,
  eye,
  rowMode,
  gridMode,
  flag,
  add,
  downArrow,
  backArrow,
  message,
  ranking,
  close,
  radar,
  project,
  station,
  device,
  report,
  task,
}

extension SvgIconX on SvgIcon {
  String getPath() {
    String toPath(String name) => 'assets/icons/$name.svg';
    switch (this) {
      case SvgIcon.profile:
        return toPath('profile');
      case SvgIcon.overview:
        return toPath('home');
      case SvgIcon.dashboard:
        return toPath('category');
      case SvgIcon.notification:
        return toPath('notification');
      case SvgIcon.configure:
        return toPath('setting');
      case SvgIcon.search:
        return toPath('search');
      case SvgIcon.filter:
        return toPath('filter');
      case SvgIcon.clock:
        return toPath('clock');
      case SvgIcon.star:
        return toPath('star');
      case SvgIcon.eye:
        return toPath('eye');
      case SvgIcon.rowMode:
        return toPath('row-mode');
      case SvgIcon.gridMode:
        return toPath('grid-mode');
      case SvgIcon.flag:
        return toPath('flag');
      case SvgIcon.add:
        return toPath('add');
      case SvgIcon.downArrow:
        return toPath('down-arrow');
      case SvgIcon.backArrow:
        return toPath('back-arrow');
      case SvgIcon.message:
        return toPath('message');
      case SvgIcon.ranking:
        return toPath('ranking');
      case SvgIcon.close:
        return toPath('close-square');
      case SvgIcon.radar:
        return toPath('radar');
      case SvgIcon.project:
        return toPath('folder');
      case SvgIcon.station:
        return toPath('building');
      case SvgIcon.device:
        return toPath('cpu');
      case SvgIcon.report:
        return toPath('note');
      case SvgIcon.task:
        return toPath('task-square');
    }
  }
}
