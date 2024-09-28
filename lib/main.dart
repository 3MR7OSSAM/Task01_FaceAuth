import 'package:face_camera/face_camera.dart';
import 'package:face_detector/model/face_features.dart';
import 'package:face_detector/model/points.dart';
import 'package:face_detector/model/user_model.dart';
import 'package:face_detector/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';


Future<void> main() async {
  await Hive.initFlutter();

  // Register the adapters
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(FaceFeaturesAdapter());
  Hive.registerAdapter(PointsAdapter());
  WidgetsFlutterBinding.ensureInitialized(); //Add this

  await FaceCamera.initialize(); //Add this
  // Open the Hive box for UserModel
  await Hive.openBox<UserModel>('users');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Face Detector',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.redAccent,
          titleTextStyle: TextStyle(color: Colors.white)
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
