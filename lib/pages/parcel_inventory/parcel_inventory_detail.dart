import 'package:intl/intl.dart'; // Add this import for date formatting
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> data;
  final String docId;

  const DetailPage({super.key, required this.data, required this.docId});

  @override
  Widget build(BuildContext context) {
    final trackingID1 = data['trackingId1'];
    final remarks = data['remarks'] ?? 'No remarks';
    final status = data['status'];
    final trackingID2 = data['trackingId2'] ?? 'No Tracking ID';
    final trackingID3 = data['trackingId3'] ?? 'No Tracking ID';
    final trackingID4 = data['trackingId4'] ?? 'No Tracking ID';
    final warehouse = data['warehouse'] ?? 'No warehouse data';
    final ownerId = data['ownerId']?.toString() ?? '';
    final receiverId = data['receiverId'] ?? 'No receiver ID data';
    final receiverRemark =
        data['receiverRemarks'] ?? 'No receiver remarks data';
    final receiverImageUrl =
        data['receiverImageUrl'] ?? 'No receiver image data';
    final imageUrl = data['imageUrl'];
    final timestampDelivered = data['timestamp_arrived_sorted'] != null
        ? (data['timestamp_arrived_sorted'] as Timestamp).toDate()
        : null;
    final timestampArrived = data['timestamp_delivered'] != null
        ? (data['timestamp_delivered'] as Timestamp).toDate()
        : null;

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        appBar: AppBar(
          title: Text('Parcel Details - [$trackingID1]'),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 0,
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
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
                                          const Icon(Icons
                                              .image_not_supported_outlined),
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
                              if (trackingID2.isNotEmpty)
                                Text(
                                  'Tracking ID 2 : $trackingID2',
                                ),
                              if (trackingID3.isNotEmpty)
                                Text(
                                  'Tracking ID 3 : $trackingID3',
                                ),
                              if (trackingID4.isNotEmpty)
                                Text(
                                  'Tracking ID 4 : $trackingID4',
                                ),
                              if (ownerId.isNotEmpty)
                                Text(
                                  'Owner : $ownerId',
                                ),
                              if (remarks.isNotEmpty)
                                Text(
                                  'Remarks/Notes : $remarks',
                                ),
                              Text('Wherehouse : $warehouse')
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 1, 20, 1),
                    child: Divider(
                      color: Theme.of(context).colorScheme.primary,
                    ),
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
                              if (status == 'DELIVERED')
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 5, 5, 1),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text('Status : '),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 13, 196, 0),
                                                border: Border.all(),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10))),
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 1, 5, 1),
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
                                      if (timestampArrived != null)
                                        Text(
                                          'Arrived & sorted at: ${DateFormat.yMMMd().add_jm().format(timestampArrived)}',
                                        ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      if (timestampDelivered != null)
                                        Text(
                                          'Delivered at: ${DateFormat.yMMMd().add_jm().format(timestampDelivered)}',
                                        ),
                                      Text(
                                        'Receiver: $receiverId',
                                      ),
                                      if (receiverRemark.isNotEmpty)
                                        Text('Remarks : $receiverRemark'),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 5, 5, 1),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text('Status : '),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 167, 196, 0),
                                                border: Border.all(),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10))),
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 1, 5, 1),
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
                                      if (timestampArrived != null)
                                        Text(
                                          'Arrived & sorted at: ${DateFormat.yMMMd().add_jm().format(timestampArrived)}',
                                        ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      FilledButton(
                        onPressed: () {},
                        child: const Text('Edit Parcel'),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      FilledButton(
                        onPressed: () {},
                        child: const Text('Delete Parcel'),
                      ),
                    ],
                  ),
                  Center(),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
