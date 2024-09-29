// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting
import 'package:another_stepper/another_stepper.dart';

class SearchInventory extends StatefulWidget {
  const SearchInventory({super.key});
  @override
  State<SearchInventory> createState() => _SearchInventoryState();
}

final searchInput = TextEditingController();

class _SearchInventoryState extends State<SearchInventory> {
  final _firestore = FirebaseFirestore.instance;
  String _searchTerm = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: TextField(
              controller: searchInput,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      searchInput.clear();
                    });
                  },
                  icon: const Icon(Icons.cancel),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Tracking Number*',
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: _buildSearchResults(_searchTerm),
          ),
          FilledButton(
            onPressed: () => setState(() => _searchTerm = searchInput.text),
            child: const Center(
              child: Text(
                "Search",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(String searchTerm) {
    if (searchTerm.isEmpty) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/gif/search.gif",
            ),
            const Text('Enter a tracking number to search.'),
            const Text('*Tracking numbers are case sensitive')
          ],
        ),
      );
    }

    return FutureBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
      future: _performSearch(searchTerm),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final documents = snapshot.data ?? [];
        if (documents.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/gif/not_found.gif",
                ),
                const Text('No items found for that tracking number.')
              ],
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final data = documents[index].data()!;
            final imageUrl = data['imageUrl'];
            final trackingId2 = data['trackingId2']?.toString() ?? '';
            final trackingId3 = data['trackingId3']?.toString() ?? '';
            final trackingId4 = data['trackingId4']?.toString() ?? '';
            final receiverRemarks = data['receiverRemarks']?.toString() ?? '';
            final remarks = data['remarks']?.toString() ?? '';
            final status = data['status'];
            final receiverImageUrl = data['receiverImageUrl'];
            final timestampSorted = data['timestamp_arrived_sorted'] != null
                ? (data['timestamp_arrived_sorted'] as Timestamp).toDate()
                : null;
            final timestampDelivered = data['timestamp_delivered'] != null
                ? (data['timestamp_delivered'] as Timestamp).toDate()
                : null;

            List<StepperData> stepperDataDelivered = [
              StepperData(
                  title: StepperText(
                    "Ready to take",
                    textStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  subtitle: StepperText("Arriving/Sorting"),
                  iconWidget: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: const Icon(Icons.inventory, color: Colors.white),
                  )),
              StepperData(
                  title: StepperText(
                    "On delivery",
                    textStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  subtitle: StepperText("On delivery"),
                  iconWidget: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child:
                        const Icon(Icons.delivery_dining, color: Colors.white),
                  )),
              StepperData(
                  title: StepperText("Delivered",
                      textStyle: const TextStyle(
                        color: Colors.grey,
                      )),
                  subtitle: StepperText("Delivery"),
                  iconWidget: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: const Icon(Icons.check_rounded, color: Colors.white),
                  ))
            ];

            List<StepperData> stepperDataSorted = [
              StepperData(
                  title: StepperText(
                    "Ready to take",
                    textStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  subtitle: StepperText("Arriving/Sorting"),
                  iconWidget: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: const Icon(Icons.inventory, color: Colors.white),
                  )),
              StepperData(
                  title: StepperText(
                    "On delivery",
                    textStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  subtitle: StepperText("On delivery"),
                  iconWidget: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child:
                        const Icon(Icons.delivery_dining, color: Colors.white),
                  )),
              StepperData(
                  title: StepperText("Delivered",
                      textStyle: const TextStyle(
                        color: Colors.grey,
                      )),
                  subtitle: StepperText("Delivery"),
                  iconWidget: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: const Icon(Icons.check_rounded, color: Colors.white),
                  ))
            ];

            List<StepperData> stepperDataOnDelivery = [
              StepperData(
                  title: StepperText(
                    "Ready to take",
                    textStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  subtitle: StepperText("Arriving/Sorting"),
                  iconWidget: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: const Icon(Icons.inventory, color: Colors.white),
                  )),
              StepperData(
                  title: StepperText(
                    "On delivery",
                    textStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  subtitle: StepperText("On delivery"),
                  iconWidget: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child:
                        const Icon(Icons.delivery_dining, color: Colors.white),
                  )),
              StepperData(
                  title: StepperText("Not delivered",
                      textStyle: const TextStyle(
                        color: Colors.grey,
                      )),
                  subtitle: StepperText("Delivery"),
                  iconWidget: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: const Icon(Icons.check_rounded, color: Colors.white),
                  ))
            ];

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    switch (status) {
                      1 => AnotherStepper(
                          stepperList: stepperDataSorted,
                          stepperDirection: Axis.horizontal,
                          iconWidth: 40,
                          iconHeight: 40,
                          activeBarColor: Colors.green,
                          inActiveBarColor: Colors.grey,
                          inverted: true,
                          verticalGap: 20,
                          activeIndex: 0,
                          barThickness: 8,
                        ),
                      2 => AnotherStepper(
                          stepperList: stepperDataOnDelivery,
                          stepperDirection: Axis.horizontal,
                          iconWidth: 40,
                          iconHeight: 40,
                          activeBarColor: Colors.green,
                          inActiveBarColor: Colors.grey,
                          inverted: true,
                          verticalGap: 20,
                          activeIndex: 1,
                          barThickness: 8,
                        ),
                      3 => AnotherStepper(
                          stepperList: stepperDataDelivered,
                          stepperDirection: Axis.horizontal,
                          iconWidth: 40,
                          iconHeight: 40,
                          activeBarColor: Colors.green,
                          inActiveBarColor: Colors.grey,
                          inverted: true,
                          verticalGap: 20,
                          activeIndex: 2,
                          barThickness: 8,
                        ),
                      _ => Container(), // Handle default case if needed
                    },
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 0,
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  imageUrl,
                                  width: 300.0,
                                  height: 300.0,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    String errorMessage;
                                    if (error is NetworkImageLoadException) {
                                      errorMessage = 'Network error: $error';
                                    } else {
                                      errorMessage =
                                          'Failed to load image: $error';
                                    }
                                    return Column(
                                      children: [
                                        const Icon(
                                            Icons.image_not_supported_outlined),
                                        Text(errorMessage),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 0, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tracking ID 1 : ${data['trackingId1']}',
                            ),
                            if (trackingId2.isNotEmpty)
                              Text(
                                'Tracking ID 2 : $trackingId2',
                              ),
                            if (trackingId3.isNotEmpty)
                              Text(
                                'Tracking ID 3 : $trackingId3',
                              ),
                            if (trackingId4.isNotEmpty)
                              Text(
                                'Tracking ID 4 : $trackingId4',
                              ),
                            if (remarks.isNotEmpty)
                              Text(
                                'Remarks/notes : $remarks',
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 1, 20, 1),
                ),
                Card(
                  elevation: 0,
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (status == 3)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 5, 5, 1),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (timestampSorted != null)
                                      Text(
                                        'Arrived & sorted at: ${DateFormat.yMMMd().add_jm().format(timestampSorted)}',
                                      ),
                                    if (timestampDelivered != null)
                                      Text(
                                        'Delivered at: ${DateFormat.yMMMd().add_jm().format(timestampDelivered)}',
                                      ),
                                    Text(
                                      'Receiver: ${data['receiverId']}',
                                    ),
                                    if (receiverRemarks.isNotEmpty)
                                      Text(
                                          'Remarks/notes : ${data['receiverRemarks']}'),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            receiverImageUrl,
                                            width: 300.0,
                                            height: 300.0,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              String errorMessage;
                                              if (error
                                                  is NetworkImageLoadException) {
                                                errorMessage =
                                                    'Network error: $error';
                                              } else {
                                                errorMessage =
                                                    'Failed to load image: $error';
                                              }
                                              return Column(
                                                children: [
                                                  const Icon(Icons
                                                      .image_not_supported_outlined),
                                                  Text(errorMessage),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              )
                            else
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 5, 5, 1),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [],
                                    ),
                                    if (timestampSorted != null)
                                      Text(
                                        'Arrived & sorted at: ${DateFormat.yMMMd().add_jm().format(timestampSorted)}',
                                      ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> _performSearch(
      String searchTerm) async {
    final results1 = await _firestore
        .collection('parcelInventory')
        .where('trackingId1', isEqualTo: searchTerm)
        .get();

    final results2 = await _firestore
        .collection('parcelInventory')
        .where('trackingId2', isEqualTo: searchTerm)
        .get();

    final results3 = await _firestore
        .collection('parcelInventory')
        .where('trackingId3', isEqualTo: searchTerm)
        .get();

    final results4 = await _firestore
        .collection('parcelInventory')
        .where('trackingId4', isEqualTo: searchTerm)
        .get();

    final allResults = [
      ...results1.docs,
      ...results2.docs,
      ...results3.docs,
      ...results4.docs,
    ];

    // Remove duplicates by tracking document IDs
    final uniqueResults =
        {for (var doc in allResults) doc.id: doc}.values.toList();

    return uniqueResults;
  }
}
