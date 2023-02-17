import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:appflutter/config.dart';
import 'dart:convert';
import 'dart:developer' as devtools show log;

import '../../main.dart';

// ignore: must_be_immutable
class RestartPassword extends StatelessWidget {
  String? pk;
  String? token;
  RestartPassword({
    super.key,
    this.pk,
    this.token,
  });
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restart your password'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: const Text(
                'Create your new password',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 28),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'New Password',
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
                  'Set password',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  resetPassword(context, pk, token);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> resetPassword(context, pk, token) async {
    final password = passwordController.text;
    final headers = {"Content-Type": "application/json;charset=UTF-8"};
    final urlresetPassword =
        Uri.http(Config.apiURL, "${Config.resetPasswordAPI}$pk/$token/");

    // change password
    final res = await http.patch(
      urlresetPassword,
      headers: headers,
      body: jsonEncode({"password": password}),
    );

    if (res.statusCode != 200) {
      throw Exception("error");
    }

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MyApp()),
      (route) => false,
    );
  }
}
