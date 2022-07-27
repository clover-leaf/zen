enum MyIcon {
  add,
  code,
  leftButton,
  pencil,
  qos,
  save,
  tag,
  template,
  textFill,
  textSize,
  download,
  humidity,
  night,
  temp,
  moreV,
  justify,
  setting,
  toggle,
  faq,
  chat,
  lightbulb,
  cast,
  trash,
  rightButton,
}

extension MyIconX on MyIcon {
  String getPath() {
    String toPath(String name) => 'assets/icon/$name.svg';
    switch (this) {
      case MyIcon.add:
        return toPath('add');
      case MyIcon.code:
        return toPath('code');
      case MyIcon.leftButton:
        return toPath('left-button');
      case MyIcon.pencil:
        return toPath('pencil');
      case MyIcon.qos:
        return toPath('qos');
      case MyIcon.save:
        return toPath('save');
      case MyIcon.tag:
        return toPath('tag');
      case MyIcon.template:
        return toPath('template');
      case MyIcon.textFill:
        return toPath('text-fill');
      case MyIcon.textSize:
        return toPath('text-size');
      case MyIcon.download:
        return toPath('download');
      case MyIcon.night:
        return toPath('night');
      case MyIcon.temp:
        return toPath('temp');
      case MyIcon.humidity:
        return toPath('humidity');
      case MyIcon.justify:
        return toPath('justify');
      case MyIcon.moreV:
        return toPath('more-v');
      case MyIcon.setting:
        return toPath('settings');
      case MyIcon.toggle:
        return toPath('toggle');
      case MyIcon.faq:
        return toPath('faq');
      case MyIcon.chat:
        return toPath('chat');
      case MyIcon.lightbulb:
        return toPath('lightbulb');
      case MyIcon.cast:
        return toPath('cast');
      case MyIcon.trash:
        return toPath('trash');
      case MyIcon.rightButton:
        return toPath('right-md');
    }
  }
}
