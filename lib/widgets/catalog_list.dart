import 'package:flutter_application_1/models/catalog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_details_page.dart';
import 'package:flutter_application_1/widgets/home_widgets/add_to_cart.dart';
import 'package:flutter_application_1/widgets/home_widgets/catalog_image.dart';

import 'package:velocity_x/velocity_x.dart';

class CatalogList extends StatelessWidget {
  const CatalogList({super.key, required List<Items> items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: CatalogModel.items.length,
      itemBuilder: (context, index) {
        final catalog = CatalogModel.items[index];
        return InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeDetailsPage(
                          catalog: catalog,
                        ))),
            child: CatalogItems(catalog));
      },
    );
  }
}

class CatalogItems extends StatelessWidget {
  final Items catalog;
  const CatalogItems(this.catalog, {super.key});

  @override
  Widget build(BuildContext context) {
    return VxBox(
        child: Row(children: [
      Hero(
        tag: Key(catalog.id.toString()),
        child: CatalogImage(image: catalog.image),
      ),
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          catalog.name.text.bold.lg.color(context.accentColor).make(),
          catalog.desc.text.textStyle(context.captionStyle).make(),
          10.heightBox,
          OverflowBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              "\$${catalog.price}".text.bold.xl.make(),
              AddToCart(
                catalog: catalog,
                onPressed: () {},
              )
            ],
          ).pOnly(right: 28.0)
        ],
      ))
    ])).color(context.cardColor).roundedLg.square(150).make().py16();
  }
}

extension on ThemeData {}

