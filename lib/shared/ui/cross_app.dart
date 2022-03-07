import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:macos_ui/macos_ui.dart';

import '../../../shared/domain/s_enums.dart';
import '../domain/s_device_event.dart';
import '../service/s_device.dart';

class CrossApp extends StatefulWidget {
  final String title;
  final Widget home;

  const CrossApp({Key? key, required this.title, required this.home})
      : assert(title.length > 0),
        super(key: key);

  @override
  State<CrossApp> createState() => _CrossAppState();
}

class _CrossAppState extends State<CrossApp> {
  late final Stream<SDeviceEvent> _deviceEvents;

  @override
  void initState() {
    super.initState();
    _deviceEvents = SDevice.instance.deviceEvents;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SDeviceEvent>(
      stream: _deviceEvents,
      builder: (_, __) => _buildWidget(context),
    );
  }

  Widget _buildWidget(BuildContext context) {
    final platform = SDevice.instance.currentPlatform;
    Widget feedback;

    switch (platform) {
      case SPlatform.android:
      case SPlatform.ios:
        feedback = _buildMobileWidget();
        break;

      case SPlatform.windows:
        feedback = _buildWindowsWidget();
        break;

      case SPlatform.mac:
        feedback = _buildMacWidget();
        break;

      case SPlatform.linux:
      case SPlatform.web:
        feedback = _buildWebApp();
        break;
    }

    return feedback;
  }

  Widget _buildWebApp() => MaterialApp(
        title: widget.title,
        home: widget.home,
        debugShowCheckedModeBanner: false,
      );

  Widget _buildMacWidget() => MacosApp(
        title: widget.title,
        home: widget.home,
        debugShowCheckedModeBanner: false,
      );

  Widget _buildWindowsWidget() => FluentApp(
        title: widget.title,
        home: widget.home,
        debugShowCheckedModeBanner: false,
      );

  Widget _buildMobileWidget() {
    final currentPlatform = SDevice.instance.currentPlatform;
    return PlatformProvider(
      settings: PlatformSettingsData(
        platformStyle: PlatformStyleData(
          ios: currentPlatform == SPlatform.ios ? PlatformStyle.Cupertino : PlatformStyle.Material,
          android: currentPlatform == SPlatform.android ? PlatformStyle.Material : PlatformStyle.Cupertino,
        ),
      ),
      builder: (_) => currentPlatform == SPlatform.android
          ? MaterialApp(
              title: widget.title,
              home: widget.home,
              debugShowCheckedModeBanner: false,
            )
          : PlatformApp(
              title: widget.title,
              home: widget.home,
              debugShowCheckedModeBanner: false,
            ),
    );
  }
}
