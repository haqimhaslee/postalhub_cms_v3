// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class OutForDelivery extends StatefulWidget {
  const OutForDelivery({super.key});
  @override
  State<OutForDelivery> createState() => _OutForDeliveryState();
}

class _OutForDeliveryState extends State<OutForDelivery> {
  @override
  Widget build(BuildContext context) {
    // ... other widget code

    return Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Delivery system (Coming Soon)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ));
  }
}
