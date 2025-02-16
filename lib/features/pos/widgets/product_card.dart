import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add product to cart
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag, size: 50, color: Colors.blue),
            SizedBox(height: 10),
            Text('Product Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('\$25.00',
                style: TextStyle(fontSize: 14, color: Colors.green)),
          ],
        ),
      ),
    );
  }
}
