import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:postalhub_admin_cms/login_services/login_page.dart';
import 'package:postalhub_admin_cms/login_services/auth_page.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  Future<void> logout() async {
    try {
      await AuthService.logout();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('My Profile'),
          Card(elevation: 1, child: Text("Logged in as : ${user}")),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: logout,
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
