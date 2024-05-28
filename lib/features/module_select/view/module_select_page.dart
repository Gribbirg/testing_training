import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:testing_training/features/module_select/bloc/module_list_bloc.dart';
import 'package:testing_training/repositories/questions/abstract_questions_repository.dart';
import 'package:testing_training/router/router.dart';
import 'package:testing_training/widgets/drawer.dart';
import 'package:testing_training/widgets/not_found.dart';

import '../../../repositories/questions/models/module.dart';
import '../../../widgets/adaptive_scaffold.dart';
import '../widgets/module_item.dart';

@RoutePage()
class ModuleSelectPage extends StatefulWidget {
  const ModuleSelectPage(
      {super.key, @PathParam("topic") required this.topicId});

  final String? topicId;

  @override
  State<StatefulWidget> createState() => _ModuleSelectPageState();
}

class _ModuleSelectPageState extends State<ModuleSelectPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final _moduleListBloc = ModuleListBloc(
    GetIt.I<AbstractQuestionsRepository>(),
  );

  @override
  void initState() {
    if (widget.topicId == null) {
      AutoRouter.of(context).popAndPush(const HomeRoute());
    } else {
      _moduleListBloc.add(LoadModuleList(topicId: widget.topicId));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return BlocBuilder<ModuleListBloc, ModuleListState>(
        bloc: _moduleListBloc,
        builder: (BuildContext context, ModuleListState state) {
          if (state is ModuleListLoaded) {
            final modulesList = [
              const Module(
                  name: "Тест", dirName: "testing", questionsCount: 30)
            ] +
                state.modules;
            return AdaptiveScaffold(
                scaffoldKey: _key,
                drawer: _getDrawer(),
                appBarTitle: state.topic.name,
                body: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Выберите модуль:",
                    style: TextStyle(fontSize: 20),
                  ),
                  Expanded(
                      flex: 1,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(4),
                        itemCount: modulesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Align(
                            alignment: Alignment.center,
                            child: Container(
                              constraints: const BoxConstraints(maxWidth: 800),
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: ModuleItem(
                                topic: state.topic,
                                module: modulesList[index],
                              ),
                            ),
                          );
                        },
                      )),
                ]));
          }

          if (state is ModuleListError) {
            final message = state.message;
            return Center(
              child: Text(message),
            );
          }

          if (state is ModuleListNotFound) {
            return AdaptiveScaffold(
              scaffoldKey: _key,
              drawer: _getDrawer(),
              appBarTitle: '404',
              body: const NotFoundWidget(),
            );
          }

          return AdaptiveScaffold(
            scaffoldKey: _key,
            drawer: _getDrawer(),
            appBarTitle: 'Загрузка...',
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Widget _getDrawer() =>
      BaseDrawer(
        scaffoldKey: _key,
      );
}
