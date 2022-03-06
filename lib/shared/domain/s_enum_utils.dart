import 's_enums.dart';

class SEnumUtils {
  static final SEnumUtils instance = SEnumUtils._privateConstructor();

  SEnumUtils._privateConstructor() {}

  static final Map<SPlatform, String> _translationsPlatform = Map.unmodifiable(
    {
      SPlatform.android: 'Android',
      SPlatform.ios: 'iOS',
      SPlatform.mac: 'macOS',
      SPlatform.windows: 'Windows',
      SPlatform.linux: 'Linux',
      SPlatform.web: 'Web',
    },
  );

  String translatePlatform(SPlatform? platform) => platform != null ? _translationsPlatform[platform] ?? '' : '';
}
