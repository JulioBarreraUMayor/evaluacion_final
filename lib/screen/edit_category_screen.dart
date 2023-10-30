import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/category_form_provider.dart';
import 'package:flutter_application_1/services/category_service.dart';
import 'package:flutter_application_1/widgets/product_image.dart';
import 'package:provider/provider.dart';

import '../ui/input_decorations.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    return ChangeNotifierProvider(
        create: (_) => CategoryFormProvider(categoryService.SelectCategory!),
        child: _CategoryScreenBody(
          categoryService: categoryService,
        ));
  }
}

class _CategoryScreenBody extends StatelessWidget {
  const _CategoryScreenBody({
    Key? key,
    required this.categoryService,
  }) : super(key: key);

  final CategoryService categoryService;
  @override
  Widget build(BuildContext context) {
    final categoryForm = Provider.of<CategoryFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          _CategoryForm(), /// AQUI ES DONDE VA LA FORMA
        ]),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "delete_pc",
            child: const Icon(Icons.delete_forever),
            onPressed: () async {
              if (!categoryForm.isValidForm()) return;
              await categoryService.deleteCategory(categoryForm.category, context);
            },
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            heroTag: "save_pc",
            child: const Icon(Icons.save_alt_outlined),
            onPressed: () async {
              if (!categoryForm.isValidForm()) return;
              await categoryService.editOrCreateCategory(categoryForm.category);
            },
          ),
          SizedBox(width: 20.0),
          FloatingActionButton(
            heroTag: "return_c",
            child: const Icon(Icons.reset_tv_rounded),
            onPressed: () => Navigator.of(context).pop(), /// No pude conectar la flecha superior a la pantall de seleccion, así que esto sirve.,
        
          ),
        ],
      ),
    );
  }
}

class _CategoryForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryForm = Provider.of<CategoryFormProvider>(context);
    final category = categoryForm.category;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: _createDecoration(),
        child: Form(
          key: categoryForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                initialValue: category.categoryName,
                onChanged: (value) => category.categoryName = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'El nombre es obligatorio';
                },
                decoration: InputDecortions.authInputDecoration(
                  hinText: 'Nombre de la Categoria',
                  labelText: 'Nombre',
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _createDecoration() => const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 5),
              blurRadius: 10,
            )
          ]);
}
