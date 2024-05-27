import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testing_training/main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widgets/adaptive_scaffold.dart';
import '../widgets/settings_drawer.dart';

@RoutePage()
class AboutAppPage extends StatefulWidget {
  const AboutAppPage({super.key});

  @override
  State<AboutAppPage> createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  static const String _phone = '+7 (977) 945-64-92';
  static const String _mail = 'gribkovalexander@gmail.com';
  static const String _githubLink = 'https://github.com/grib-testing-training/testing_training';
  static const String _tgLink = 'https://t.me/Alex_Gribbirg';
  static const String _vkLink = 'https://vk.com/gribbirg';

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      scaffoldKey: _key,
      drawer: SettingsDrawer(scaffoldKey: _key),
      appBarTitle: 'О приложении',
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 600,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Приложение для подготовки студентов ПМГМУ им. Сеченова к ЦТ по различным предметам. Вопросы основаны на банке заданий.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(
                      maxHeight: 150,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Expanded(
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Данное приложение с открытым исходным кодом. Он находится на GitHub репозитории.',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            child: IconButton(
                              onPressed: () {
                                _goToUrl(_githubLink);
                              },
                              icon: Image.asset(
                                  path('images/github_logo_light.png')),
                              style: ButtonStyle(
                                  shape: WidgetStateProperty.all(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(maxHeight: 100),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Expanded(
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Контакты разработчика',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            child: IconButton(
                              color: Theme.of(context).colorScheme.onSurface,
                              onPressed: () {
                                _goToUrl(_tgLink);
                              },
                              icon: const Icon(
                                Icons.telegram,
                                size: 70,
                              ),
                              style: ButtonStyle(
                                  shape: WidgetStateProperty.all(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))))),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            color:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            child: IconButton(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onTertiaryContainer,
                              onPressed: () {
                                _goToUrl(_vkLink);
                              },
                              icon: Image.asset(path('images/vk_icon.png')),
                              style: ButtonStyle(
                                  shape: WidgetStateProperty.all(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    child: ListTile(
                      leading: const Icon(Icons.mail),
                      title: const Text(_mail),
                      onTap: () {
                        _goToUrl('mailto:$_mail');
                      },
                      onLongPress: () {
                        _copyText(_mail);
                        _showSnackBar();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  Card(
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                    child: ListTile(
                      leading: const Icon(Icons.phone),
                      title: const Text(_phone),
                      onTap: () {
                        _goToUrl(
                            'tel:${_phone.replaceAll(' ', '').replaceAll('(', '').replaceAll(')', 'replace').replaceAll('-', 'replace')}');
                      },
                      onLongPress: () {
                        _copyText(_phone);
                        _showSnackBar();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _goToUrl(String url) async {
    final uri = Uri.parse(url);
    if (!(await launchUrl(uri))) {
      throw 'Could not launch $url';
    }
  }

  Future<void> _copyText(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text(
        'Скопировано',
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 10,
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      width: 300,
    ));
  }
}
