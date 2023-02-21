import 'dart:io';
import 'package:appflutter/pages/producto/pick_picker.dart';
import 'package:appflutter/pages/producto/producto_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:appflutter/models/producto_model.dart';
import 'package:appflutter/services/api_producto.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import '../../config.dart';
import '../../menu.dart';

class ProductoAddEdit extends StatefulWidget {
  const ProductoAddEdit({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProductoAddEditState createState() => _ProductoAddEditState();
}

class _ProductoAddEditState extends State<ProductoAddEdit> {
  ProductoModel? productoModel;
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  List<Object> images = [];
  bool isEditMode = false;
  bool isImageSelected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Form Producto'),
          elevation: 0,
        ),
        backgroundColor: Colors.grey[200],
        body: ProgressHUD(
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
          child: Form(
            key: globalFormKey,
            child: productoForm(),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    productoModel = ProductoModel();

    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
        productoModel = arguments['model'];
        isEditMode = true;
        setState(() {});
      }
    });
  }

  Widget productoForm() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          formFields(context, productoModel),
          picPicker(
            isImageSelected,
            productoModel!.productoImage ?? "",
            (file) => {
              setState(
                () {
                  productoModel!.productoImage = file.path;
                  isImageSelected = true;
                },
              )
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Save",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isApiCallProcess = true;
                  });

                  APIProducto.saveProducto(
                    productoModel!,
                    isEditMode,
                    isImageSelected,
                  ).then(
                    (response) {
                      setState(() {
                        isApiCallProcess = false;
                      });

                      if (response) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => Menu(
                              menuValue: 2,
                            ),
                          ),
                          (route) => false,
                        );
                      } else {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          Config.appName,
                          "Error occur",
                          "OK",
                          () {
                            Navigator.of(context).pop();
                          },
                        );
                      }
                    },
                  );
                }
              },
              btnColor: HexColor("283B71"),
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 10,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  isValidURL(url) {
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }
}
