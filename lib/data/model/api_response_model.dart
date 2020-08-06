class ApiResultModel {
  List<Todo> todos;

  ApiResultModel({this.todos});

  ApiResultModel.fromJson(List<dynamic> parsedJson) {
    List<Todo> temp = [];
    for (int i = 0; i < parsedJson.length; i++) {
      print("Todo Data ---> $i" + parsedJson[i]["title"]);
      Todo todo = Todo.fromjson(parsedJson[i]);
      temp.add(todo);
    }
    todos = temp;
  }
}

class Todo {
  int id;
  int userId;
  String title;
  bool isCompleted;

  Todo(this.id, this.userId, this.title, this.isCompleted);

  Todo.fromjson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    userId = parsedJson['userId'];
    title = parsedJson['title'];
    isCompleted = parsedJson['completed'];
  }
}
