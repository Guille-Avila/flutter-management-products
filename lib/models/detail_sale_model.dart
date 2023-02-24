// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

List<DetailSaleModel> productosFromJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<DetailSaleModel>((json) => DetailSaleModel.fromJson(json))
      .toList();
}

class DetailSaleModel {
  late int? id;
  late int? productId;
  late int? saleId;
  late int? amount;
  late double? priceUnit;

  DetailSaleModel({
    this.id,
    this.productId,
    this.saleId,
    this.amount,
    this.priceUnit,
  });

  factory DetailSaleModel.fromJson(Map<String, dynamic> json) {
    return DetailSaleModel(
      id: json['id'],
      productId: json['productId'],
      saleId: json['saleId'],
      amount: json['amount'],
      priceUnit: json['priceUnit'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['productId'] = productId;
    data['saleId'] = saleId;
    data['amount'] = amount;
    data['priceUnit'] = priceUnit;
    return data;
  }
}
