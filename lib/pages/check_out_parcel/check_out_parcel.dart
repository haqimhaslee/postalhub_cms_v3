// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class CheckOutParcel extends StatefulWidget {
  const CheckOutParcel({super.key});

  @override
  State<CheckOutParcel> createState() => _CheckOutParcelState();
}

final TextEditingController receiverIdTextField = TextEditingController();
final TextEditingController receiverRemarksTextField = TextEditingController();

class _CheckOutParcelState extends State<CheckOutParcel> {
  File? file;
  String? webImagePath;
  ImagePicker imagePicker = ImagePicker();
  FirebaseStorage storage = FirebaseStorage.instance;
  final TextEditingController trackingIdController = TextEditingController();

  final List<Map<String, dynamic>> parcels = [];
  final List<Map<String, dynamic>> cart = [];

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
    Reference reference =
        storage.ref().child('parcel_receiver_images/$fileName');
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

  @override
  void initState() {
    super.initState();
    trackingIdController.text = "";
  }

  Future<void> readAndAddToCart(String trackingId) async {
    try {
      final docRef = FirebaseFirestore.instance
          .collection('parcelInventory')
          .where('trackingId1', isEqualTo: trackingId)
          .get();
      final querySnapshot = await docRef;

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        final docData = {
          ...doc.data(),
          'id': doc.id,
        };
        setState(() {
          if (!cart.any((parcel) => parcel['id'] == doc.id)) {
            parcels.add(docData);
            cart.add(docData);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Parcel already in checkout cart!'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        });
        // Clear the tracking ID TextField after adding to cart
        trackingIdController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Parcel not found!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error reading data: $error'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> updateData() async {
    if ((file == null && webImagePath == null) ||
        receiverIdTextField.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide a receiver ID and take a photo!'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    try {
      String imageUrl;
      if (kIsWeb) {
        imageUrl = await uploadWebImage(XFile(webImagePath!));
      } else {
        imageUrl = await uploadImage(file!);
      }
      String receiverId = receiverIdTextField.text;
      String recerverRemarks = receiverRemarksTextField.text;
      DateTime currentTime = DateTime.now();

      for (var parcel in cart) {
        String docId = parcel['id'];
        await FirebaseFirestore.instance
            .collection('parcelInventory')
            .doc(docId)
            .update({
          'status': 'DELIVERED',
          'receiverImageUrl': imageUrl,
          'receiverId': receiverId,
          'receiverRemarks': recerverRemarks,
          'timestamp_delivered': currentTime,
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Parcel checked out successfully!'),
          duration: Duration(seconds: 2),
        ),
      );

      setState(() {
        cart.clear();
        file = null;
        webImagePath = null;
        receiverIdTextField.clear();
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating data: $error'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void removeFromCart(String docId) {
    setState(() {
      cart.removeWhere((parcel) => parcel['id'] == docId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(children: [
        const SizedBox(height: 10),
        TextField(
          controller: trackingIdController,
          decoration: InputDecoration(
            labelText: 'Tracking ID',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 10),
        FilledButton(
          onPressed: () => readAndAddToCart(trackingIdController.text),
          child: const Text('Add to Checkout'),
        ),
        const SizedBox(height: 20),
        const SizedBox(height: 20),
        cart.isNotEmpty
            ? Column(
                children: [
                  const Text(
                    'Cart',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ...cart.map((parcel) {
                    String docId = parcel['id'];
                    return Card(
                      elevation: 3,
                      child: ListTile(
                        title: Text(parcel['trackingId1'] ?? ''),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle),
                          onPressed: () => removeFromCart(docId),
                        ),
                      ),
                    );
                    // ignore: unnecessary_to_list_in_spreads
                  }).toList(),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: webImagePath == null && file == null
                        ? MaterialButton(
                            //height: 5,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                ),
                                const Icon(
                                  Icons.camera,
                                  size: 40,
                                ),
                                const Text("Camera* (Required)"),
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
                    height: 5,
                  ),
                  TextField(
                    controller: receiverIdTextField,
                    style: const TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                        //suffixIcon: IconButton(
                        //  onPressed: () {},
                        //  icon: const Icon(Icons.barcode_reader),
                        //),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Receiver ID*'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: receiverRemarksTextField,
                    style: const TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                        //suffixIcon: IconButton(
                        //  onPressed: () {},
                        //  icon: const Icon(Icons.barcode_reader),
                        //),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Receiver remarks'),
                  ),
                  FilledButton(
                    onPressed: updateData,
                    child: const Text('Checkout'),
                  ),
                ],
              )
            : const Text('Checkout cart is empty'),
      ]),
    );
  }
}
