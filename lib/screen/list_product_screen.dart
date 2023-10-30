import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/product_service.dart';
import 'package:flutter_application_1/widgets/product_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/screen/screen.dart';

import 'package:flutter_application_1/globals.dart' as globals;

class ListProductState extends StatefulWidget {
  @override
  ListProductScreen createState() => ListProductScreen();
}

class ListProductScreen extends State<ListProductState> {

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);

    if (productService.isLoading) return LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de productos'),
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
                  hintText: 'Buscar Productos',
              ),
            ),
          ),
          // Aqui deberian ir los resultados
          Expanded(
            child: ListView.builder(
              itemCount: productService.products.length,
              itemBuilder: (BuildContext context, index) {
                if(productService.products[index].productName.toLowerCase().contains(globals.searchText.toLowerCase())) {
                   if (!globals.counts.containsKey(productService.products[index])) {
                      globals.counts[productService.products[index]] = 0;
                   }
                  return GestureDetector(
                    onTap: () {
                      print("Mueve al editor!");

                      productService.SelectProduct = productService.products[index].copy();
                      Navigator.pushNamed(context, 'edit');
                    },
                    child: Stack(
                      children: [
                      ProductCard(product: productService.products[index]),
                      FloatingActionButton(
                              heroTag: "del$index",
                              child: const Icon(Icons.delete),
                              onPressed: () {
                                productService.deleteProduct(productService.products[index], context);
                              },
                          
                        ),
                         
                      ]
                    )
                  );
                } else {
                  if (index >= productService.products.length) {
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
