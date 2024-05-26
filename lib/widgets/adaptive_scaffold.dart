import 'package:flutter/material.dart';

class AdaptiveScaffold extends StatefulWidget {
  const AdaptiveScaffold(
      {super.key,
      required this.scaffoldKey,
      this.appBar,
      this.drawer,
      required this.body});

  final GlobalKey<ScaffoldState> scaffoldKey;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget body;

  @override
  State<AdaptiveScaffold> createState() => _AdaptiveScaffoldState();
}

class _AdaptiveScaffoldState extends State<AdaptiveScaffold> {
  @override
  Widget build(BuildContext context) {
    if (isDesktop(context)) {
      return Scaffold(
        key: widget.scaffoldKey,
        body: Row(
          children: [
            if (widget.drawer != null) widget.drawer!,
            Expanded(
              child: Scaffold(
                appBar: widget.appBar,
                body: widget.body,
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      key: widget.scaffoldKey,
      appBar: widget.appBar,
      drawer: widget.drawer,
      body: widget.body,
    );
  }

  bool isDesktop(context) => MediaQuery.of(context).size.width > 1000;
}
