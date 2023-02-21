// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:appflutter/models/cliente_model.dart';

class ClienteIndividualData extends StatefulWidget {
  ClienteModel model;
  ClienteIndividualData(
    this.model, {
    Key? key,
  }) : super(key: key);

  @override
  State<ClienteIndividualData> createState() => _ClienteIndividualDataState();
}

class _ClienteIndividualDataState extends State<ClienteIndividualData> {
  ClienteModel? costumer;

  @override
  void initState() {
    super.initState();
    costumer = widget.model;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Costumer"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.90,
          height: MediaQuery.of(context).size.width * 1.5,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 3))
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 15),
                width: 500,
                alignment: Alignment.center,
                margin: const EdgeInsets.all(10),
                child: Image.network(
                  costumer?.foto ??
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
                  height: 200,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Text(
                "${costumer!.nombre?.toUpperCase()} ${costumer!.apellido?.toUpperCase()}",
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "${costumer!.email}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        '/edit-cliente',
                        arguments: {
                          'model': costumer,
                        },
                      );
                    },
                    child: const Text(
                      "Edit",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      backgroundColor: Color.fromARGB(255, 243, 97, 87),
                    ),
                    onPressed: () {
                      _showAlert(context);
                    },
                    child: const Text(
                      "Delete",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Costumers",
                      style: TextStyle(fontSize: 16),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete costumer"),
          content: Text("Are you sure to delete ${costumer!.nombre}?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                //onDelete!(costumer);

                Navigator.pop(context);
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}
