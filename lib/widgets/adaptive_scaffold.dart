import 'package:flutter/material.dart';
import 'package:testing_training/widgets/app_bar.dart';

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
  static bool _isDrawerOpen = true;

  @override
  Widget build(BuildContext context) {
    if (isDesktop(context)) {
      return Scaffold(
        key: widget.scaffoldKey,
        body: Row(
          children: [
            if (widget.drawer != null && _isDrawerOpen) widget.drawer!,
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
                  _isDrawerOpen = !_isDrawerOpen;
                });
              },
              icon: const Icon(Icons.menu)),
        )
      : null;
}

bool isDesktop(context) => MediaQuery.of(context).size.width > 1000;
