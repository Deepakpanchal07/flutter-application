import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/store.dart';
import 'package:flutter_application_1/models/cart.dart';
import 'package:flutter_application_1/models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: "Cart".text.bold.xl4.make().centered(),
      ),
      body: Column(
        children: [
          Expanded(child: _CartList().p32()), // ✅ Expand to prevent overflow
          const Divider(),
          const _CartTotal(),
        ],
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  const _CartTotal();

  @override
  Widget build(BuildContext context) {
    final CartModel _cart = (VxState.store as MyStore).cart; // ✅ Fetch from store

    return Container(
      padding: EdgeInsets.all(16),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          VxConsumer(
            notifications: {},
            mutations: {RemoveMutation},
            builder: (context, _, __) {
              return "\$${_cart.totalPrice}"
                  .text
                  .xl4
                  .bold
                  .color(context.accentColor)
                  .make();
            },
          ),
          ElevatedButton(
            onPressed: () {
              _showConfirmationDialog(context); // ✅ Confirmation dialog before buying
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.theme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: "Buy".text.xl2.white.make(),
          ),
        ],
      ),
    );
  }

  // ✅ Confirmation Dialog for Buy Button
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirm Purchase"),
          content: Text("Are you sure you want to buy these items?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: "Purchase Successful!".text.make(),
                ));
              },
              child: Text("Confirm"),
            ),
          ],
        );
      },
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [RemoveMutation]);
    final CartModel _cart = (VxState.store as MyStore).cart;

    return _cart.items.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.remove_shopping_cart, size: 60, color: Colors.grey),
              10.heightBox,
              "Your Cart is Empty!".text.xl3.bold.make(),
            ],
          ).centered() // ✅ Empty cart message with icon
        : ListView.builder(
            itemCount: _cart.items.length,
            itemBuilder: (context, index) {
              final item = _cart.items[index];

              return ListTile(
                leading: const Icon(Icons.done, color: Colors.green),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                  onPressed: () {
                    RemoveMutation(item);
                    _showUndoSnackbar(context, item); // ✅ Undo option
                  },
                ),
                title: item.name.text.make(),
              );
            },
          );
  }

  // ✅ Undo Snackbar when removing item
  void _showUndoSnackbar(BuildContext context, Items item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${item.name} removed from cart"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            AddMutation(item); // ✅ Add item back
          },
        ),
      ),
    );
  }
}







// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/core/store.dart';
// import 'package:flutter_application_1/models/cart.dart';
// import 'package:velocity_x/velocity_x.dart';

// class CartPage extends StatelessWidget {
//   const CartPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: context.canvasColor,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: "Cart".text.bold.xl4.make().centered(),
//       ),
//       body: Column(
//         children: [
//           _CartList().p32().expand(),
//           Divider(),
//           _CartTotal(),
//         ],
//       ),
//     );
//   }
// }

// class _CartTotal extends StatelessWidget {
//   const _CartTotal();

//   @override
//   Widget build(BuildContext context) {
//     final CartModel _cart =
//         (VxState.store as MyStore).cart; // ✅ Fetch from store

//     return SizedBox(
//       height: 200,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           VxConsumer(
//               notifications: {},
//               mutations: {RemoveMutation},
//               builder: (context, _, __) {
//                 return "\$${_cart.totalPrice}"
//                     .text
//                     .xl5
//                     .color(context.accentColor)
//                     .make();
//               }),
//           30.widthBox,
//           ElevatedButton(
//             onPressed: () {
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 content: "Buying not Supported yet".text.make(),
//               ));
//             },
//             style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all(
//                 context.theme.colorScheme.primary,
//               ),
//             ),
//             child: "Buy".text.xl5.white.make(),
//           ).w(context.percentWidth * 30), // ✅ Fixed button width
//         ],
//       ),
//     );
//   }
// }

// class _CartList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     VxState.watch(context, on: [RemoveMutation]);
//     return VxBuilder(
//       mutations: {RemoveMutation}, // ✅ Listen to RemoveMutation
//       builder: (context, _, __) {
//         final CartModel _cart = (VxState.store as MyStore).cart;

//         return _cart.items.isEmpty
//             ? "Nothing to show".text.xl3.bold.makeCentered()
//             : ListView.builder(
//                 itemCount: _cart.items.length,
//                 itemBuilder: (context, index) => ListTile(
//                   leading: Icon(Icons.done),
//                   trailing: IconButton(
//                     icon: Icon(Icons.remove_circle_outline),
//                     onPressed: () {
//                       RemoveMutation(_cart.items[index]); // ✅ Remove item
//                     },
//                   ),
//                   title: (_cart.items[index].name).text.make(),
//                 ),
//               );
//       },
//     );
//   }
// }
