import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CarouselAdder extends StatefulWidget {
  const CarouselAdder({super.key});

  @override
  State<CarouselAdder> createState() => _CarouselAdderState();
}

class _CarouselAdderState extends State<CarouselAdder> {
  Uint8List? _imageBytes;
  File? _imageFile;
  final picker = ImagePicker();
  final TextEditingController _titleController = TextEditingController();
  bool _isUploading = false;

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        // For mobile, read the file
        _imageFile = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  Future<void> _uploadData() async {
    if ((_imageFile == null && _imageBytes == null) ||
        _titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please provide an image and a title')));
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      String imageUrl = '';

      // Upload image to Firebase Storage for mobile
      final storageRef = FirebaseStorage.instance.ref().child(
          'carouselServices_images/${DateTime.now().millisecondsSinceEpoch}.png');
      final uploadTask = storageRef.putFile(_imageFile!);
      final taskSnapshot = await uploadTask;
      imageUrl = await taskSnapshot.ref.getDownloadURL();

      // Upload data to Firestore
      await FirebaseFirestore.instance.collection('carouselServices').add({
        'title': _titleController.text,
        'image_url': imageUrl,
      });

      // Clear the text field and image picker
      setState(() {
        _titleController.clear();
        _imageBytes = null;
        _imageFile = null;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Upload successful')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Upload failed: $e')));
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Row(children: [
          const Text('Add carousel'),
        ]),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
                "*Carousel/Poster required 16:8 ratio to avoid overflow on client side"),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 10),
            _imageFile == null
                ? Text('No image selected.')
                : Image.file(_imageFile!),
            Divider(),
            if (_isUploading)
              Center(child: CircularProgressIndicator())
            else ...[
              FilledButton(
                onPressed: () async {
                  await _pickImage();
                },
                child: Text('Select Image'),
              ),
              FilledButton(
                onPressed: () async {
                  await _uploadData();
                },
                child: Text('Upload'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
