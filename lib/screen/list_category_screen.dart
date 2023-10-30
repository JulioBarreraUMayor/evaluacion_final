import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/category_service.dart';
import 'package:flutter_application_1/widgets/category_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/screen/screen.dart';

import 'package:flutter_application_1/globals.dart' as globals;

class ListCategoryState extends StatefulWidget {
  const ListCategoryState({super.key});
  
  @override
  ListCategoryScreen createState() => ListCategoryScreen();
}

class ListCategoryScreen extends State<ListCategoryState> {

  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);

    if (categoryService.isLoading) return LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de categorias'),
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
              itemCount: categoryService.categories.length,
              itemBuilder: (BuildContext context, index) {

                /// RECUERDA REINICIAR SEARCHTEXT CUANDO SALTES DE PANTALLA
                // 27/10/2023 : Cumplido.
                if(categoryService.categories[index].categoryName.toLowerCase().contains(globals.searchText.toLowerCase())) {
                  return GestureDetector(
                    onTap: () {
                      print("Mueve al editor!");

                      categoryService.SelectCategory = categoryService.categories[index].copy();
                      
                      Navigator.pushNamed(context, 'category_edit'); // Cambia esto a la pantalla de edicion de categorias
                    },
                    child: Stack(
                      children: [
                      CategoryCard(category: categoryService.categories[index]), // RECUERDA CAMBIAR ESTO PARA LISTAR LA CATEGORIA
                      FloatingActionButton(
                              heroTag: "del_c$index",
                              child: const Icon(Icons.delete),
                              onPressed: () {
                                categoryService.deleteCategory(categoryService.categories[index], context);
                              },
                          
                        ),
                         
                      ]
                    )
                  );
                } else {
                  if (index >= categoryService.categories.length) {
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
