import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';

class HomePage extends StatelessWidget {
  final AuthController controller = Get.find();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = controller.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: controller.signOut,
          ),
        ],
      ),
      body: Center(
        child: user == null
            ? const Text("No user logged in")
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: user.photoURL != null
                        ? NetworkImage(user.photoURL!)
                        : null,
                    child: user.photoURL == null
                        ? const Icon(Icons.person, size: 40)
                        : null,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user.displayName ?? 'User',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(user.email ?? ''),
                ],
              ),
      ),
    );
  }
}
