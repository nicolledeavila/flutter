import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyect/services/api_service.dart';

// Events
abstract class TasksEvent {}

class LoadTasks extends TasksEvent {}

// States
abstract class TasksState {}

class TasksInitial extends TasksState {}

class TasksLoading extends TasksState {}

class TasksLoaded extends TasksState {
  final Map<String, dynamic> tasksData;
  TasksLoaded(this.tasksData);
}

class TasksError extends TasksState {
  final String message;
  TasksError(this.message);
}

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksInitial()) {
    on<LoadTasks>(_onLoadTasks);
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TasksState> emit) async {
    emit(TasksLoading());
    
    try {
      final tasksData = await ApiService.fetchTasksData();
      emit(TasksLoaded(tasksData));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }
}