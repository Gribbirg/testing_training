part of 'module_list_bloc.dart';

abstract class ModuleListState extends Equatable {}

class ModuleListInitial extends ModuleListState {
  @override
  List<Object?> get props => [];
}

class ModuleListLoading extends ModuleListState {
  @override
  List<Object?> get props => [];
}

class ModuleListLoaded extends ModuleListState {
  final Topic topic;
  final List<Module> modules;

  ModuleListLoaded({required this.modules, required this.topic});

  @override
  List<Object?> get props => [modules, topic];
}

class ModuleListError extends ModuleListState {
  final String message;

  ModuleListError({required this.message});

  @override
  List<Object?> get props => [message];
}

class ModuleListNotFound extends ModuleListState {
  @override
  List<Object?> get props => [];
}