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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stack & Positioned Widget"),
        centerTitle: true,
        backgroundColor: Colors.black38,
      ),
      backgroundColor: Colors.grey.shade800,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          constraints: const BoxConstraints.expand(
            width: 330,
            height: 450,
          ),
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.white24,
                  offset: Offset(0, 2),
                  spreadRadius: 5,
                  blurRadius: 10),
            ],
            image: DecorationImage(
              image: AssetImage('images/card1.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          //CHILD STACK WIDGET
          child: Stack(
            children: [
              Text("Editor's Choice",
                  style: TextStyle(color: Colors.white70, fontSize: 18)),
              Positioned(
                top: 20.0,
                child: Text("The Art of Making a Coffee",
                    style: TextStyle(color: Colors.white, fontSize: 22)),
              ),
              Positioned(
                right: 0,
                bottom: 20,
                child: Text("Learn to make the perfect Coffee",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Text("Coding with Tea",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
