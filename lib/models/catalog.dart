// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CatalogModel {
  static List<Items> items = [];

  // get item by ID
  getById(int id) =>
      items.firstWhere((element) => element.id == id, orElse: null);

  // get item by position
  getByPosition(int pos) => items[pos];
}

class Items {
  final int id;
  final String name;
  final String desc;
  final num price;
  final String color;
  final String image;
  final bool isAvailable; 

  Items({
    required this.id,
    required this.name,
    required this.desc,
    required this.price,
    required this.color,
    required this.image,
    required this.isAvailable,
  });

  Items copyWith({
    int? id,
    String? name,
    String? desc,
    num? price,
    String? color,
    String? image,
  }) {
    return Items(
      id: id ?? this.id,
      name: name ?? this.name,
      desc: desc ?? this.desc,
      price: price ?? this.price,
      color: color ?? this.color,
      image: image ?? this.image,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'desc': desc,
      'price': price,
      'color': color,
      'image': image,
    };
  }

  factory Items.fromMap(Map<String, dynamic> map) {
    return Items(
      id: map['id'] as int,
      name: map['name'] as String,
      desc: map['desc'] as String,
      price: map['price'] as num,
      color: map['color'] as String,
      image: map['image'] as String,
      isAvailable: map['isAvailable'] ?? true,
    );
  }

  String toJson() => json.encode(toMap());

  factory Items.fromJson(String source) =>
      Items.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Items(id: $id, name: $name, desc: $desc, price: $price, color: $color, image: $image)';
  }

  @override
  bool operator ==(covariant Items other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.desc == desc &&
        other.price == price &&
        other.color == color &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        desc.hashCode ^
        price.hashCode ^
        color.hashCode ^
        image.hashCode;
  }
}
 // Factory constructor to create an instance from a Map
  // factory Items.fromMap(Map<String, dynamic> map) {
  //   return Items(
  //     id: map["id"],
  //     name: map["name"],
  //     desc: map["desc"],
  //     price: map["price"],
  //     color: map["color"],
  //     image: map["image"],
  //   );
  // }

  // // Convert the object to a Map
  // Map<String, dynamic> toMap() => {
  //       "id": id,
  //       "name": name,
  //       "desc": desc,
  //       "price": price,
  //       "color": color,
  //       "image": image,
  //     };

