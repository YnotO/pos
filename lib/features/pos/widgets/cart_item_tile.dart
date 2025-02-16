import 'package:flutter/material.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('SoftCare Pampus'),
      subtitle: Text('Qty: 1'),
      trailing:
          Text('ksh 670.00', style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
