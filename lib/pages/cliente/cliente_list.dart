import 'package:flutter/material.dart';
import 'package:appflutter/models/cliente_model.dart';
import 'package:appflutter/pages/cliente/cliente_item.dart';
import 'package:appflutter/services/api_cliente.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import 'cliente_add_edit.dart';

class ClientesList extends StatefulWidget {
  const ClientesList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ClientesListState createState() => _ClientesListState();
}

class _ClientesListState extends State<ClientesList> {
  bool isApiCallProcess = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
        child: loadClientes(),
      ),
    );
  }

  Widget loadClientes() {
    return FutureBuilder(
      future: APICliente.getClientes(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<ClienteModel>?> model,
      ) {
        if (model.hasData) {
          return clienteList(model.data);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget clienteList(clientes) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ClienteAddEdit()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                child: const Text(
                  'Add Client',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: clientes.length,
                itemBuilder: (context, index) {
                  return ClienteItem(
                    model: clientes[index],
                    onDelete: (ClienteModel model) {
                      setState(() {
                        isApiCallProcess = true;
                      });

                      APICliente.deleteCliente(model.id).then(
                        (response) {
                          setState(() {
                            isApiCallProcess = false;
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
