import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

Widget formFields(context, productoModel) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
          top: 10,
        ),
        child: FormHelper.inputFieldWidget(
          context,
          "ProductoName",
          "Producto Name",
          (onValidateVal) {
            if (onValidateVal == null || onValidateVal.isEmpty) {
              return 'El nombre del producto no puede ser vacio o nulo';
            }

            return null;
          },
          (onSavedVal) => {
            productoModel!.productoName = onSavedVal,
          },
          initialValue: productoModel!.productoName ?? "",
          obscureText: false,
          borderFocusColor: Colors.black,
          borderColor: Colors.black,
          textColor: Colors.black,
          hintColor: Colors.black.withOpacity(0.7),
          borderRadius: 10,
          showPrefixIcon: false,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
          top: 10,
        ),
        child: FormHelper.inputFieldWidget(
          context,
          "productoDescription",
          "Product Description",
          isMultiline: true,
          maxLength: 200,
          (onValidateVal) {
            return null;
          },
          (onSavedVal) => {
            productoModel!.productoDescription = onSavedVal,
          },
          initialValue: productoModel!.productoDescription ?? "",
          obscureText: false,
          borderFocusColor: Colors.black,
          borderColor: Colors.black,
          textColor: Colors.black,
          hintColor: Colors.black.withOpacity(0.7),
          borderRadius: 10,
          showPrefixIcon: false,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
          top: 10,
        ),
        child: FormHelper.inputFieldWidget(
          context,
          "ProductoPrice",
          "Producto Price",
          (onValidateVal) {
            if (onValidateVal == null || onValidateVal.isEmpty) {
              return 'El precio no puede ser vacio o null ';
            }
            if (double.tryParse(onValidateVal) == null) {
              return 'Insertar un numero valido con dos decimales ';
            }

            return null;
          },
          (onSavedVal) => {
            productoModel!.productoPrice = onSavedVal,
          },
          initialValue: productoModel!.productoPrice == null
              ? ""
              : productoModel!.productoPrice.toString(),
          obscureText: false,
          borderFocusColor: Colors.black,
          borderColor: Colors.black,
          textColor: Colors.black,
          hintColor: Colors.black.withOpacity(0.7),
          borderRadius: 10,
          showPrefixIcon: false,
          suffixIcon: const Icon(Icons.monetization_on),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
          top: 10,
        ),
        child: FormHelper.inputFieldWidget(
          context,
          "Amount",
          "Amount",
          isNumeric: true,
          (onValidateVal) {
            return null;
          },
          (onSavedVal) => {
            productoModel!.amount = int.parse(onSavedVal),
          },
          initialValue: (productoModel!.amount ?? 1).toString(),
          obscureText: false,
          borderFocusColor: Colors.black,
          borderColor: Colors.black,
          textColor: Colors.black,
          hintColor: Colors.black.withOpacity(0.7),
          borderRadius: 10,
          showPrefixIcon: false,
          suffixIcon: const Icon(Icons.add_box),
        ),
      ),
    ],
  );
}
