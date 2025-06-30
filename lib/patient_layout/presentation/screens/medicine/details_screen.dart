import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/core/constants/app_colors/app_colors.dart';

class MedicineDetailsScreen extends StatefulWidget {
  static const routeName = 'details-screen';
  final Map<String, dynamic> medicine;

  const MedicineDetailsScreen({super.key, required this.medicine});

  @override
  State<MedicineDetailsScreen> createState() => _MedicineDetailsScreenState();
}

class _MedicineDetailsScreenState extends State<MedicineDetailsScreen> {
  int selectedQuantity = 1;

  @override
  Widget build(BuildContext context) {
    final medicine = widget.medicine;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(medicine['name'] ?? 'Medicine Details',
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                medicine['imageUrl'] ?? '',
                height: 400,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.broken_image, size: 100),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  medicine['name'] ?? 'Unknown',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${medicine['price']} EGP',
                  style: TextStyle(fontSize: 18, color: Colors.teal[700]),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Available Quantity: ${medicine['quantity']}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Description:',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  medicine['description'] ?? 'No description.',
                  style: TextStyle(fontSize: 15, height: 1.5),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // ✅ كمية الشراء + و -
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    if (selectedQuantity > 1) {
                      setState(() => selectedQuantity--);
                    }
                  },
                  icon: Icon(Icons.remove_circle_outline),
                ),
                Text(
                  '$selectedQuantity',
                  style: TextStyle(fontSize: 18),
                ),
                IconButton(
                  onPressed: () {
                    if (selectedQuantity < medicine['quantity']) {
                      setState(() => selectedQuantity++);
                    }
                  },
                  icon: Icon(Icons.add_circle_outline),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // ✅ زر الشراء
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final docRef = FirebaseFirestore.instance
                      .collection('medicines')
                      .doc(medicine['id']);

                  final availableQty = medicine['quantity'];

                  if (selectedQuantity > availableQty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Not enough stock! ❌')),
                    );
                    return;
                  }

                  try {
                    await docRef.update({
                      'quantity': availableQty - selectedQuantity,
                    });

                    setState(() {
                      widget.medicine['quantity'] =
                          availableQty - selectedQuantity;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            '✅ $selectedQuantity item(s) purchased successfully'),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('❌ Error: $e')),
                    );
                  }
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                label: Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
