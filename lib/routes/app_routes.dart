import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/screen.dart';

class AppRoutes {
  static const initialRoute = 'login';
  static Map<String, Widget Function(BuildContext)> routes = {
    'login': (BuildContext context) => const LoginScreen(),
    'list': (BuildContext context) => ListProductState(),
    'module_s': (BuildContext context) => const ModuleSelectionScreen(),
    'edit': (BuildContext context) => const EditProductScreen(),
    'add_user': (BuildContext context) => const RegisterUserScreen(),
    'category_list': (BuildContext context) => ListCategoryState(),
    'category_edit': (BuildContext context) => const EditCategoryScreen(),
    'proveedor_list': (BuildContext context) => ListProveedorState(),
    'proveedor_edit': (BuildContext context) => const EditProveedorScreen()
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const ErrorScreen(),
    );
  }
}
