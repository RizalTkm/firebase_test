import 'package:flutter/material.dart';

class CustomtextFormField extends StatelessWidget {
  const CustomtextFormField({super.key, required this.label, required this.title, required this.controller});

   final String label;
   final String title;
   final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
         const  SizedBox(height: 5,),
          TextFormField(controller: controller ,

        decoration:  InputDecoration(border: OutlineInputBorder(),label: Text(label)),
        
        
      ),
        ],
      )
    );
  }
}