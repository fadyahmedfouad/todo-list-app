import 'package:hive/hive.dart';

class TaskDatabase {
  List<List<dynamic>> database = [];
  final _mybox = Hive.box('myBox');

  // Create initial data if the database is empty
  void createInitial() {
    database = [
      ["Make tutorial", false],
      ["Do exercise", false],
    ];
    updateDatabase(); // Save initial data to Hive
  }

  // Load data from Hive
  void loadData() {
    final loadedData = _mybox.get("todolist");
    database = loadedData != null ? List<List<dynamic>>.from(loadedData) : [];
  }

  // Update the database with the current state of the task list
  void updateDatabase() {
    _mybox.put("todolist", database);
  }

  // Get tasks for display
  List<List<dynamic>> getTasks() {
    return database;
  }
}
