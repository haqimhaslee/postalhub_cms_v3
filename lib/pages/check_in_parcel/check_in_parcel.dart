// ignore_for_file: use_build_context_synchronously

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class CheckInParcel extends StatefulWidget {
  const CheckInParcel({super.key});

  @override
  State<CheckInParcel> createState() => _CheckInParcelState();
}

final TextEditingController trackingId1 = TextEditingController();
final TextEditingController trackingId2 = TextEditingController();
final TextEditingController trackingId3 = TextEditingController();
final TextEditingController trackingId4 = TextEditingController();
final TextEditingController remarks = TextEditingController();

class _CheckInParcelState extends State<CheckInParcel> {
  File? file;
  String? webImagePath;
  ImagePicker imagePicker = ImagePicker();
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> addToFirebase(BuildContext context) async {
    // Get values from text fields
    String trackingid_1 = trackingId1.text;
    String trackingid_2 = trackingId2.text;
    String trackingid_3 = trackingId3.text;
    String trackingid_4 = trackingId4.text;
    String remarks_ = remarks.text;
    String imageUrl = await uploadImage(file!);
    DateTime currentTime = DateTime.now(); // Get current date and time

    // Create a Map to hold data
    Map<String, dynamic> data = {
      'trackingId1': trackingid_1,
      'trackingId2': trackingid_2,
      'trackingId3': trackingid_3,
      'trackingId4': trackingid_4,
      'remarks': remarks_,
      'status': 'ARRIVED-SORTED',
      'warehouse': 'UTP-1',
      'imageUrl': imageUrl, // Add imageUrl to the data map
      'timestamp_arrived_sorted': currentTime, // Add timestamp to the data map
    };

    // Add data to Firestore
    try {
      await FirebaseFirestore.instance.collection('parcelInventory').add(data);

      // Clear text fields (optional)
      trackingId1.text = '';
      trackingId2.text = '';
      trackingId3.text = '';
      trackingId4.text = '';
      remarks.text = '';

      // Clear selected image
      setState(() {
        file = null;
      });

      // Show success Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Parcel added successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (error) {
      // Show error Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding parcel: $error'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<String> uploadImage(File imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference =
        storage.ref().child('parcel_receiver_images/$fileName');
    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

  Future<String> uploadWebImage(XFile imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = storage.ref().child('parcel_images/$fileName');
    UploadTask uploadTask = reference.putData(await imageFile.readAsBytes());
    TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

  Future<void> getImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        if (kIsWeb) {
          webImagePath = pickedFile.path;
        } else {
          file = File(pickedFile.path);
        }
      });
    }
  }

  Future<void> scanBarcode(TextEditingController controller) async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    if (barcodeScanRes != '-1') {
      setState(() {
        controller.text = barcodeScanRes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: webImagePath == null && file == null
                ? MaterialButton(
                    //height: 5,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.6,
                        ),
                        const Icon(
                          Icons.camera,
                          size: 40,
                        ),
                        const Text("Camera"),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                    onPressed: () {
                      getImage();
                    },
                  )
                : MaterialButton(
                    //height: 5,
                    child: kIsWeb
                        ? Image.network(
                            webImagePath!,
                            height: 300,
                            fit: BoxFit.fill,
                          )
                        : Image.file(
                            height: 300,
                            file!,
                            fit: BoxFit.fill,
                          ),
                    onPressed: () {
                      getImage();
                    },
                  ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: trackingId1,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  scanBarcode(trackingId1);
                },
                icon: const Icon(Icons.barcode_reader),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: 'Tracking ID*',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: trackingId2,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  scanBarcode(trackingId2);
                },
                icon: const Icon(Icons.barcode_reader),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: 'Tracking ID 2 (Additional)',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: trackingId3,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  scanBarcode(trackingId3);
                },
                icon: const Icon(Icons.barcode_reader),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: 'Tracking ID 3 (Additional)',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: trackingId4,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  scanBarcode(trackingId4);
                },
                icon: const Icon(Icons.barcode_reader),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: 'Tracking ID 4 (Additional)',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: remarks,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: 'Remarks',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FilledButton(
            onPressed: () {
              if (trackingId1.text.isEmpty || file == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Uh-oh 😯. Missing parcel details'),
                    duration: Duration(seconds: 2),
                  ),
                );
              } else {
                addToFirebase(context);
              }
            },
            child: const Center(
              child: Text(
                "Add parcel",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
