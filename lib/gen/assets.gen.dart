/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/add.svg
  String get add => 'assets/icons/add.svg';

  /// File path: assets/icons/cast.svg
  String get cast => 'assets/icons/cast.svg';

  /// File path: assets/icons/chat.svg
  String get chat => 'assets/icons/chat.svg';

  /// File path: assets/icons/code.svg
  String get code => 'assets/icons/code.svg';

  /// File path: assets/icons/download.svg
  String get download => 'assets/icons/download.svg';

  /// File path: assets/icons/empty.svg
  String get empty => 'assets/icons/empty.svg';

  /// File path: assets/icons/faq.svg
  String get faq => 'assets/icons/faq.svg';

  /// File path: assets/icons/humidity.svg
  String get humidity => 'assets/icons/humidity.svg';

  /// File path: assets/icons/justify.svg
  String get justify => 'assets/icons/justify.svg';

  /// File path: assets/icons/left-button.svg
  String get leftButton => 'assets/icons/left-button.svg';

  /// File path: assets/icons/lightbulb.svg
  String get lightbulb => 'assets/icons/lightbulb.svg';

  /// File path: assets/icons/more-v.svg
  String get moreV => 'assets/icons/more-v.svg';

  /// File path: assets/icons/night.svg
  String get night => 'assets/icons/night.svg';

  /// File path: assets/icons/pencil.svg
  String get pencil => 'assets/icons/pencil.svg';

  /// File path: assets/icons/processor.svg
  String get processor => 'assets/icons/processor.svg';

  /// File path: assets/icons/qos.svg
  String get qos => 'assets/icons/qos.svg';

  /// File path: assets/icons/right-md.svg
  String get rightMd => 'assets/icons/right-md.svg';

  /// File path: assets/icons/save.svg
  String get save => 'assets/icons/save.svg';

  /// File path: assets/icons/settings.svg
  String get settings => 'assets/icons/settings.svg';

  /// File path: assets/icons/so-toggle.svg
  String get soToggle => 'assets/icons/so-toggle.svg';

  /// File path: assets/icons/tag.svg
  String get tag => 'assets/icons/tag.svg';

  /// File path: assets/icons/temp.svg
  String get temp => 'assets/icons/temp.svg';

  /// File path: assets/icons/template.svg
  String get template => 'assets/icons/template.svg';

  /// File path: assets/icons/text-fill.svg
  String get textFill => 'assets/icons/text-fill.svg';

  /// File path: assets/icons/text-size.svg
  String get textSize => 'assets/icons/text-size.svg';

  /// File path: assets/icons/toggle.svg
  String get toggle => 'assets/icons/toggle.svg';

  /// File path: assets/icons/trash.svg
  String get trash => 'assets/icons/trash.svg';
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/supabase.png
  AssetGenImage get supabase =>
      const AssetGenImage('assets/images/supabase.png');

  /// File path: assets/images/vgv.png
  AssetGenImage get vgv => const AssetGenImage('assets/images/vgv.png');
}

class Assets {
  Assets._();

  static const String env = 'assets/.env';
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
