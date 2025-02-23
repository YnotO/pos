import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  AddProductScreenState createState() => AddProductScreenState();
}

class AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  String? selectedCategory;
  File? imageFile;
  bool isLoading = false;

  final supabase = Supabase.instance.client;

  // Fetch categories from Supabase
  Future<List<Map<String, dynamic>>> fetchCategories() async {
    final response = await supabase.from('categories').select();
    return response;
  }

  // Pick an image from the gallery
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  // Upload image to Supabase Storage
  Future<String?> uploadImage(File image) async {
    try {
      final bytes = await image.readAsBytes();
      final fileName = 'products/${DateTime.now().millisecondsSinceEpoch}.jpg';

      await supabase.storage
          .from('product_images')
          .uploadBinary(fileName, bytes);

      final imageUrl =
          supabase.storage.from('product_images').getPublicUrl(fileName);
      return imageUrl;
    } catch (e) {
      debugPrint('Image upload error: $e');
      return null;
    }
  }

  // Add product to Supabase
  Future<void> addProduct() async {
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        selectedCategory == null ||
        imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields and select an image')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    String? imageUrl = await uploadImage(imageFile!);

    if (imageUrl != null) {
      final response = await supabase.from('products').insert({
        'name': nameController.text,
        'category': selectedCategory,
        'price': double.parse(priceController.text),
        'image_url': imageUrl,
        'added_by': 'your-user-id-here', // Replace with logged-in user ID
      });

      if (response.error == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product added successfully')),
        );
        Navigator.pop(context); // Go back after adding
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.error!.message}')),
        );
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            SizedBox(height: 10),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchCategories(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return DropdownButtonFormField<String>(
                  value: selectedCategory,
                  items: snapshot.data!.map((category) {
                    return DropdownMenuItem<String>(
                      value: category['id'].toString(),
                      child: Text(category['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Category'),
                );
              },
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: imageFile == null
                    ? Icon(Icons.image, size: 50, color: Colors.grey)
                    : Image.file(imageFile!, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: addProduct,
                    child: Text('Add Product'),
                  ),
          ],
        ),
      ),
    );
  }
}
