import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductListScreen extends StatelessWidget {
   ProductListScreen({super.key,  this.uid});

  final String? uid;

 var productItems = ['pant','shirt','sari'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text('My App'),
        // Add any other app bar properties (e.g., actions)
      ),
      body: Column(
        children: [
          // Search Bar (TextField)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                // Handle search query changes
                // Filter cardItems based on the value
              },
              decoration: const  InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          // List of Cards
          Expanded(
            child: ListView.builder(
              itemCount: productItems.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  child: ListTile(
                    leading:const  CircleAvatar(
                      backgroundImage: NetworkImage('https://picsum.photos/200/300'),
                    ),
                    title: Text(productItems[index]),
                    // Add other card content (e.g., subtitle, buttons)
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
