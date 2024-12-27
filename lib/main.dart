import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'Screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDoddOQmjPuRgLBF_B75BCIoPFbMpO92us",
      authDomain: "portfolio-6b6fb.firebaseapp.com",
      projectId: "portfolio-6b6fb",
      storageBucket: "portfolio-6b6fb.appspot.com",
      messagingSenderId: "359216755344",
      appId: "1:359216755344:web:e028257aecf2b449061e15",
      measurementId: "G-KFPYK56201"
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Jyodesh Shakya',
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primarySwatch: Colors.blue,
          ),
          home: const Home(),
        );
      },
    );
  }
}