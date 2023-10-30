import 'dart:convert';

class Proveedor {
  Proveedor({
    required this.listado,
  });

  List<Listado> listado;

  factory Proveedor.fromJson(String str) => Proveedor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

 factory Proveedor.fromMap(Map<String, dynamic> json) {
    print(json.toString());
    return Proveedor(
        listado:
            List<Listado>.from(json["Proveedores Listado"].map((x) => Listado.fromMap(x))),
      );
  }
  Map<String, dynamic> toMap() => {
        "Listado": List<dynamic>.from(listado.map((x) => x.toMap())),
      };
}

class Listado {
  Listado({
    required this.proveedorId,
    required this.proveedorName,
    required this.proveedorLastName,
    required this.proveedorMail,
    required this.proveedorState,
  });

  int proveedorId;
  String proveedorName;
  String proveedorLastName;
  String proveedorMail;
  String proveedorState;

  factory Listado.fromJson(String str) => Listado.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Listado.fromMap(Map<String, dynamic> json) => Listado(
        proveedorId: json["providerid"],
        proveedorName: json["provider_name"],
        proveedorLastName: json["provider_last_name"],
        proveedorMail: json["provider_mail"],
        proveedorState: json["provider_state"],
      );

  Map<String, dynamic> toMap() => {
        "providerid": proveedorId,
        "provider_name": proveedorName,
        "provider_last_name": proveedorLastName,
        "provider_mail": proveedorMail,
        "provider_state": proveedorState,
      };

  Listado copy() => Listado(
      proveedorId: proveedorId,
      proveedorName: proveedorName,
      proveedorLastName: proveedorLastName,
      proveedorMail: proveedorMail,
      proveedorState: proveedorState);
}
