import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';
import '../models/detail_sale_model.dart';

class APIDetailSale {
  static var client = http.Client();

  static Future<List<DetailSaleModel>?> getProductos() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.detailSaleAPI,
    );

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return compute(productosFromJson, response.body);
    } else {
      return null;
    }
  }

  static Future<bool> saveProducto(
    DetailSaleModel model,
    bool isEditMode,
    bool isFileSelected,
  ) async {
    var detailSaleURL = "${Config.detailSaleAPI}/";

    if (isEditMode) {
      detailSaleURL = "$detailSaleURL${model.id.toString()}/";
    }

    var url = Uri.http(Config.apiURL, detailSaleURL);
    var requestMethod = isEditMode ? "PUT" : "POST";
    var request = http.MultipartRequest(requestMethod, url);

    request.fields["productId"] = model.productId.toString();
    request.fields["saleId"] = model.saleId.toString();
    request.fields["amount"] = model.amount.toString();
    request.fields["priceUnit"] = model.priceUnit.toString();

    var response = await request.send();

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteProducto(detailSaleId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, "${Config.detailSaleAPI}/$detailSaleId/");

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
