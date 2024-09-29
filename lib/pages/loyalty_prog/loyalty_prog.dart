import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class LoyaltyProg extends StatefulWidget {
  const LoyaltyProg({super.key});
  @override
  State<LoyaltyProg> createState() => _LoyaltyProgState();
}

class _LoyaltyProgState extends State<LoyaltyProg> {
  final _uidController = TextEditingController();
  final _pointsToClaimController = TextEditingController();

  Future<void> _claimPoints() async {
    final uid = _uidController.text;
    final pointsToClaim = int.tryParse(_pointsToClaimController.text) ?? 0;

    if (uid.isEmpty) {
      // Handle empty UID (e.g., show an error message)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a UID')),
      );
      return;
    }

    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('client_user')
          .where('unique_id', isEqualTo: uid)
          .get();

      if (userDoc.docs.isNotEmpty) {
        final doc = userDoc.docs.first;
        final currentPoints = doc.get('membership_points') ?? 0;

        if (currentPoints >= pointsToClaim) {
          await doc.reference.update({
            'membership_points': currentPoints - pointsToClaim,
          });

          // Show success message and clear fields
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Points claimed successfully!')),
          );
          _uidController.clear();
          _pointsToClaimController.clear();
        } else {
          // Handle insufficient points
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Insufficient points')),
          );
        }
      } else {
        // Handle user not found
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not found')),
        );
      }
    } catch (e) {
      // Handle errors
      print('Error claiming points: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // ... other widget code

    return Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: TextField(
                    controller: _uidController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Unique ID (UID)*',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: TextField(
                    controller: _pointsToClaimController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Points to be claim*',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FilledButton(
                  onPressed: _claimPoints,
                  child: const Center(
                    child: Text(
                      "Claim",
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ));
  }
}
