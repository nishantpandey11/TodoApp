import 'package:bloc/bloc.dart';
import 'package:todoapp/bloc/todo_event.dart';
import 'package:todoapp/bloc/todo_state.dart';
import 'package:todoapp/data/model/api_response_model.dart';
import 'package:todoapp/data/repository/todo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoRepository repository;

  TodoBloc(this.repository) : super(TodoInitialState());

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is FetchTodoEvent) {
      yield TodoLoadingState();
      try {
        List<Todo> todos = await repository.getTodos();
        yield TodoLoadedState(todos);
      } catch (e) {
        yield TodoErrorState(e.toString());
      }
    }
  }
}
