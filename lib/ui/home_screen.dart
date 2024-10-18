import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';
import 'database.dart';
import 'dialog_box.dart';
import 'todo_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskDatabase db = TaskDatabase();
  final TextEditingController _controller = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();
  bool _isAuthenticated = false; // Authentication state

  @override
  void initState() {
    super.initState();
    db.loadData(); // Load data from Hive
    _authenticate(); // Call authenticate on init
  }

  Future<void> _authenticate() async {
    bool authenticated = false;

    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to access your tasks',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
      );
    } catch (e) {
      print('Error during authentication: $e');
    }

    if (!mounted) return;

    setState(() {
      _isAuthenticated = authenticated;
    });

    if (authenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Authenticated successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Authentication failed')),
      );
      // Optionally close the app or redirect to a login screen
    }
  }

  void _handleCheckboxChanged(int index, bool? value) {
    setState(() {
      db.database[index][1] = value ?? false;
    });
    db.updateDatabase();
  }

  void _createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onsave: () {
            if (_controller.text.isNotEmpty) {
              setState(() {
                db.database.add([_controller.text, false]);
                db.updateDatabase();
                _controller.clear();
              });
              Navigator.of(context).pop();
            }
          },
          oncancel: () {
            _controller.clear();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _deleteTask(int index) {
    setState(() {
      db.database.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAuthenticated) {
      return Center(
        child: Text('You must authenticate to access your tasks.'),
      );
    }

    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text('TO DO'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewTask,
        child: const Icon(Icons.add),
      ),
      body: db.database.isNotEmpty
          ? ListView.builder(
        itemCount: db.database.length,
        itemBuilder: (context, index) {
          final task = db.database[index];
          return TodoTitle(
            taskName: task[0],
            taskCompleted: task[1],
            onChanged: (value) => _handleCheckboxChanged(index, value),
            deletefunction: () => _deleteTask(index),
          );
        },
      )
          : const Center(
        child: Text(
          'No tasks added yet!',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }
}
