import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';
import '../models/sales_model.dart';

class APISale {
  static var client = http.Client();

  static Future<List<SaleModel>?> getSales() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.saleAPI,
    );

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return compute(salesFromJson, response.body);
    } else {
      return null;
    }
  }

  static Future<bool> saveSale(
    SaleModel model,
    bool isEditMode,
    bool isFileSelected,
  ) async {
    var saleURL = "${Config.saleAPI}/";

    if (isEditMode) {
      saleURL = "$saleURL${model.id.toString()}/";
    }

    var url = Uri.http(Config.apiURL, saleURL);

    var requestMethod = isEditMode ? "PUT" : "POST";

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["date"] = model.date.toString();
    request.fields["total"] = model.total.toString();
    request.fields["clientId"] = model.client.toString();
    request.fields["productsIds"] = model.products.toString();

    var response = await request.send();

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteSale(saleId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, "${Config.saleAPI}/$saleId/");

    var response = await client.delete(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  }
}
