import 'package:appflutter/pages/producto/product_individual_data.dart';
import 'package:flutter/material.dart';
import '../../models/producto_model.dart';

class ProductoItem extends StatelessWidget {
  final ProductoModel? model;
  final Function? onDelete;

  // ignore: prefer_const_constructors_in_immutables
  ProductoItem({
    Key? key,
    this.model,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: cartItem(context),
      ),
    );
  }

  Widget cartItem(context) {
    String price =
        double.parse(model!.productoPrice!).toStringAsFixed(0).replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
              (Match match) => '${match[1]},',
            );
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 110,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10),
          child: GestureDetector(
            child: Image.network(
              (model!.productoImage == null || model!.productoImage == "")
                  ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
                  : model!.productoImage!,
              height: 80,
              fit: BoxFit.scaleDown,
            ),
            onTap: () {
              //individual data view client
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductIndividualData(model!)),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                child: Text(
                  model!.productoName!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  //individual data view client
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductIndividualData(model!)),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "\$ $price",
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 180,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: const Icon(Icons.edit),
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          '/edit-producto',
                          arguments: {
                            'model': model,
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onTap: () {
                        _showAlert(context);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete costumer"),
          content: Text("Are you sure to delete ${model!.productoName}?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                onDelete!(model);
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
