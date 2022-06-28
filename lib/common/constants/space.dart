enum Space {
  /// global constants
  globalBorderRadius(6),

  /// constants of content's padding
  ///
  /// actual padding top will be added status bar height
  contentPaddingLeft(24),
  contentPaddingTop(16),
  contentPaddingRight(16),
  contentPaddingBottom(16),

  /// constants of gap between item in content
  contentItemGap(16),

  /// constants of search bar
  searchbarHeight(40),
  searchbarTextWidth(240),
  searchbarContentPaddingLeft(12),
  searchbarContentPaddingRight(12),

  /// constants of filter dialog
  filterDialogHeight(560),
  filterDialogWidth(300),
  filterDialogPadding(16),

  /// constants of sort box
  sortBoxWidth(180),
  sortBoxHeight(60),

  /// constants of sort dialog box
  sortDialogBoxHeight(40),

  /// constants of exam bar
  examBarHeight(120),
  examBarPadding(16),
  examItemSmallGap(4),
  examItemBigGap(8),

  /// constants of exam detail
  examDetailBigGap(8),

  /// constants of icon box's size
  iconBoxHeight(40),
  iconBoxWidth(40);

  const Space(this.value);
  final double value;
}
