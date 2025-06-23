// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/catalog.dart'; // Ensure `Item` or `Items` is imported correctly

class ItemWidget extends StatelessWidget {
  final Items item; // Changed from 'Item' to 'Items'

  const ItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          onTap: () {
            // ignore: avoid_print
            print("${item.name} pressed");
          },
          leading: Image.network(item.image), // Corrected to use 'item.image'
          title: Text(item.name), // Display item name
          subtitle: Text(item.desc),
          trailing: Text(
            "\$${item.price}",
            textScaleFactor: 1.5,
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/models/catalog.dart';

// class ItemWidget extends StatelessWidget {
//   final Item item;
//   const ItemWidget({required Key key, @required this.item})
//   :assert(item != null),
//   super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Image.network(items.image),
//     );
//   }
// }
