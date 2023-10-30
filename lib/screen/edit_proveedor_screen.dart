import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/proveedor_form_provider.dart';
import 'package:flutter_application_1/services/proveedor_service.dart';
import 'package:provider/provider.dart';

import '../ui/input_decorations.dart';

class EditProveedorScreen extends StatelessWidget {
  const EditProveedorScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final proveedorService = Provider.of<ProveedorService>(context);
    return ChangeNotifierProvider(
        create: (_) => ProveedorFormProvider(proveedorService.SelectProveedor!),
        child: _ProveedorScreenBody(
          proveedorService: proveedorService,
        ));
  }
}

class _ProveedorScreenBody extends StatelessWidget {
  const _ProveedorScreenBody({
    Key? key,
    required this.proveedorService,
  }) : super(key: key);

  final ProveedorService proveedorService;
  @override
  Widget build(BuildContext context) {
    final proveedorForm = Provider.of<ProveedorFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          _ProveedorForm(), /// AQUI ES DONDE VA LA FORMA
        ]),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "delete_pp",
            child: const Icon(Icons.delete_forever),
            onPressed: () async {
              if (!proveedorForm.isValidForm()) return;
              await proveedorService.deleteProveedor(proveedorForm.proveedor, context);
            },
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            heroTag: "save_pp",
            child: const Icon(Icons.save_alt_outlined),
            onPressed: () async {
              if (!proveedorForm.isValidForm()) return;
              await proveedorService.editOrCreateProveedor(proveedorForm.proveedor);
            },
          ),
          SizedBox(width: 20.0),
          FloatingActionButton(
            heroTag: "return_p",
            child: const Icon(Icons.reset_tv_rounded),
            onPressed: () => Navigator.of(context).pop(), /// No pude conectar la flecha superior a la pantall de seleccion, así que esto sirve.,
        
          ),
        ],
      ),
    );
  }
}

class _ProveedorForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final proveedorForm = Provider.of<ProveedorFormProvider>(context);
    final proveedor = proveedorForm.proveedor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: _createDecoration(),
        child: Form(
          key: proveedorForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                initialValue: proveedor.proveedorName,
                onChanged: (value) => proveedor.proveedorName = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'El nombre es obligatorio';
                },
                decoration: InputDecortions.authInputDecoration(
                  hinText: 'Nombre del Proveedor',
                  labelText: 'Nombre',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: proveedor.proveedorLastName,
                onChanged: (value) => proveedor.proveedorLastName = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'El apellido es obligatorio';
                },
                decoration: InputDecortions.authInputDecoration(
                  hinText: 'Apellido del Proveedor',
                  labelText: 'Apellido',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: proveedor.proveedorMail,
                onChanged: (value) => proveedor.proveedorMail = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'El e-mail es obligatorio';
                },
                decoration: InputDecortions.authInputDecoration(
                  hinText: 'E-Mail del Proveedor',
                  labelText: 'E-Mail',
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
