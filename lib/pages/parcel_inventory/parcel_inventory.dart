import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:shimmer/shimmer.dart';

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
        final totalParcels = documents.length;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  border: Border.all(color: const Color.fromARGB(0, 0, 0, 0)),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
                  child: Text(
                    'Total Parcels: $totalParcels',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  )),
            ),
            const Divider(),
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

class MyListItemWidget extends StatefulWidget {
  final Map<String, dynamic> data;

  const MyListItemWidget({super.key, required this.data});

  @override
  State<MyListItemWidget> createState() => _MyListItemWidgetState();
}

class _MyListItemWidgetState extends State<MyListItemWidget> {
  bool _isVisible = false;
  bool _mounted = false;

  @override
  void initState() {
    super.initState();
    _mounted = true;
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trackingID1 = widget.data['trackingId1'];
    final remarks = widget.data['remarks'] ?? 'No remarks';
    final imageUrl = widget.data['imageUrl'];
    final status = widget.data['status'];

    return VisibilityDetector(
      key: Key(widget.data['trackingId1']),
      onVisibilityChanged: (visibilityInfo) {
        if (_mounted) {
          setState(() {
            _isVisible = visibilityInfo.visibleFraction > 0.1;
          });
        }
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 5, 0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: _isVisible
                      ? Image.network(
                          imageUrl,
                          width: 100.0,
                          height: 100.0,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported_outlined),
                        )
                      : Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            color: Colors.grey[300],
                          ),
                        ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 150,
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
                                        color: const Color.fromARGB(
                                            255, 13, 196, 0),
                                        border: Border.all(),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 1, 5, 1),
                                        child: Text(
                                          widget.data['status'],
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
                                        color: const Color.fromARGB(
                                            255, 167, 196, 0),
                                        border: Border.all(),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 1, 5, 1),
                                        child: Text(
                                          widget.data['status'],
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
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
