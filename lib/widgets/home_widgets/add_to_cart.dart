import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/store.dart';
import 'package:flutter_application_1/models/cart.dart';
import 'package:flutter_application_1/models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';

class AddToCart extends StatelessWidget {
  final Items catalog;

  const AddToCart(
      {super.key, required this.catalog, required Null Function() onPressed});

  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [AddMutation, RemoveMutation]);
    return VxBuilder(
      mutations: {
        AddMutation,
        RemoveMutation
      }, // Ensure these mutations are registered
      builder: (context, _, __) {
        final CartModel _cart = (VxState.store as MyStore).cart;
        bool isInCart = _cart.items.contains(catalog);

        return ElevatedButton(
          onPressed: () {
            if (!isInCart) {
              // Trigger the mutation directly
              AddMutation(catalog).perform();
            } else {
              // Trigger the remove mutation directly
              RemoveMutation(catalog).perform();
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.primary,
            ),
          ),
          child: isInCart
              ? Icon(Icons.done, size: 25, color: Colors.white)
              : Icon(Icons.shopping_cart, size: 25, color: Colors.white),
        );
      },
    );
  }
}

class AddMutation extends VxMutation<MyStore> {
  final Items item;
  AddMutation(this.item);

  @override
  perform() {
    store!.cart.add(item); // Add item to the cart
  }
}

class RemoveMutation extends VxMutation<MyStore> {
  final Items item;
  RemoveMutation(this.item);

  @override
  perform() {
    store!.cart.remove(item); // ✅ Item ko cart se remove karega
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/core/store.dart';
// import 'package:flutter_application_1/models/cart.dart';
// import 'package:flutter_application_1/models/catalog.dart';
// import 'package:velocity_x/velocity_x.dart';

// class AddToCart extends StatelessWidget {
//   final Items catalog;

//   const AddToCart(
//       {super.key, required this.catalog, required Null Function() onPressed});

//   @override
//   Widget build(BuildContext context) {
//     VxState.listen(context, to: [AddMutation]);
//     final CartModel _cart = (VxState.store as MyStore).cart;

//     bool isInCart = _cart.items.contains(catalog);

//     return ElevatedButton(
//       onPressed: () {
//         if (!isInCart) {
//           AddMutation(catalog);
//         }
//       },
//       style: ButtonStyle(
//         backgroundColor:
//             MaterialStateProperty.all(context.theme.colorScheme.primary),
//       ),
//       child: isInCart
//           ? const Icon(Icons.done) // ✔ icon
//           : const Icon(CupertinoIcons.cart_badge_plus), // + icon
//     );
//   }
// }
