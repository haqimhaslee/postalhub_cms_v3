// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnalyticsParcel extends StatefulWidget {
  const AnalyticsParcel({super.key});

  @override
  State<AnalyticsParcel> createState() => AnalyticsParcelState();
}

class AnalyticsParcelState extends State<AnalyticsParcel> {
  int totalParcels = 0;
  int totalParcelsArrived = 0;
  int totalParcelsOnDelivery = 0;
  int totalParcelsDelivered = 0;
  int totalUserClient = 0;
  int totalUserAdmin = 0;

  @override
  void initState() {
    super.initState();
    _fetchTotalParcels();
    _fetchUserClient();
    _fetchUserAdmin();
    _fetchTotalParcelsArrived();
    _fetchTotalParcelsDelivered();
    _fetchTotalParcelsOnDelivery();
  }

  Future<void> _fetchTotalParcels() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('parcelInventory').get();
      setState(() {
        totalParcels = querySnapshot.size;
      });
    } catch (e) {
      // Handle any errors here
      print("Error fetching total parcels: $e");
    }
  }

  Future<void> _fetchTotalParcelsArrived() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('parcelInventory')
          .where('status', isEqualTo: 1)
          .get();

      setState(() {
        totalParcelsArrived = querySnapshot.docs.length;
      });
    } catch (e) {
      print('Error fetching total arrived parcels: $e');
    }
  }

  Future<void> _fetchTotalParcelsOnDelivery() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('parcelInventory')
          .where('status', isEqualTo: 2)
          .get();

      setState(() {
        totalParcelsOnDelivery = querySnapshot.docs.length;
      });
    } catch (e) {
      print('Error fetching total arrived parcels: $e');
    }
  }

  Future<void> _fetchTotalParcelsDelivered() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('parcelInventory')
          .where('status', isEqualTo: 3)
          .get();

      setState(() {
        totalParcelsDelivered = querySnapshot.docs.length;
      });
    } catch (e) {
      print('Error fetching total arrived parcels: $e');
    }
  }

  Future<void> _fetchUserClient() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('client_user').get();
      setState(() {
        totalUserClient = querySnapshot.size;
      });
    } catch (e) {
      // Handle any errors here
      print("Error fetching total parcels: $e");
    }
  }

  Future<void> _fetchUserAdmin() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('admin_user').get();
      setState(() {
        totalUserAdmin = querySnapshot.size;
      });
    } catch (e) {
      // Handle any errors here
      print("Error fetching total parcels: $e");
    }
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          "Analytics",
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
                                "$totalParcels",
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
                            "Total parcel (Inventory)",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
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
                                "$totalParcelsArrived",
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
                            "Arrived - Sorted",
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
                                "$totalParcelsOnDelivery",
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
                            "On delivery",
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
                                "$totalParcelsDelivered",
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
                            "Delivered",
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
                                "$totalUserClient",
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
                            "User (Client)",
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
                                "$totalUserAdmin",
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
                            "User (Admin)",
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
