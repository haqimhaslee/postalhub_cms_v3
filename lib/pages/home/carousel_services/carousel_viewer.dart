import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CarouselViewer extends StatefulWidget {
  const CarouselViewer({super.key});
  @override
  State<CarouselViewer> createState() => _CarouselViewerState();
}

class _CarouselViewerState extends State<CarouselViewer> {
  Future<void> _deleteItem(DocumentSnapshot item) async {
    try {
      // Delete the image from Firebase Storage
      final imageUrl = item['image_url'];
      if (imageUrl != null && imageUrl.isNotEmpty) {
        final storageRef = FirebaseStorage.instance.refFromURL(imageUrl);
        await storageRef.delete();
      }

      // Delete the item from Firestore
      await FirebaseFirestore.instance
          .collection('carouselServices')
          .doc(item.id)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting item: $e')),
      );
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
          const Text('Carousel List'),
        ]),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('carouselServices')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No items found'));
          }

          final items = snapshot.data!.docs;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final title = item['title'] ?? 'No Title';
              final imageUrl = item['image_url'] ?? '';

              return ListTile(
                leading: imageUrl.isNotEmpty
                    ? Image.network(imageUrl,
                        width: 50, height: 50, fit: BoxFit.cover)
                    : Icon(Icons.image_not_supported),
                title: Text(title),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteItem(item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
