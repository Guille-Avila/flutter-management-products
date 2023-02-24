import 'dart:convert';

List<SaleModel> salesFromJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<SaleModel>((json) => SaleModel.fromJson(json)).toList();
}

class SaleModel {
  late int? id;
  late DateTime? date;
  late double? total;
  late int? client;
  late List<int>? products;

  SaleModel({
    this.id,
    this.date,
    this.total,
    this.client,
    this.products,
  });

  factory SaleModel.fromJson(Map<String, dynamic> json) {
    return SaleModel(
      id: json['id'],
      date: DateTime.parse(json['date']),
      total: double.parse(json['total']),
      client: json['client'],
      products: List<int>.from(json['products']),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['total'] = total;
    data['client'] = client;
    data['products'] = products;
    return data;
  }
}
