import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/proveedor_service.dart';
import 'package:flutter_application_1/widgets/proveedor_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/screen/screen.dart';

import 'package:flutter_application_1/globals.dart' as globals;

class ListProveedorState extends StatefulWidget {
  const ListProveedorState({super.key});
  
  @override
  ListProveedorScreen createState() => ListProveedorScreen();
}

class ListProveedorScreen extends State<ListProveedorState> {

  @override
  Widget build(BuildContext context) {
    final proveedorService = Provider.of<ProveedorService>(context);

    if (proveedorService.isLoading) return LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Proveedores'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: TextFormField(
              initialValue: globals.searchText,
              onChanged: (text) {
                setState(() {
                   globals.searchText = text;
                });
                  print("Texto actual: " + globals.searchText);
              },
              decoration: InputDecoration(
                  hintText: 'Buscar Categorias',
              ),
            ),
          ),
          // Aqui deberian ir los resultados
          Expanded(
            child: ListView.builder(
              itemCount: proveedorService.proveedores.length,
              itemBuilder: (BuildContext context, index) {

                /// RECUERDA REINICIAR SEARCHTEXT CUANDO SALTES DE PANTALLA
                // 27/10/2023 : Cumplido.
                if(proveedorService.proveedores[index].proveedorName.toLowerCase().contains(globals.searchText.toLowerCase())) {
                  return GestureDetector(
                    onTap: () {
                      print("Mueve al editor!");

                      proveedorService.SelectProveedor = proveedorService.proveedores[index].copy();
                      
                      Navigator.pushNamed(context, 'proveedor_edit'); // Cambia esto a la pantalla de edicion de categorias
                    },
                    child: Stack(
                      children: [
                      ProveedorCard(proveedor: proveedorService.proveedores[index]), // RECUERDA CAMBIAR ESTO PARA LISTAR LA CATEGORIA
                      FloatingActionButton(
                              heroTag: "del_p$index",
                              child: const Icon(Icons.delete),
                              onPressed: () {
                                proveedorService.deleteProveedor(proveedorService.proveedores[index], context);
                              },
                          
                        ),
                         
                      ]
                    )
                  );
                } else {
                  if (index >= proveedorService.proveedores.length) {
                    // Aquí no se da ningun resultado
                    return Center(child: Text("0 Resultados"));
                  } else {
                    return Container();
                  }
                }
              }
            ),
          ),
        ],
      ),
    );
  }
}
