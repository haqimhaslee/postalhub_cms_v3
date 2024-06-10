import 'package:flutter/material.dart';
import 'package:postalhub_admin_cms/pages/home/carousel_services/carousel_adder.dart';
import 'package:postalhub_admin_cms/pages/home/carousel_services/carousel_viewer.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // ... other widget code

    return Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: ListView(
          children: [
            Text("Analytics"),
            Card(
              child: Text('Analytics'),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Text("Carousel services"),
            SizedBox(
              height: 20,
            ),
            Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: SizedBox(
                    width: 200,
                    child: Column(children: [
                      ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          child: Material(
                            color: const Color.fromARGB(0, 255, 193, 7),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CarouselViewer()));
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(
                                  top: 15,
                                  bottom: 15,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      //width: MediaQuery.of(context).size.width - 180,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                  child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 0),
                                                      child: Text(
                                                          "Show Carousel list",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ))))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))
                    ]))),
            Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: SizedBox(
                    width: 200,
                    child: Column(children: [
                      ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          child: Material(
                            color: const Color.fromARGB(0, 255, 193, 7),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CarouselAdder()));
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(
                                  top: 15,
                                  bottom: 15,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      //width: MediaQuery.of(context).size.width - 180,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                  child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 0),
                                                      child: Text(
                                                          "Add a Carousel",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ))))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))
                    ])))
          ],
        ));
  }
}
