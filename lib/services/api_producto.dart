import 'package:flutter/foundation.dart';
import 'package:appflutter/models/producto_model.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';

class APIProducto {
  static var client = http.Client();

  static Future<List<ProductoModel>?> getProductos() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.productosAPI,
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
    ProductoModel model,
    bool isEditMode,
    bool isFileSelected,
  ) async {
    var productURL = "${Config.productosAPI}/";

    if (isEditMode) {
      productURL = "$productURL${model.id.toString()}/";
    }

    var url = Uri.http(Config.apiURL, productURL);

    var requestMethod = isEditMode ? "PUT" : "POST";

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["productoName"] = model.productoName!;
    request.fields["productoDescription"] = model.productoDescription!;
    request.fields["productoPrice"] =
        double.parse(model.productoPrice!).toStringAsFixed(2);
    request.fields["amount"] = model.amount.toString();

    if (model.productoImage != null && isFileSelected) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'productoImage',
        model.productoImage!,
      );

      request.files.add(multipartFile);
    }

    var response = await request.send();

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteProducto(productId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, "${Config.productosAPI}/$productId/");

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
