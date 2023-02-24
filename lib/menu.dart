import 'dart:io';

import 'package:appflutter/pages/sales/sales_list.dart';
import 'package:flutter/material.dart';
import 'package:appflutter/pages/cliente/cliente_list.dart';
import 'package:appflutter/pages/producto/producto_list.dart';
import 'package:appflutter/pages/inicio/inicio.dart';

class Menu extends StatefulWidget {
  int? menuValue;
  Menu({super.key, this.menuValue});
  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {
  late int _selectDrawerItem = widget.menuValue ?? 0;

  getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return const inicio();
      case 1:
        return const ClientesList();
      case 2:
        return const ProductosList();
      case 3:
        return const SaleList();
    }
  }

  getTitle(int pos) {
    switch (pos) {
      case 0:
        return const Text("Home");
      case 1:
        return const Text("Costumers");
      case 2:
        return const Text("Products");
      case 3:
        return const Text("Sales");
    }
  }

  _onSelectItem(int pos) {
    Navigator.of(context).pop();
    setState(() {
      _selectDrawerItem = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getTitle(_selectDrawerItem),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Name Business'),
              accountEmail: Text('email_business@email.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/pngegg.png'),
              ),
            ),
            ListTile(
              title: const Text('Inicio'),
              leading: const Icon(Icons.phone),
              selected: (0 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(0);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Clientes'),
              leading: const Icon(Icons.person),
              selected: (1 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(1);
              },
            ),
            ListTile(
              title: const Text('Productos'),
              leading: const Icon(Icons.wind_power_rounded),
              selected: (2 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(2);
              },
            ),
            ListTile(
              title: const Text('Ventas'),
              leading: const Icon(Icons.production_quantity_limits),
              selected: (3 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(3);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Cerrar Sessión'),
              leading: const Icon(Icons.touch_app_outlined),
              selected: (3 == _selectDrawerItem),
              onTap: () {
                exit(0);
              },
            ),
          ],
        ),
      ),
      body: getDrawerItemWidget(_selectDrawerItem),
    );
  }
}
