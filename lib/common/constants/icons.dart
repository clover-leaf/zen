enum SvgIcon {
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
  backArrow,
  ranking,
  radar,
  project,
  station,
  report,
  air,
  gasStation,
  water,
  lighting,
  enviroment,
  message,
  add,
  close,
  profile,
  menu,
  home,
  logout,
  night,
  device,
  leftArrow,
  downArrow,
  rightArrow,
  more,
  people,
  support,
  edit,
  key,
  archive,
  pin,
  task,
}

extension SvgIconX on SvgIcon {
  String getPath() {
    String toPath(String name) => 'assets/icons/$name.svg';
    switch (this) {
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
      case SvgIcon.backArrow:
        return toPath('back-arrow');
      case SvgIcon.ranking:
        return toPath('ranking');
      case SvgIcon.radar:
        return toPath('radar');
      case SvgIcon.project:
        return toPath('folder');
      case SvgIcon.station:
        return toPath('building');
      case SvgIcon.report:
        return toPath('note');
      case SvgIcon.air:
        return toPath('airflow');
      case SvgIcon.gasStation:
        return toPath('gas-station');
      case SvgIcon.lighting:
        return toPath('lighting');
      case SvgIcon.water:
        return toPath('water');
      case SvgIcon.enviroment:
        return toPath('enviroment');
      case SvgIcon.menu:
        return toPath('menu');
      case SvgIcon.message:
        return toPath('message');
      case SvgIcon.add:
        return toPath('add');
      case SvgIcon.close:
        return toPath('close');
      case SvgIcon.profile:
        return toPath('profile');
      case SvgIcon.home:
        return toPath('home');
      case SvgIcon.logout:
        return toPath('logout');
      case SvgIcon.night:
        return toPath('night');
      case SvgIcon.device:
        return toPath('device');
      case SvgIcon.leftArrow:
        return toPath('arrow left');
      case SvgIcon.rightArrow:
        return toPath('arrow right');
      case SvgIcon.more:
        return toPath('more');
      case SvgIcon.downArrow:
        return toPath('arrow down');
      case SvgIcon.people:
        return toPath('people');
      case SvgIcon.support:
        return toPath('support');
      case SvgIcon.edit:
        return toPath('edit');
      case SvgIcon.key:
        return toPath('key');
      case SvgIcon.archive:
        return toPath('archive');
      case SvgIcon.pin:
        return toPath('pin');
      case SvgIcon.task:
        return toPath('task');
    }
  }
}
