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
  final List<Module> modules;

  ModuleListLoaded({required this.modules});

  @override
  List<Object?> get props => [modules];
}

class ModuleListError extends ModuleListState {
  final String message;

  ModuleListError({required this.message});

  @override
  List<Object?> get props => [];
}
