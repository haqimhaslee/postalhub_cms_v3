import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ParcelInventory extends StatefulWidget {
  const ParcelInventory({super.key});
  @override
  State<ParcelInventory> createState() => _ParcelInventoryState();
}

class _ParcelInventoryState extends State<ParcelInventory> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final collectionStream =
        _firestore.collection('parcelInventory').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: collectionStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final documents = snapshot.data!.docs;
        final totalParcels = documents.length; // Get the total count of parcels

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'Total Parcels: $totalParcels'), // Display the total count
            ),
            Expanded(
              child: ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final data = documents[index].data();
                  if (data is Map<String, dynamic>) {
                    return MyListItemWidget(data: data);
                  } else {
                    // Handle unexpected data type (e.g., print a warning)
                    return const SizedBox(); // Or any placeholder widget
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class MyListItemWidget extends StatelessWidget {
  final Map<String, dynamic> data; // Explicitly define data type

  const MyListItemWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final trackingID1 = data['trackingId1'];
    final remarks = data['remarks'] ?? 'No remarks';
    final imageUrl = data['imageUrl'];
    final status = data['status'];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 5, 0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  imageUrl,
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported_outlined),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Track No 1: $trackingID1'),
                      Text('Remarks: $remarks'),
                      if (status == 'DELIVERED')
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 5, 1),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 13, 196, 0),
                                    border: Border.all(),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 1, 5, 1),
                                    child: Text(
                                      data['status'],
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                    )),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 5, 1),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 167, 196, 0),
                                    border: Border.all(),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 1, 5, 1),
                                    child: Text(
                                      data['status'],
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary),
                                    )),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ))
            ],
          ),
        )
      ],
    );
  }
}
