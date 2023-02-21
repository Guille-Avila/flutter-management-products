import 'dart:convert';

List<ProductoModel> productosFromJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<ProductoModel>((json) => ProductoModel.fromJson(json))
      .toList();
}

class ProductoModel {
  late int? id;
  late String? productoName;
  late String? productoDescription;
  late String? productoPrice;
  late String? productoImage;
  late int? amount;

  ProductoModel({
    this.id,
    this.productoName,
    this.productoDescription,
    this.productoPrice,
    this.productoImage,
    this.amount,
  });

  factory ProductoModel.fromJson(Map<String, dynamic> json) {
    return ProductoModel(
      id: json['id'] as int,
      productoName: json['productoName'] as String,
      productoDescription: json['productoDescription'],
      productoPrice: json['productoPrice'],
      productoImage: json['productoImage'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['productoName'] = productoName;
    data['productoDescription'] = productoDescription;
    data['productoPrice'] = productoPrice;
    data['productoImage'] = productoImage;
    data['amount'] = amount;
    return data;
  }
}
