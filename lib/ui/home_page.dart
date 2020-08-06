import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/bloc/todo_bloc.dart';
import 'package:todoapp/bloc/todo_event.dart';
import 'package:todoapp/bloc/todo_state.dart';
import 'package:todoapp/data/model/api_response_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TodoBloc todoBloc;

  @override
  void initState() {
    super.initState();
    todoBloc = BlocProvider.of<TodoBloc>(context);
    todoBloc.add(FetchTodoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              todoBloc.add(FetchTodoEvent());
            },
          ),
        ],
      ),
      body: Container(
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoLoadingState || state is TodoInitialState) {
              return buildLoadingUi();
            } else if (state is TodoLoadedState) {
              return buildTodoListUi(state.todo);
            } else {
              return buildErrorUi();
            }
          },
        ),
      ),
    );
  }

  Widget buildLoadingUi() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi() {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Something went wrong, Please try again !',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          RaisedButton(
            color: Colors.white,
            child: Text(
              "RELOAD",
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () {
              todoBloc.add(FetchTodoEvent());
            },
          ),
        ]));
  }

  Widget buildTodoListUi(List<Todo> todos) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.lightGreen,
              child: Text(todos[position].id.toString()),
            ),
            title: Text(todos[position].title),
            subtitle: Text(getStatus(todos[position].isCompleted)),
          ),
        );
      },
    );
  }

  String getStatus(bool status) {
    if (status) {
      return 'Completed';
    }
    return 'Incomplete';
  }
}
