import 'package:flutter/material.dart';
import 'package:flutter_application_1/globals.dart' as globals;

class ModuleSelectionScreen extends StatelessWidget {
  const ModuleSelectionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar Modulo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Selecionar Modulo',
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold, 
              ),
            ),
            SizedBox(height: 50), 
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'list');
              },
              child: Text('Módulo Producto'),
            ),
            SizedBox(height: 50), 
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'proveedor_list');
              },
              child: Text('Módulo Proveedores'),
            ),
            SizedBox(height: 50), 
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'category_list');
              },
              child: Text('Módulo Categorias'),
            ),
          ],
        ),
      ),
    );
  }
}