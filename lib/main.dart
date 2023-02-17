import 'dart:convert';
import 'package:appflutter/pages/user/recover_password.dart';
import 'package:appflutter/pages/user/register.dart';
import 'package:appflutter/pages/user/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:appflutter/usuario.dart';
import 'package:appflutter/menu.dart';
import 'package:appflutter/pages/cliente/cliente_add_edit.dart';
import 'package:appflutter/pages/cliente/cliente_list.dart';
import 'package:appflutter/pages/producto/producto_add_edit.dart';
import 'package:appflutter/pages/producto/producto_list.dart';
import 'package:appflutter/config.dart';
import 'dart:developer' as devtools show log;
import 'package:flutter_web_plugins/url_strategy.dart';

void main() => {
      usePathUrlStrategy(),
      runApp(const MyApp()),
    };

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Control bussines';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: _title,
        initialRoute: "/",
        onGenerateRoute: (settings) {
          final Uri uri = Uri.parse(settings.name ?? '/');

          final data = uri.path;
          final pk = uri.queryParameters["pk"];
          final token = uri.queryParameters["token"];
          devtools.log(data.toString());
          devtools.log(pk.toString());
          devtools.log(token.toString());

          if (uri.path == "/restart-password/") {
            return MaterialPageRoute(
              builder: (context) => RestartPassword(
                pk: pk,
                token: token,
              ),
            );
          }
          return null;
        },
        home: const Scaffold(
          //appBar: AppBar(title: const Text(_title)),
          body: LoginView(),
        ),
        routes: {
          '/list-cliente': (context) => const ClientesList(),
          '/add-cliente': (context) => const ClienteAddEdit(),
          '/edit-cliente': (context) => const ClienteAddEdit(),
          '/list-producto': (context) => const ProductosList(),
          '/add-producto': (context) => const ProductoAddEdit(),
          '/edit-producto': (context) => const ProductoAddEdit(),
          '/home': (context) => Menu(),
          '/register': (context) => const Register(),
          '/restart-password': (context) => RestartPassword(),
        });
  }
}

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //final urllogin = Uri.parse("http://192.168.1.5:8000/api/login/");
  final urllogin = Uri.http(Config.apiURL, Config.loginAPI);
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
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 5),
            child: const Text(
              'CONTROL BUSSINES',
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
              'Log in',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10,
            ),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Name',
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
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                horizontal: 80,
                vertical: 15,
              )),
              child: const Text(
                'Acceder',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                login();
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: sort_child_properties_last
            children: [
              const Text(
                'New here?',
                style: TextStyle(fontSize: 15),
              ),
              TextButton(
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 15),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Register(),
                    ),
                  );
                },
              )
            ],
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RecoverPassword(),
                ),
              );
            },
            child: const Text(
              'Forgot your password?',
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

  Future<void> login() async {
    if (nameController.text.isEmpty || passwordController.text.isEmpty) {
      showSnackbar(
          "${nameController.text.isEmpty ? "-User " : ""} ${passwordController.text.isEmpty ? "- Contraseña " : ""} requerido");
      return;
    }

    final datosdelposibleusuario = {
      "username": nameController.text,
      "password": passwordController.text
    };

    devtools.log(datosdelposibleusuario.toString());
    final res = await http.post(urllogin,
        headers: headers, body: jsonEncode(datosdelposibleusuario));
    //final data = Map.from(jsonDecode(res.body));
    devtools.log(res.toString());
    devtools.log('Cuarta parte del login, despues de la solicitud');
    if (res.statusCode == 400) {
      showSnackbar("error");
      return;
    }
    if (res.statusCode != 200) {
      showSnackbar("Ups ha habido un al obtener usuario y contraseña ");
    }

    final res2 = await http.post(urlobtenertoken,
        headers: headers, body: jsonEncode(datosdelposibleusuario));

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
        username: nameController.text,
        password: passwordController.text,
        token: token);
    // ignore: use_build_context_synchronously
    //Navigator.push(context,MaterialPageRoute(builder: (context) => Home()),);

    // ignore: use_build_context_synchronously
    Navigator.pushNamed(
      context,
      '/home',
    );
  }
}
