// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:postalhub_admin_cms/pages/home/analytics/analytics_parcel.dart';

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
            AnalyticsParcel(),
            SizedBox(
              height: 20,
            ),
            Divider(),
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Coming Soon",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).colorScheme.onSurface,
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
