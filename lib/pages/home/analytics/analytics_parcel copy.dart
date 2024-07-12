// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AnalyticsParcel extends StatefulWidget {
  const AnalyticsParcel({super.key});

  @override
  State<AnalyticsParcel> createState() => AnalyticsParcelState();
}

class AnalyticsParcelState extends State<AnalyticsParcel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: SizedBox(
                width: 150,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Material(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 50,
                              height: 50,
                              child: Text(
                                "0",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Total parcel",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
