import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../context/shared/ui/cross_app.dart';
import '../context/shared/ui/cross_coming_soon.dart';
import '../context/shared/ui/cross_nav_bar_item.dart';
import '../context/shared/ui/cross_tab_scaffold.dart';
import 'info_page.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CrossApp(
      title: 'Flutter Cross App',
      home: CrossTabScaffold(
        pages: [
          CrossNavBarItem(label: 'Info', icon: PlatformIcons(context).info, screen: const InfoPage()),
          const CrossNavBarItem(label: 'Demo', icon: FontAwesomeIcons.eye, screen: CrossComingSoon(label: 'Demo screen')),
        ],
        settingsPage: CrossNavBarItem(label: 'Settings', icon: PlatformIcons(context).gearSolid, screen: const CrossComingSoon(label: 'Settings screen')),
      ),
    );
  }
}
