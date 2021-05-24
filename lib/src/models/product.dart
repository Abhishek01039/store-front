import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Product extends Equatable {
  String? prodId;
  String customerId;
  String title;
  num? price;
  String? desc;
  String status;
  int? inventory;
  bool isInventory;
  String? category;
  List<dynamic>? image;

  Product({
    required this.title,
    required this.customerId,
    this.prodId,
    this.price,
    this.desc,
    this.status = 'Disabled',
    this.inventory,
    this.isInventory = false,
    this.category,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      prodId: json['prodId'] as String,
      customerId: json['customerId'] as String,
      title: json['title'] as String,
      price: json['price'] as num,
      desc: json['desc'] as String,
      status: json['status'] as String,
      inventory: json['inventory'] as int,
      isInventory: json['isInventory'] as bool,
      category: json['category'] as String,
      image: json['image'] as List<dynamic>,
    );
  }

  Map<String, dynamic> toJson() => {
        'prodId': prodId,
        'title': title,
        'price': price,
        'desc': desc,
        'status': status,
        'inventory': inventory,
        'isInventory': isInventory,
        'category': category,
        'image': image,
        'customerId': customerId,
      };

  Product copyWith({
    String? prodId,
    String? customerId,
    String? title,
    num? price,
    String? desc,
    String? status,
    int? inventory,
    bool? isInventory,
    String? category,
    List<dynamic>? image,
  }) {
    return Product(
      prodId: prodId ?? this.prodId,
      customerId: customerId ?? this.customerId,
      title: title ?? this.title,
      price: price ?? this.price,
      desc: desc ?? this.desc,
      status: status ?? this.status,
      inventory: inventory ?? this.inventory,
      isInventory: isInventory ?? false,
      category: category ?? this.category,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [
        title,
        price,
        desc,
        status,
        inventory,
        isInventory,
        category,
        image,
      ];
}
