import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/core/store.dart';
import 'package:flutter_application_1/models/cart.dart';
import 'package:flutter_application_1/utils/routes.dart';
import 'package:flutter_application_1/widgets/catalog_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter_application_1/models/catalog.dart';
import 'package:flutter_application_1/widgets/drawer.dart';
import 'package:flutter_application_1/widgets/home_widgets/catalog_header.dart';
import 'package:flutter_application_1/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<Items> filteredItems = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() => isLoading = true);
    await Future.delayed(Duration(seconds: 2));

    try {
      final catalogJson = await rootBundle.loadString("assets/files/catalog.json");
      final decodedData = jsonDecode(catalogJson);
      final productsData = decodedData["products"];

      CatalogModel.items = List.from(productsData)
          .map<Items>((item) => Items.fromMap(item))
          .toList();

      filteredItems = CatalogModel.items;
    } catch (e) {
      print("Error loading catalog: $e");
    }

    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  void _searchItems(String query) {
    final suggestions = CatalogModel.items.where((item) {
      final itemName = item.name.toLowerCase();
      final input = query.toLowerCase();
      return itemName.contains(input);
    }).toList();

    setState(() => filteredItems = suggestions);
  }

  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;

    return Scaffold(
      backgroundColor: context.canvasColor,
        drawer: MyDrawer(),  // Add your custom drawer here
      appBar: AppBar(
        title: Text("Menu Bar"),  // Add your title here
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),  // Use Material Icons.menu for the hamburger icon
              onPressed: () {
                Scaffold.of(context).openDrawer();  // Open drawer on tap
              },
            );
          },
        ),
      ),
      floatingActionButton: VxBuilder(
        mutations: {AddMutation, RemoveMutation},
        builder: (context, _, __) => FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, MyRoutes.cartRoute),
          backgroundColor: MyTheme.lightBluishColor,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(CupertinoIcons.cart, color: Colors.white, size: 28),
              if (_cart.items.isNotEmpty)
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child: Text(
                        "${_cart.items.length}",
                        key: ValueKey(_cart.items.length),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: loadData,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CatalogHeader(),
                
                TextField(
                  onChanged: _searchItems,
                  decoration: InputDecoration(
                    hintText: "Search products...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ).py16(),
                
                if (isLoading)
                  Expanded(
                    child: ListView.builder(
                      itemCount: 6,
                      itemBuilder: (context, index) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.white,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  )
                else if (filteredItems.isEmpty)
                  "No products found".text.xl.bold.makeCentered().expand()
                else
                  Expanded(child: CatalogList(items: filteredItems)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}











// import 'package:flutter/cupertino.dart';
// import 'package:flutter_application_1/core/store.dart';
// import 'package:flutter_application_1/models/cart.dart';
// import 'package:flutter_application_1/utils/routes.dart';
// import 'package:flutter_application_1/widgets/catalog_list.dart'; // Correct the path based on your project structure
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:convert';
// import 'package:flutter_application_1/models/catalog.dart';
// import 'package:flutter_application_1/widgets/home_widgets/catalog_header.dart';
// import 'package:flutter_application_1/widgets/themes.dart';
// import 'package:velocity_x/velocity_x.dart';

// // ignore: camel_case_types
// class homepage extends StatefulWidget {
//   const homepage({super.key});

//   @override
//   State<homepage> createState() => _homepageState();
// }

// // ignore: camel_case_types
// class _homepageState extends State<homepage> {
//   final int days = 30;

//   final String name = "Deepak";

//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }

//   loadData() async {
//     await Future.delayed(Duration(seconds: 2));
//     final catalogJson =
//         await rootBundle.loadString("assets/files/catalog.json");
//     // ignore: duplicate_ignore
//     // ignore: unused_local_variable
//     final decodedData = jsonDecode(catalogJson);
//     final productsData = decodedData["products"];
//     CatalogModel.items = List.from(productsData)
//         .map<Items>((items) => Items.fromMap(items))
//         .toList();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _cart = (VxState.store as MyStore).cart;
//     return Scaffold(
//         backgroundColor: context.canvasColor,
//         floatingActionButton: VxBuilder(
//           mutations: {AddMutation, RemoveMutation},
//           builder: (context, _, __) => FloatingActionButton(
//                   onPressed: () => Navigator.pushNamed(context, MyRoutes.cartRoute),
//                   backgroundColor: MyTheme.lightBluishColor,
//                   child: Icon(
//                     CupertinoIcons.cart,
//                     color: Colors.white,
//                   ))
//               .badge(
//                   color: Vx.red500,
//                   size: 20,
//                   count: _cart.items.length,
//                   textStyle: TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold)),
//         ),
//         body: SafeArea(
//             child: Container(
//           padding: Vx.m32,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CatalogHeader(),
//               if (CatalogModel.items.isNotEmpty)
//                 CatalogList().py16().expand()
//               else
//                 CircularProgressIndicator().centered().expand(),
//             ],
//           ),
//         )));
//   }
// }
