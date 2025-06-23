import 'package:flutter_application_1/core/store.dart';
import 'package:flutter_application_1/models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';

class CartModel {
  static CartModel cartModel = CartModel();
  // Catalog field (initialized to avoid null error)
  CatalogModel _catalog = CatalogModel();

  // Collection of Ids (stores item ids)
  final List<int> _itemIds = [];

  // Get catalog
  CatalogModel get catalog => _catalog;

  // Set catalog safely
  set catalog(CatalogModel newCatalog) {
    _catalog = newCatalog;
  }

  // Get items in the cart
  List<Items> get items =>
      _itemIds.map((id) => _catalog.getById(id)).whereType<Items>().toList();

  // Get total price
  num get totalPrice =>
      items.fold(0, (total, current) => total + (current.price ?? 0));

  // Add item
  void add(Items item) {
    if (!_itemIds.contains(item.id)) {
      _itemIds.add(item.id);
    }
  }

  void remove(Items item) {}


}

class AddMutation extends VxMutation<MyStore> {
  final Items item;
  AddMutation(this.item);

  @override
  perform() {
    store!.cart._itemIds.add(item.id);
    store!.dispatch(() {});

  }
}


class RemoveMutation extends VxMutation<MyStore> {
  final Items item;

  RemoveMutation(this.item);

  @override
  perform() {
  store!.cart._itemIds.remove(item.id);
  store!.dispatch(() {});
  }
}