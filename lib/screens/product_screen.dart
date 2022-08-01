//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:worldlan_apps/models/product.dart';
import 'package:worldlan_apps/providers/product_form_provider.dart';
import 'package:worldlan_apps/services/services.dart';
import 'package:worldlan_apps/ui/input_decorations.dart';
import 'package:worldlan_apps/widgets/widgets.dart';

//Paquete para la camara
import 'package:image_picker/image_picker.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct),
      child: _ProductScreenBody(productService: productService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {
    //con el final de abajo se crean referencias de widget
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        //ScrollViewKeyboardDismissBehavior.onDrag  Oculta el teclado con el scroll
        //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        //Witget que mas se usa por que con el no tapa el teclado
        child: Column(
          children: [
            Stack(
              //reubica posiciones
              children: [
                ProductImage(url: productService.selectedProduct.picture),
                Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(
                        onPressed: () =>
                            Navigator.of(context).pop(), //vueleve atras
                        icon: Icon(Icons.arrow_back_ios_new,
                            size: 40, color: Colors.white))),

                //Camara funcion y Boton
                Positioned(
                    top: 60,
                    right: 20,
                    child: IconButton(
                      onPressed: () async {
                        //TODO CAMARA O GALERIA
                        //Funcion
                        final picker = new ImagePicker();
                        final PickedFile? pickedFile = await picker.getImage(
                            source: ImageSource.camera,
                            imageQuality: 50 //Para la calidad de la imagen
                            );

                        if (pickedFile == null) {
                          print("No selecciono Imagen");
                          return;
                        }

                        //pickedFile.path la propiedad me da la oportunidad de mostrar la imagen
                        productService
                            .updateSelectedProductImage(pickedFile.path);
                      }, //vueleve atras
                      icon: Icon(Icons.camera_alt_outlined,
                          size: 40, color: Colors.white),
                    )),

                //Galeria funcion y Boton
                /*Positioned(
                    top: 100,
                    right: 20,
                    child: IconButton(
                      onPressed: () async {
                        //TODO CAMARA O GALERIA
                        //Funcion
                        final picker = new ImagePicker();
                        final PickedFile? pickedFile = await picker.getImage(
                            source: ImageSource.gallery,
                            imageQuality: 90 //Para la calidad de la imagen
                            );

                        if (pickedFile == null) {
                          print("No selecciono Imagen");
                          return;
                        }

                        //pickedFile.path la propiedad me da la oportunidad de mostrar la imagen
                        productService
                            .updateSelectedProductImage(pickedFile.path);
                      }, //vueleve atras
                      icon: Icon(Icons.add_photo_alternate_outlined,
                          size: 40, color: Colors.white),
                    )),*/
              ],
            ),
            _ProductForm(),
            SizedBox(height: 100) //Sirve para que el teclado no rebase el imput
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save_outlined),
        onPressed: () async {
          // Todo: Guardar Producto  - hace un retounr
          if (!productForm.isValidForm()) return;

          final String? imageUrl = await productService.uploadImage();

          print(imageUrl);
          await productService.saveOrCreateProduct(productForm.product);
        },
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
            key: productForm.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                SizedBox(
                    height:
                        10), // Para hacer una separacion de los input o teclados

                //Caja de Texto
                TextFormField(
                    // Funcion para Ver, Mofificar **Nombre**
                    initialValue: product.name,
                    onChanged: (value) => product.name = value,
                    validator: (value) {
                      if (value == null || value.length < 1)
                        return "El Nombre es Obligatorio";
                    },
                    decoration: InputDecoration(
                        hintText: "Nombre del Producto", labelText: "Nombre:")),

                SizedBox(height: 30), // Para hacer una separacion el Sizedbox
                // Caja de Numero
                TextFormField(
                    // Funcion para Ver, Mofificar **Precio**
                    initialValue: "${product.price} ",
                    inputFormatters: [
                      //Importante revisar los decimales y puntos
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)?\.?\d{0,3}')) //2 decimales y un punto
                    ],
                    onChanged: (value) {
                      if (double.tryParse(value) == null) {
                        product.price = 0;
                      } else {
                        product.price = double.parse(value);
                      }
                    },
                    keyboardType: TextInputType
                        .number, // Para dar parametro de numero al teclado
                    decoration: InputDecoration(
                        hintText: "\$1500", labelText: "Precio:")),
                SizedBox(height: 30),

                SwitchListTile.adaptive(
                    value: product.available,
                    title: Text("Disponible"),
                    activeColor: Colors.indigo,
                    //Funcion para habilitar y desa el boton sw
                    onChanged: productForm.updateAvailability),

                SizedBox(height: 50)
              ],
            )),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]);
}
