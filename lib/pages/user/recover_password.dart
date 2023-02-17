import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:appflutter/config.dart';
import 'dart:convert';
import 'dart:developer' as devtools show log;

import '../../main.dart';

class RecoverPassword extends StatelessWidget {
  const RecoverPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forgot your password?")),
      body: const RecoverPasswordView(),
    );
  }
}

class RecoverPasswordView extends StatefulWidget {
  const RecoverPasswordView({super.key});

  @override
  State<RecoverPasswordView> createState() => _RecoverPasswordViewState();
}

class _RecoverPasswordViewState extends State<RecoverPasswordView> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: const Text(
              'ENTER YOUR EMAIL',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 28),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              "We'll send you a message to reset your password",
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10,
            ),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                horizontal: 80,
                vertical: 15,
              )),
              child: const Text(
                'Send email',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                sendEmail();
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> sendEmail() async {
    final email = {"email": emailController.text};
    final headers = {"Content-Type": "application/json;charset=UTF-8"};
    final urlcheckEmail = Uri.http(Config.apiURL, Config.emailPasswordAPI);

    // verificar que el email existe en la base de datos y envia correo
    final res = await http.post(
      urlcheckEmail,
      headers: headers,
      body: jsonEncode(email),
    );

    devtools.log(res.statusCode.toString());

    if (res.statusCode != 200) {
      throw Exception("error");
    }

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
}
