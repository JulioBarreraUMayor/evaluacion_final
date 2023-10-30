import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/proveedor.dart';

class ProveedorFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  Listado proveedor;
  ProveedorFormProvider(this.proveedor);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
