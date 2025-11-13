import 'package:facebook_login/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth_controller.dart';
import 'home_screen.dart';
import 'login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AuthController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Login Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Root(),
    );
  }
}

class Root extends GetWidget<AuthController> {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.user == null ? LoginPage() : HomePage();
    });
  }
}
