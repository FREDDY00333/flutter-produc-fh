import 'dart:io';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? url;

  const ProductImage({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        height: 450,
        child: Opacity(
          //Opacidad de la imagen
          opacity: 0.9,
          child: ClipRRect(
              //ClipRRect SIRVER PARA DAR BORDES A LO Q TENGA DENTRO
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45), topRight: Radius.circular(45)),
              child: getImage(url)),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.black, // Color de Opacidad
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 5))
          ]);

// Widget de Imagen
  Widget getImage(String? picture) {
// Si es nulo no hace nada
    if (picture == null)
      return Image(
        image: AssetImage("assets/no-image.png"),
        fit: BoxFit.cover,
      );

    // Si es un http
    if (picture.startsWith("http"))
      FadeInImage(
        image: NetworkImage(this.url!),
        placeholder: AssetImage("assets/jar-loading.gif"), // ruta de la imagen
        fit: BoxFit.cover,
      );
    // Si no cumple las funciones anteriores hace esto
    return Image.file(
      File(picture),
      fit: BoxFit.cover,
    );
  }
}
