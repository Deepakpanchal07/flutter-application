import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CatalogHeader extends StatelessWidget {
  const CatalogHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0), // Space around
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Center alignment for both titles
        children: [
          // Catalog App title
          Center(
            child: "Catalog App"
                .text
                .xl4
                .bold
                .uppercase
                .letterSpacing(2) // Add letter spacing for effect
                .color(Colors.deepPurple) // Darker color for better visibility
                .make(),
          )
              // .shimmer(primaryColor: Colors.white, secondaryColor: Colors.blueAccent) // Add shimmer effect

          ,SizedBox(height: 10), // Add more space between the titles

          // Trending Products title
          Center(
            child: "Trending Products"
                .text
                .xl2
                .italic
                .color(Colors.grey[700]) // Lighter color for a subtle effect
                .fontWeight(FontWeight.w500) // Slightly lighter font weight
                .make(),
          )
              // .shimmer(primaryColor: Colors.white, secondaryColor: Colors.orangeAccent) // Shimmer effect
        ],
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:velocity_x/velocity_x.dart';

// class CatalogHeader extends StatelessWidget {
//   const CatalogHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       Center(
//           child: "Catalog App"
//               .text
//               .xl5
//               .bold
//               .center
//               .color(context.accentColor)
//               .make()),
//       Center(child: "Trending Products".text.xl2.make())
//     ]);
//   }
// }
