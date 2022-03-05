import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:window_manager/window_manager.dart';

import '../domain/s_enums.dart';
import '../service/s_device_service.dart';
import 'cross_nav_bar_item.dart';

class CrossTabScaffold extends StatefulWidget {
  final List<CrossNavBarItem> items;

  const CrossTabScaffold({Key? key, required this.items})
      : assert(items.length > 0),
        super(key: key);

  @override
  State<CrossTabScaffold> createState() => _CrossTabScaffoldState();
}

class _CrossTabScaffoldState extends State<CrossTabScaffold> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return _buildWidget(context);
  }

  Widget _buildWidget(BuildContext context) {
    final platform = SDeviceService.instance.currentPlatform;
    Widget feedback;

    switch (platform) {
      case SPlatform.android:
      case SPlatform.ios:
        var navBar = PlatformNavBar(
          currentIndex: _selectedIndex,
          itemChanged: (index) => _updateIndex(index),
          items: widget.items.map((anItem) => BottomNavigationBarItem(icon: Icon(anItem.icon), label: anItem.label)).toList(),
        );
        feedback = PlatformScaffold(
          appBar: PlatformAppBar(
            title: Text(
              _calculateScreenTitle(),
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline5?.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: _calculateScreenWidget(),
          bottomNavBar: navBar,
          iosContentPadding: false,
          iosContentBottomPadding: false,
        );
        break;

      case SPlatform.mac:
        feedback = MacosWindow(
          sidebar: Sidebar(
            builder: (BuildContext context, ScrollController scrollController) => SidebarItems(
              currentIndex: _selectedIndex,
              onChanged: (index) => _updateIndex(index),
              items: widget.items
                  .map(
                    (anItem) => SidebarItem(
                      leading: MacosIcon(anItem.icon),
                      label: Text(anItem.label),
                    ),
                  )
                  .toList(),
            ),
            minWidth: 200,
          ),
          child: MacosScaffold(
            children: [
              ContentArea(
                builder: (BuildContext context, ScrollController scrollController) => _calculateScreenWidget(),
              )
            ],
            titleBar: TitleBar(
              title: Text(
                _calculateScreenTitle(),
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline5?.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
        break;

      case SPlatform.windows:
        feedback = NavigationView(
          appBar: NavigationAppBar(
            title: () {
              if (kIsWeb) return Text(_calculateScreenTitle());
              return DragToMoveArea(
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(_calculateScreenTitle()),
                ),
              );
            }(),
          ),
          pane: NavigationPane(
            selected: _selectedIndex,
            onChanged: (index) => _updateIndex(index),
            size: const NavigationPaneSize(
              openMinWidth: 200,
              openMaxWidth: 250,
            ),
            items: widget.items
                .map(
                  (anItem) => PaneItem(
                    icon: Icon(anItem.icon),
                    title: Text(anItem.label),
                  ),
                )
                .toList(),
          ),
          content: NavigationBody(
            index: _selectedIndex,
            children: widget.items.map((anItem) => anItem.screen).toList(),
          ),
        );
        break;

      case SPlatform.linux:
      case SPlatform.web:
        feedback = Scaffold(
          appBar: AppBar(
            title: Text(
              _calculateScreenTitle(),
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline5?.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: _calculateScreenWidget(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) => _updateIndex(index),
            items: widget.items
                .map(
                  (anItem) => BottomNavigationBarItem(
                    icon: Icon(anItem.icon),
                    label: anItem.label,
                  ),
                )
                .toList(),
          ),
        );
        break;
    }

    return feedback;
  }

  _updateIndex(int index) => setState(() => _selectedIndex = index);

  Widget _calculateScreenWidget() => widget.items[_selectedIndex].screen;

  String _calculateScreenTitle() => widget.items[_selectedIndex].label;
}
