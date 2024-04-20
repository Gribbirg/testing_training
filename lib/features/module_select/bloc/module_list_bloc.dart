import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'module_list_event.dart';
part 'module_list_state.dart';

class ModuleListBloc extends Bloc<ModuleListEvent, ModuleListState> {
  ModuleListBloc(super.initialState);
}