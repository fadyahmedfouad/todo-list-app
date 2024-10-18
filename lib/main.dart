import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:untitled3/ui/hom_nav_bar.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Correctly initialize the directory for Hive
  //final directory = await getApplicationDocumentsDirectory();
 // Hive.init(directory.path);

  // Open the Hive box
  await Hive.openBox('myBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeNavBar(),
      theme: ThemeData(
        primaryColor: Colors.yellow,
      ),
    );
  }
}
