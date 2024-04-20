part of 'module_list_bloc.dart';

abstract class ModuleListEvent extends Equatable {}

class LoadModuleList extends ModuleListEvent {

  final Topic? topic;

  LoadModuleList({required this.topic});

  @override
  List<Object?> get props => [topic];
}