part of 'module_list_bloc.dart';

abstract class ModuleListEvent extends Equatable {}

class LoadModuleList extends ModuleListEvent {

  final String? topicId;

  LoadModuleList({required this.topicId});

  @override
  List<Object?> get props => [topicId];
}