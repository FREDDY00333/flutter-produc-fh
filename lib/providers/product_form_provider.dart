import 'package:flutter/material.dart';
import 'package:worldlan_apps/models/models.dart';

// Metodo 2 Provider  - de ingreso
class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  Product product;

  ProductFormProvider(this.product);

  // Funcion para sw boton activado y desactivado
  updateAvailability(bool value) {
    print(value);
    this.product.available = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(product.name);
    print(product.price);
    print(product.available);
    return formKey.currentState?.validate() ?? false;
  }
}
