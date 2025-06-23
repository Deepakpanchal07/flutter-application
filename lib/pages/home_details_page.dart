import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/catalog.dart';
import 'package:flutter_application_1/widgets/home_widgets/add_to_cart.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeDetailsPage extends StatefulWidget {
  final Items catalog;

  const HomeDetailsPage({super.key, required this.catalog});

  @override
  _HomeDetailsPageState createState() => _HomeDetailsPageState();
}

class _HomeDetailsPageState extends State<HomeDetailsPage> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the scale animation controller
    _scaleController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    // Initialize the fade animation controller
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Start the fade animation
    _fadeController.forward();
    // Start the scale animation
    _scaleController.forward();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Product Details", style: TextStyle(color: context.accentColor)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: context.accentColor),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Sharing ${widget.catalog.name}...")),
              );
            },
          ),
        ],
      ),
      backgroundColor: context.canvasColor,
      bottomNavigationBar: Container(
        color: context.cardColor,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            "\$${widget.catalog.price}".text.bold.xl4.red800.make(),
            AddToCart(
              catalog: widget.catalog,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${widget.catalog.name} added to cart!")),
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // ✅ Hero Animation for Product Image
            Hero(
              tag: Key(widget.catalog.id.toString()),
              child: Image.network(
                widget.catalog.image,
                height: context.percentHeight * 35,
                fit: BoxFit.cover,
              ),
            ).p16(),

            Expanded(
              child: VxArc(
                height: 30.0,
                arcType: VxArcType.convey,
                edge: VxEdge.top,
                child: Container(
                  color: context.cardColor,
                  width: context.screenWidth,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // ✅ Product Name
                        widget.catalog.name.text.bold.xl4.color(context.accentColor).center.make().p16(),

                        // ✅ Stock Availability Badge
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              widget.catalog.isAvailable ? Icons.check_circle : Icons.cancel,
                              color: widget.catalog.isAvailable ? Colors.green : Colors.red,
                            ),
                            5.widthBox,
                            (widget.catalog.isAvailable ? "In Stock" : "Out of Stock")
                                .text
                                .bold
                                .color(widget.catalog.isAvailable ? Colors.green : Colors.red)
                                .make(),
                          ],
                        ).p8(),

                        // ✅ Centered Description
                        widget.catalog.desc.text.textStyle(context.captionStyle).xl.center.make().p16(),

                        10.heightBox,

                        // ✅ Highlighted Product Description
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.blueAccent),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Product Description".text.bold.xl2.color(context.accentColor).make(),
                              8.heightBox,
                              "This product is designed with high-quality materials to ensure long-lasting durability and premium performance. Whether you're using it for professional or personal purposes, it offers reliability and cutting-edge technology.".text.textStyle(context.textTheme.bodyLarge).make(),
                            ],
                          ),
                        ).p16(),

                        10.heightBox,

                        // ✅ Highlighted Key Features Section
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.greenAccent),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Key Features".text.bold.xl2.color(context.accentColor).make(),
                              8.heightBox,
                              ListTile(
                                leading: Icon(Icons.check_circle, color: Colors.green),
                                title: Text("Ergonomic Design for Comfortable Use", textAlign: TextAlign.start),
                              ),
                              ListTile(
                                leading: Icon(Icons.check_circle, color: Colors.green),
                                title: Text("Built-in Advanced Chipset for Speed", textAlign: TextAlign.start),
                              ),
                              ListTile(
                                leading: Icon(Icons.check_circle, color: Colors.green),
                                title: Text("High-Definition Display for Crystal Clear Vision", textAlign: TextAlign.start),
                              ),
                            ],
                          ),
                        ).p16(),

                        10.heightBox,

                        // ✅ Highlighted Specifications Section
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.orange[50],
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.orangeAccent),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Specifications".text.bold.xl2.color(context.accentColor).make(),
                              8.heightBox,
                              ListTile(
                                leading: Icon(Icons.memory, color: Colors.blue),
                                title: Text("Processor: Snapdragon 888", textAlign: TextAlign.start),
                              ),
                              ListTile(
                                leading: Icon(Icons.storage, color: Colors.blue),
                                title: Text("Storage: 128GB SSD", textAlign: TextAlign.start),
                              ),
                              ListTile(
                                leading: Icon(Icons.battery_charging_full, color: Colors.blue),
                                title: Text("Battery: 5000mAh", textAlign: TextAlign.start),
                              ),
                            ],
                          ),
                        ).p16(),

                        // ✅ Buy Now Button with Animation
                        AnimatedBuilder(
                          animation: _scaleController,
                          builder: (context, child) {
                            return AnimatedBuilder(
                              animation: _fadeController,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _scaleAnimation.value,
                                  child: Opacity(
                                    opacity: _fadeAnimation.value,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Redirecting to payment page...")),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        shape: StadiumBorder(),
                                      ),
                                      child: "Buy Now".text.xl.white.make(),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ).py64(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




















// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/models/catalog.dart';
// import 'package:flutter_application_1/widgets/home_widgets/add_to_cart.dart';
// import 'package:velocity_x/velocity_x.dart';

// class HomeDetailsPage extends StatelessWidget {
//   final Items catalog;

//   const HomeDetailsPage({super.key, required this.catalog});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//       ),
//       backgroundColor: context.canvasColor,
//       bottomNavigationBar: Container(
//         color: context.cardColor,
//         child: 
//         OverflowBar(
//             alignment: MainAxisAlignment.spaceBetween,
//             children: [
//               "\$${catalog.price}".text.bold.xl4.red800.make(),
//               AddToCart(catalog: catalog, onPressed: (){})
//             ],
//           ).p32(),
//       ),
//         body: SafeArea(
//         bottom: false,
//         child:  Column(
//         children: [
//           Hero(
//             tag: Key(catalog.id.toString()),
//             child: Image.network(catalog.image),
            
//             ).h24(context),
//             Expanded(
//               child: VxArc(
//                 height: 30.0,
//                 arcType: VxArcType.convey,
//                 edge: VxEdge.top,
//                 child: Container(
//               color: context.cardColor,
//               width: context.screenWidth,
//               child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   catalog.name.text.bold.xl4.color(context.accentColor).make(),
//           catalog.desc.text.textStyle(context.captionStyle).xl.make(),
//           10.heightBox,
//           ElevatedButton(
//             onPressed: () {
//             },
//             child: "Buy Now".text.xl.white.make(),
//             ).w15(context).p16(),
//           "Rebum sed aliquyam lorem rebum elitr duo sit eos eos dolor, gubergren takimata gubergren takimata no invidunt, et nonumy sed justo est dolore aliquyam kasd, dolor et et ipsum magna gubergren. Stet sed ea amet est consetetur aliquyam no, takimata nonumy magna dolor aliquyam dolore, est diam rebum ea voluptua,.".text
//           .textStyle(context.captionStyle)
//           .make().p16(),
//         ]).py64(),
//               ),
//             ))),
//         ],
//       ),
//     ));
//   }
// }








