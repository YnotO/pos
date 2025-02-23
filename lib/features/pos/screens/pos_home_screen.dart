import 'package:flutter/material.dart';
import 'package:pos_mgt/features/inventory/screens/inventory_screen.dart';
import 'package:pos_mgt/features/pos/widgets/cart_item_tile.dart';
import 'package:pos_mgt/features/pos/widgets/product_card.dart';

class POSHomeScreen extends StatelessWidget {
  const POSHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POS System'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              _showCartBottomSheet(context);
            },
          ),
        ],
      ),

      // Adding the Sidebar Menu
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.50, // width of the drawer
        child: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                    "Tony"), // You can replace this with a dynamic username
                accountEmail: Text("tony@example.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.blue),
                ),
              ),
              ListTile(
                leading: Icon(Icons.dashboard),
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.inventory),
                title: Text('Products'),
                onTap: () {
                  // Navigate to Settings Screen
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InventoryScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text('Sales History'),
                onTap: () {
                  // Navigate to Sales History Screen
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  // Navigate to Sales History Screen
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () {
                  // Handle Logout
                },
              ),
            ],
          ),
        ),
      ),

      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          // Product Grid & Cart Panel
          Expanded(
            child: Row(
              children: [
                // Product Grid
                Expanded(
                  flex: 2,
                  child: GridView.builder(
                    padding: EdgeInsets.all(6),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                    ),
                    itemCount: 8, // Example product count
                    itemBuilder: (context, index) {
                      return ProductCard();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to show the bottom sheet cart
  void _showCartBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(12),
          height: 400, // Adjust height as needed
          child: Column(
            children: [
              Text(
                'Cart',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: 3, // Example cart items
                  itemBuilder: (context, index) {
                    return CartItemTile();
                  },
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Navigate to checkout screen
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  textStyle: TextStyle(fontSize: 18),
                  backgroundColor: Colors.green,
                ),
                child: Text('Checkout'),
              ),
            ],
          ),
        );
      },
    );
  }
}
