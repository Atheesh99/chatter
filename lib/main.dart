import 'package:chatter/screens/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      // getPages: [
      //   GetPage(name: Routes.SPLASH_SCREEN, page: () => SplashScreen())
      // ],
      // initialRoute: Routes.SPLASH_SCREEN,
      home: const SplashScreen(),
    );
  }
}

class Routes {
  static const String SPLASH_SCREEN = "/";
  static const String DATA = "/data";
  static const String DASHBAORD = "/dashboard";
}
