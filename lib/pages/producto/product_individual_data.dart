import 'package:appflutter/models/producto_model.dart';
import 'package:appflutter/services/api_producto.dart';
import 'package:flutter/material.dart';

import '../../menu.dart';

class ProductIndividualData extends StatefulWidget {
  ProductoModel model;
  ProductIndividualData(
    this.model, {
    Key? key,
  }) : super(key: key);

  @override
  State<ProductIndividualData> createState() => _ProductIndividualDataState();
}

class _ProductIndividualDataState extends State<ProductIndividualData> {
  ProductoModel? product;

  @override
  void initState() {
    super.initState();
    product = widget.model;
  }

  @override
  Widget build(BuildContext context) {
    String price = double.parse(product!.productoPrice!)
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]},',
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.90,
          height: MediaQuery.of(context).size.width * 1.5,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
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
                  product?.productoImage ??
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
                  height: 200,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Text(
                "${product!.productoName?.toUpperCase()}",
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "${product!.productoDescription}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "\$ $price",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "${product!.amount} ${product!.amount! > 1 ? 'Unidades' : 'Unidad'}",
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
                        '/edit-producto',
                        arguments: {
                          'model': product,
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
                      "Products",
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
          title: const Text("Delete product"),
          content: Text("Are you sure to delete ${product!.productoName}?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () async {
                final delete = await APIProducto.deleteProducto(product!.id);

                if (delete) {
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => Menu(
                        menuValue: 2,
                      ),
                    ),
                    (route) => false,
                  );
                }
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }
}
