import 'package:flutter/foundation.dart';
import 'package:appflutter/models/cliente_model.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';

class APICliente {
  static var client = http.Client();

  static Future<List<ClienteModel>?> getClientes() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.clientesAPI,
    );

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return compute(clientesFromJson, response.body);

      //return true;
    } else {
      return null;
    }
  }

  static Future<bool> saveCliente(
    ClienteModel model,
    bool isEditMode,
    bool isFileSelected,
  ) async {
    var clienteURL = "${Config.clientesAPI}/";

    if (isEditMode) {
      clienteURL = "$clienteURL${model.id.toString()}/";
    }

    var url = Uri.http(Config.apiURL, clienteURL);

    var requestMethod = isEditMode ? "PUT" : "POST";

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["nombre"] = model.nombre!;
    request.fields["apellido"] = model.apellido!;
    request.fields["email"] = model.email!;
    request.fields["phone"] = model.phone ?? "";

    if (model.foto != null && isFileSelected) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'foto',
        model.foto!,
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

  static Future<bool> deleteCliente(clienteId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, "${Config.clientesAPI}/$clienteId/");

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
