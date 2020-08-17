import 'package:equatable/equatable.dart';
import 'package:todoapp/data/model/api_response_model.dart';

abstract class TodoState extends Equatable {}

class TodoInitialState extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoLoadingState extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoLoadedState extends TodoState {
  final List<Todo> todo;

  TodoLoadedState(this.todo);

  @override
  List<Object> get props => null;
}

class TodoErrorState extends TodoState {
  final String msg;

  TodoErrorState(this.msg);

  @override
  List<Object> get props => null;
}
