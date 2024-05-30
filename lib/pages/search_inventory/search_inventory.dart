import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _firestore
          .collection('parcelInventory') // Replace with your collection name
          .where('trackingId1', isEqualTo: searchTerm) // Adjust query as needed
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final documents = snapshot.data!.docs;
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
            final data = documents[index].data();
            final imageUrl = data[
                'imageUrl']; // Replace 'imageUrl' with the actual field name

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                        errorMessage = 'Failed to load image: $error';
                      }
                      return Column(
                        children: [
                          const Icon(Icons.image_not_supported_outlined),
                          Text(errorMessage),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Tracking No 1: ${data['trackingId1']}',
                ),
                Text(
                  'Tracking No 2: ${data['trackingId2']}',
                ),
                Text(
                  'Remarks/Notes: ${data['remarks']}',
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 1),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        border: Border.all(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
                        child: Text(
                          data['status'],
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary),
                        )),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}
