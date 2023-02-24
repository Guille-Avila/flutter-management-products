import 'package:flutter/material.dart';
import '../../models/sales_model.dart';

class SaleItem extends StatelessWidget {
  final SaleModel? model;
  final Function? onDelete;

  // ignore: prefer_const_constructors_in_immutables
  SaleItem({
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
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: cardItem(context),
      ),
    );
  }

  Widget cardItem(context) {
    String price = double.parse(model!.total!.toString())
        .toStringAsFixed(0)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]},',
        );
    return Padding(
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
              "Id Number: ${model!.id!.toString()}",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {},
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
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete costumer"),
          content: Text("Are you sure to delete sale ${model!.id}?"),
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
