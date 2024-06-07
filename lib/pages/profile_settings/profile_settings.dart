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
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          Container(
              color: const Color.fromARGB(0, 255, 255, 255),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(children: [
                      Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                            left: 10,
                            right: 10,
                            bottom: 7.5,
                          ),
                          child: Card(
                            elevation: 1,
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(13)),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 15,
                                        left: 15,
                                        right: 10,
                                        bottom: 15,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              const CircleAvatar(
                                                radius: 40,
                                                backgroundColor: Color.fromARGB(
                                                    255, 255, 255, 255),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 0,
                                                    left: 10,
                                                    right: 10,
                                                    bottom: 0,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Admin",
                                                        style: TextStyle(
                                                            fontSize: 19,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onSecondaryContainer,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                      Text(
                                                        "Email",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          fontSize: 14,
                                                          color: Theme.of(
                                                                  context)
                                                              .colorScheme
                                                              .onSecondaryContainer,
                                                        ),
                                                      ),
                                                    ],
                                                  ))
                                            ],
                                          ),
                                        ],
                                      )),
                                )),
                          )),
                      const Padding(
                          padding: EdgeInsets.only(
                            top: 25,
                            bottom: 5,
                          ),
                          child: Text(
                            'QUICK LINK',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                            bottom: 15,
                            left: 15,
                            right: 15,
                          ),
                          child: Card(
                              elevation: 2,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Column(children: [
                                SizedBox.fromSize(
                                  size: const Size(400, 55),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    child: Material(
                                      color:
                                          const Color.fromARGB(0, 255, 193, 7),
                                      child: InkWell(
                                        //splashColor:Color.fromARGB(255, 191, 217, 255),
                                        onTap: () {},
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "Firebase",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondaryContainer,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox.fromSize(
                                  size: const Size(400, 55),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(),
                                    child: Material(
                                      color:
                                          const Color.fromARGB(0, 255, 193, 7),
                                      child: InkWell(
                                        //splashColor:Color.fromARGB(255, 191, 217, 255),
                                        onTap: () {},
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "GitHub | Source Code",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondaryContainer,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox.fromSize(
                                  size: const Size(400, 55),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                    ),
                                    child: Material(
                                      color:
                                          const Color.fromARGB(0, 255, 193, 7),
                                      child: InkWell(
                                        //splashColor:Color.fromARGB(255, 191, 217, 255),
                                        onTap: () {},
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "-",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondaryContainer,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]))),
                      const Padding(
                          padding: EdgeInsets.only(
                            top: 15,
                            bottom: 5,
                          ),
                          child: Text(
                            'HELP & SUPPORT',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w800),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                            left: 15,
                            right: 15,
                            bottom: 10,
                          ),
                          child: Card(
                            elevation: 2,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Column(
                              children: [
                                SizedBox.fromSize(
                                  size: const Size(400, 55),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      topLeft: Radius.circular(15),
                                    ),
                                    child: Material(
                                      color:
                                          const Color.fromARGB(0, 255, 193, 7),
                                      child: InkWell(
                                        //splashColor:Color.fromARGB(255, 191, 217, 255),
                                        onTap: () {},
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "Disclaimer",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondaryContainer,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox.fromSize(
                                  size: const Size(400, 55),
                                  child: ClipRRect(
                                    child: Material(
                                      color:
                                          const Color.fromARGB(0, 255, 193, 7),
                                      child: InkWell(
                                        //splashColor:Color.fromARGB(255, 191, 217, 255),
                                        onTap: () {},
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "Security Policy",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondaryContainer,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox.fromSize(
                                  size: const Size(400, 55),
                                  child: ClipRRect(
                                    child: Material(
                                      color:
                                          const Color.fromARGB(0, 255, 193, 7),
                                      child: InkWell(
                                        //splashColor:Color.fromARGB(255, 191, 217, 255),
                                        onTap: () => showLicensePage(
                                          context: context,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "Licenses",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondaryContainer,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox.fromSize(
                                  size: const Size(400, 55),
                                  child: ClipRRect(
                                    child: Material(
                                      color:
                                          const Color.fromARGB(0, 255, 193, 7),
                                      child: InkWell(
                                        //splashColor:Color.fromARGB(255, 191, 217, 255),
                                        onTap: () {},
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "Feedback",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondaryContainer,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox.fromSize(
                                  size: const Size(400, 55),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                    ),
                                    child: Material(
                                      color:
                                          const Color.fromARGB(0, 255, 193, 7),
                                      child: InkWell(
                                        //splashColor:Color.fromARGB(255, 191, 217, 255),
                                        onTap: () {},
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "Project Timeline",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSecondaryContainer,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                            bottom: 15,
                            left: 15,
                            right: 15,
                          ),
                          child: Card(
                            color: Theme.of(context).colorScheme.errorContainer,
                            elevation: 1,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: SizedBox.fromSize(
                              size: const Size(400, 55),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                child: Material(
                                  color: const Color.fromARGB(0, 255, 193, 7),
                                  child: InkWell(
                                    //splashColor:Color.fromARGB(255, 191, 217, 255),
                                    onTap: () {},
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Sign Out",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onErrorContainer,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                      const Text(
                        " ",
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w300),
                      )
                    ]),
                  ]))
        ],
      ),
    );
  }
}
