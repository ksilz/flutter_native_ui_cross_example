import 'package:fluent_ui/fluent_ui.dart' hide Colors;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:macos_ui/macos_ui.dart';

import '../domain/s_enums.dart';
import '../service/s_device.dart';
import '../service/s_display.dart';
import 'cross_button.dart';
import 'cross_nav_bar_item.dart';

class CrossTabScaffold extends StatefulWidget {
  final List<CrossNavBarItem> pages;
  final CrossNavBarItem settingsPage;

  const CrossTabScaffold({Key? key, required this.pages, required this.settingsPage})
      : assert(pages.length > 0),
        super(key: key);

  @override
  State<CrossTabScaffold> createState() => _CrossTabScaffoldState();
}

class _CrossTabScaffoldState extends State<CrossTabScaffold> {
  late final List<CrossNavBarItem> _allPages;
  var _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _allPages = [...widget.pages, widget.settingsPage];
  }

  @override
  Widget build(BuildContext context) {
    final platform = SDevice.instance.currentPlatform;
    Widget feedback;

    switch (platform) {
      case SPlatform.android:
      case SPlatform.ios:
        feedback = _buildMobileWidget(platform);
        break;

      case SPlatform.mac:
        feedback = _buildMacOsWidget(context);
        break;

      case SPlatform.windows:
        feedback = _buildWindowsWidget();
        break;

      case SPlatform.linux:
      case SPlatform.web:
        feedback = _buildWebWidget(context);
        break;
    }

    return feedback;
  }

  Scaffold _buildWebWidget(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: SDisplay.instance.primaryColor,
          title: Text(
            _calculateScreenTitle(),
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline5?.fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: _calculateLeadingAction() == SLeadingAction.cancel || _calculateTrailingAction() == STrailingAction.save
            ? Column(
                children: [
                  _calculateScreenWidget(),
                  Padding(
                    padding: const EdgeInsets.only(top: 32, right: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (_calculateLeadingAction() == SLeadingAction.cancel)
                          Padding(
                            padding: EdgeInsets.only(right: _calculateTrailingAction() == STrailingAction.save ? 16 : 0),
                            child: CrossButton(
                              onAction: _onCancel,
                              type: SButtonType.cancel,
                              label: 'Cancel',
                            ),
                          ),
                        if (_calculateTrailingAction() == STrailingAction.save)
                          CrossButton(
                            onAction: _onSave,
                            label: 'Save',
                          )
                      ],
                    ),
                  )
                ],
              )
            : _calculateScreenWidget(),
        drawer: Container(
          color: Colors.white,
          width: 250,
          child: Stack(
            children: [
              Column(
                children: [
                  for (int index = 0; index < _allPages.length; index++)
                    GestureDetector(
                      onTap: () => _updateIndex(index),
                      child: Container(
                        color: index == _selectedIndex ? SDisplay.instance.primaryColor : null,
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const SizedBox(width: 16),
                            Icon(_allPages[index].icon),
                            const SizedBox(width: 12),
                            Text(
                              _allPages[index].label,
                              style: TextStyle(
                                fontSize: Theme.of(context).textTheme.headline6?.fontSize,
                                fontWeight: FontWeight.bold,
                                color: index == _selectedIndex ? Colors.white : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      );

  Widget _buildWindowsWidget() => NavigationView(
        appBar: NavigationAppBar(
          backgroundColor: SDisplay.instance.primaryColor,
          title: Text(
            _calculateScreenTitle(),
          ),
        ),
        pane: NavigationPane(
          selected: _selectedIndex,
          onChanged: (index) => _updateIndex(index),
          size: const NavigationPaneSize(
            openMinWidth: 200,
            openMaxWidth: 250,
          ),
          items: _allPages
              .map<NavigationPaneItem>(
                (anItem) => PaneItem(
                  icon: Icon(anItem.icon),
                  title: Text(anItem.label),
                ),
              )
              .toList(),
        ),
        content: NavigationBody(
          index: _selectedIndex,
          children: _allPages.map((anItem) => anItem.screen).toList(),
        ),
      );

  Widget _buildMacOsWidget(BuildContext context) => MacosWindow(
        sidebar: Sidebar(
          builder: (BuildContext context, ScrollController scrollController) => SidebarItems(
            currentIndex: _selectedIndex,
            onChanged: (index) => _updateIndex(index),
            items: _allPages
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
              builder: (_, __) => _calculateLeadingAction() == SLeadingAction.cancel || _calculateTrailingAction() == STrailingAction.save
                  ? Column(
                      children: [
                        _calculateScreenWidget(),
                        Padding(
                          padding: const EdgeInsets.only(top: 32, right: 32),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (_calculateLeadingAction() == SLeadingAction.cancel)
                                Padding(
                                  padding: EdgeInsets.only(right: _calculateTrailingAction() == STrailingAction.save ? 16 : 0),
                                  child: CrossButton(
                                    onAction: _onCancel,
                                    type: SButtonType.cancel,
                                    label: 'Cancel',
                                  ),
                                ),
                              if (_calculateTrailingAction() == STrailingAction.save)
                                CrossButton(
                                  onAction: _onSave,
                                  label: 'Save',
                                )
                            ],
                          ),
                        ),
                      ],
                    )
                  : _calculateScreenWidget(),
            )
          ],
          titleBar: TitleBar(
            decoration: BoxDecoration(
              color: SDisplay.instance.primaryColor,
            ),
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

  Widget _buildMobileWidget(SPlatform platform) => PlatformScaffold(
        backgroundColor: SDisplay.instance.contentAreaBackgroundColor,
        appBar: PlatformAppBar(
          backgroundColor: SDisplay.instance.primaryColor,
          title: Text(
            _calculateScreenTitle(),
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline5?.fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          leading: _calculateLeadingAction() == SLeadingAction.cancel
              ? CrossButton(
                  label: platform == SPlatform.android ? 'X' : 'Cancel',
                  small: true,
                  onAction: _onCancel,
                )
              : null,
          trailingActions: [
            if (_calculateTrailingAction() == STrailingAction.save)
              CrossButton(
                label: 'Save',
                small: true,
                onAction: _onSave,
              )
          ],
        ),
        body: _calculateScreenWidget(),
        bottomNavBar: PlatformNavBar(
          currentIndex: _selectedIndex,
          itemChanged: (index) => _updateIndex(index),
          items: _allPages.map((anItem) => BottomNavigationBarItem(icon: Icon(anItem.icon), label: anItem.label)).toList(),
        ),
        iosContentPadding: false,
        iosContentBottomPadding: false,
      );

  void _onSave() => SDisplay.instance.showAlertDialog(
      context: context,
      title: 'Save Simulation',
      message: 'This is where the '
          'form would be saved.');

  void _onCancel() => SDisplay.instance.showAlertDialog(
      context: context,
      title: 'Cancel Simulation',
      message: 'This is where the '
          'form input would be canceled.');

  _updateIndex(int index) => setState(() => _selectedIndex = index);

  Widget _calculateScreenWidget() => _allPages[_selectedIndex].screen;

  String _calculateScreenTitle() => _allPages[_selectedIndex].label;

  SLeadingAction? _calculateLeadingAction() => _allPages[_selectedIndex].leading;

  STrailingAction? _calculateTrailingAction() => _allPages[_selectedIndex].trailing;
}
