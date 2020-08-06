import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as client;
import 'package:todoapp/data/model/api_response_model.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodos();
}

class TodoRepositoryImpl implements TodoRepository {
  @override
  Future<List<Todo>> getTodos() async {
    var response =
        await client.get("http://jsonplaceholder.typicode.com/todos");
    if (response.statusCode == 200) {
      return ApiResultModel.fromJson(json.decode(response.body)).todos;
    } else {
      throw Exception('Failed to load post');
    }
  }
}
