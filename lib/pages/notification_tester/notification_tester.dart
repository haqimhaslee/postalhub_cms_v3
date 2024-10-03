// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class notificationTester extends StatefulWidget {
  const notificationTester({super.key});
  @override
  State<notificationTester> createState() => _notificationTesterState();
}

class _notificationTesterState extends State<notificationTester> {
  final _uniqueIdController = TextEditingController();
  final _customTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notification Tester')),
      body: Column(
        children: [
          TextField(
            controller: _uniqueIdController,
            decoration: InputDecoration(labelText: 'Unique ID'),
          ),
          TextField(
            controller: _customTextController,
            decoration: InputDecoration(labelText: 'Custom Text'),
          ),
          ElevatedButton(
            // Changed to ElevatedButton for better visual feedback
            onPressed: () async {
              final uniqueId = _uniqueIdController.text;
              final customText = _customTextController.text;

              // Fetch data from Firestore
              final docSnapshot = await FirebaseFirestore.instance
                  .collection('client_user') // Replace with your collection
                  .doc(uniqueId)
                  .get();

              if (docSnapshot.exists) {
                final data = docSnapshot.data() as Map<String, dynamic>;
                final fcmToken = data['fcmtoken']; // Assuming 'fcmtoken' field

                // Send notification
                await _sendNotification(fcmToken, customText);
              } else {
                // Handle case where document doesn't exist
                print('Document not found for unique ID: $uniqueId');
              }
            },
            child: Text('Send Notification'),
          ),
        ],
      ),
    );
  }

  Future<void> _sendNotification(String fcmToken, String customText) async {
    // Replace with your FCM server key
    const serverKey = 'YOUR_FCM_SERVER_KEY';

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    final body = {
      'to': fcmToken,
      'notification': {
        'title': 'Custom Notification', // You can customize this
        'body': customText,
      },
    };

    final response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification: ${response.body}');
    }
  }
}
