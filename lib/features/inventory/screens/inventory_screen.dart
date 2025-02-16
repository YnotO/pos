import 'package:flutter/material.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navigate to add product screen
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search product...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          // 📦 Product List
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(8),
              itemCount: 10, // Example inventory count
              separatorBuilder: (_, __) => Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue[100],
                    child: Icon(Icons.inventory, color: Colors.blue),
                  ),
                  title: Text('Product ${index + 1}'),
                  subtitle: Row(
                    children: [
                      Icon(Icons.attach_money, size: 16, color: Colors.green),
                      Text(' 120.00'),
                      Spacer(),
                      _stockIndicator(10), // Stock Indicator Widget
                    ],
                  ),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(Icons.edit),
                          title: Text('Edit'),
                          onTap: () {
                            // Navigate to Edit Product Screen
                          },
                        ),
                      ),
                      PopupMenuItem(
                        child: ListTile(
                          leading: Icon(Icons.delete, color: Colors.red),
                          title: Text('Delete'),
                          onTap: () {
                            // Delete confirmation dialog
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Add Product screen
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
    );
  }

  // Stock Level Indicator
  Widget _stockIndicator(int stock) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: stock > 5 ? Colors.green[200] : Colors.red[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        stock > 5 ? 'In Stock' : 'Low Stock',
        style: TextStyle(
          color: stock > 5 ? Colors.green[800] : Colors.red[800],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
