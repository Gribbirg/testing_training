import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:testing_training/features/questions/bloc/questions_list_bloc.dart';

class QuestionFinishedPage extends StatefulWidget {
  const QuestionFinishedPage({super.key, required this.state, required this.restart, required this.toTopics, required this.toModules});

  final QuestionsFinishState state;
  final void Function() restart;
  final void Function() toTopics;
  final void Function() toModules;

  @override
  State<QuestionFinishedPage> createState() => _QuestionFinishedPageState();
}

class _QuestionFinishedPageState extends State<QuestionFinishedPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Тест пройден!',
                  style: TextStyle(
                      fontSize: 25, color: Theme.of(context).colorScheme.primary),
                ),
              ),
              Padding(padding: const EdgeInsets.all(8.0), child: _getDiagram()),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(onPressed: widget.toTopics, child: const Text('К разделам')),
                      const SizedBox(width: 10,),
                      OutlinedButton(onPressed: widget.toModules, child: const Text('К темам')),
                      const SizedBox(width: 10,),
                      FilledButton(onPressed: widget.restart, child: const Text('Заново')),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _getDiagram() {
    final rightCount = widget.state.sessionData.rightsCount.toDouble();
    final wrongCount = widget.state.sessionData.wrongCount.toDouble();
    final noAnsCount = widget.state.sessionData.questionsCount.toDouble() -
        widget.state.sessionData.completeCount.toDouble();
    final allCount = widget.state.sessionData.questionsCount.toDouble();

    final tooltipBehavior = TooltipBehavior(
        enable: true,
        color: Theme.of(context).colorScheme.scrim,
        textStyle: TextStyle(color: Theme.of(context).colorScheme.onBackground),
        format: 'point.y%');

    return Card(
      elevation: 8,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SfCircularChart(
            title: ChartTitle(
              text: 'Результат:',
              textStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            legend: const Legend(isVisible: true, position: LegendPosition.bottom),
            tooltipBehavior: tooltipBehavior,
            series: [
              PieSeries<_ChartData, String>(
                dataSource: [
                  _ChartData(
                    'Правильно',
                    rightCount,
                    rightCount / allCount * 100,
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.onPrimary,
                  ),
                  _ChartData(
                    'Неправильно',
                    wrongCount,
                    wrongCount / allCount * 100,
                    Theme.of(context).colorScheme.error,
                    Theme.of(context).colorScheme.onError,
                  ),
                  _ChartData(
                    'Без ответа',
                    noAnsCount,
                    noAnsCount / allCount * 100,
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.onSecondary,
                  )
                ],
                pointColorMapper: (_ChartData data, _) => data.color,
                xValueMapper: (_ChartData data, _) => data.x,
                yValueMapper: (_ChartData data, _) => data.y,
                dataLabelMapper: (_ChartData data, _) => data.count.toString(),
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  showZeroValue: false,
                  labelPosition: ChartDataLabelPosition.outside,
                  useSeriesColor: true,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.count, this.y, this.color, this.textColor);

  final String x;
  final double count;
  final double y;
  final Color color;
  final Color textColor;
}
