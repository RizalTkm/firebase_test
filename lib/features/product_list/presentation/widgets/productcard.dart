import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  const ProductTile(
      {super.key, required this.productName, required this.imageUrl, required this.productsize, required this.ProductPrice});

  final String productName;
  final String ProductPrice;
  final String imageUrl;
  final String productsize;

  @override
  Widget build(BuildContext context) {
    return Card(shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 300,
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  child: Image.network(
                    'https://images.pexels.com/photos/19561749/pexels-photo-19561749/free-photo-of-young-man-in-glasses-and-retro-suit.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
      
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(productName.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                       
                       RichText(
        text: TextSpan(
        
          style: DefaultTextStyle.of(context).style,
          children:  [
            TextSpan(text: "\$", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40)),

        TextSpan(text: ProductPrice, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40)),
        
          ],
        ),
      ),
                   RichText(
        text: TextSpan(
          text: 'Size: ',
          style: DefaultTextStyle.of(context).style,
          children:  [
        TextSpan(text: productsize, style: TextStyle(fontWeight: FontWeight.bold)),
        
          ],
        ),
      ),
                    ],
                  ))
              // ListTile(
              //   leading: CircleAvatar(
              //     backgroundImage: NetworkImage(imageUrl),
              //   ),
              //   title: Text(productName),
              //   subtitle: const Text('wqdwff'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
