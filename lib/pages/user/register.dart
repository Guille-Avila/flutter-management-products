import 'package:appflutter/menu.dart';
import 'package:appflutter/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:appflutter/config.dart';
import 'dart:convert';
import 'dart:developer' as devtools show log;

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: const RegisterView(),
    );
  }
}

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final urlregister = Uri.http(Config.apiURL, Config.registerAPI);
  //final urlobtenertoken = Uri.parse("http://192.168.1.5:8000/api/api-token-auth/");
  final urlobtenertoken = Uri.http(Config.apiURL, Config.obtenertokenAPI);
  final headers = {"Content-Type": "application/json;charset=UTF-8"};

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
              'REGISTER',
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
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 5),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
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
                'Register',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                register();
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: TextButton(
              child: const Text(
                'Log in',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void showSnackbar(String msg) {
    final snack = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  Future<void> register() async {
    final username = emailController.text.split('@')[0];

    final newUserData = {
      "email": emailController.text,
      "password": passwordController.text,
      "username": username
    };

    final res = await http.post(urlregister,
        headers: headers, body: jsonEncode(newUserData));

    if (res.statusCode != 201) {
      showSnackbar("Ups!! ha habido un error al crear tu cuenta");
      return;
    }

    final userData = {
      "password": passwordController.text,
      "username": username
    };

    final res2 = await http.post(urlobtenertoken,
        headers: headers, body: jsonEncode(userData));

    final data2 = Map.from(jsonDecode(res2.body));

    if (res2.statusCode == 400) {
      showSnackbar("error");
      return;
    }
    if (res2.statusCode != 200) {
      showSnackbar("Ups ha habido al obtener el token ");
    }

    final token = data2["token"];
    final user = Usuario(
        username: emailController.text.split('@')[0],
        password: passwordController.text,
        token: token);

    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Menu()),
      ModalRoute.withName('/'),
    );
  }
}
