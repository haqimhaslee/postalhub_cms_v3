// ignore_for_file: deprecated_member_use
import 'package:flutter/foundation.dart'; // Add this import
import 'package:flutter/material.dart';
//import 'package:postalhub_admin_cms/pages/home/analytics/analytics_parcel.dart';
import 'package:postalhub_admin_cms/pages/home/carousel_services/carousel_adder.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:postalhub_admin_cms/pages/home/carousel_services/carousel_viewer.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

Future<void> _launchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // ... other widget code

    return Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: ListView(
          children: [
            //AnalyticsParcel(),
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
                  "Admin Panels",
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
                              onTap: () => _launchUrl(
                                  'https://console.firebase.google.com/project/postalhub/overview'),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      child: Icon(
                                        Icons.bar_chart_rounded,
                                        size: 35,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondaryContainer,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Analytics",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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
                              onTap: () {
                                if (kIsWeb) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Opps! Only avaiable on mobile app for now'),
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CarouselViewer()));
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      child: Icon(
                                        Icons.check_circle_rounded,
                                        size: 35,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondaryContainer,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "View Carousel List",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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
                              onTap: () {
                                if (kIsWeb) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Opps! Only avaiable on mobile app for now'),
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CarouselAdder()));
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      child: Icon(
                                        Icons.add,
                                        size: 35,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondaryContainer,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Add a carousel",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
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
            ),
          ],
        ));
  }
}
