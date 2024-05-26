import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:testing_training/repositories/settings/model/model.dart';
import 'package:testing_training/widgets/app_bar.dart';

import '../features/settings/bloc/settings_bloc.dart';
import '../repositories/settings/abstract_settings_repository.dart';

class AdaptiveScaffold extends StatefulWidget {
  const AdaptiveScaffold(
      {super.key,
      required this.scaffoldKey,
      this.appBarTitle,
      this.drawer,
      required this.body});

  final GlobalKey<ScaffoldState> scaffoldKey;
  final String? appBarTitle;
  final Widget? drawer;
  final Widget body;

  @override
  State<AdaptiveScaffold> createState() => _AdaptiveScaffoldState();
}

class _AdaptiveScaffoldState extends State<AdaptiveScaffold> {
  final Settings settings = GetIt.I<Settings>();
  final _settingsBloc = SettingsBloc(GetIt.I<AbstractSettingsRepository>());

  @override
  Widget build(BuildContext context) {
    if (isDesktop(context)) {
      return Scaffold(
        key: widget.scaffoldKey,
        body: Row(
          children: [
            if (widget.drawer != null && settings.isDesktopDrawerOpened)
              widget.drawer!,
            Expanded(
              child: Scaffold(
                appBar: _getAppBarDesktop(),
                body: widget.body,
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      key: widget.scaffoldKey,
      appBar: _getAppBar(),
      drawer: widget.drawer,
      body: widget.body,
    );
  }

  AppBar? _getAppBar() => widget.appBarTitle != null
      ? getAppBar(
          context,
          text: widget.appBarTitle!,
        )
      : null;

  AppBar? _getAppBarDesktop() => widget.appBarTitle != null
      ? getAppBar(
          context,
          text: widget.appBarTitle!,
          leading: IconButton(
              onPressed: () {
                setState(() {
                  settings.isDesktopDrawerOpened =
                      !settings.isDesktopDrawerOpened;
                  _settingsBloc.add(SaveSettings(settings: settings));
                });
              },
              icon: const Icon(Icons.menu)),
        )
      : null;
}

bool isDesktop(context) => MediaQuery.of(context).size.width > 1000;
