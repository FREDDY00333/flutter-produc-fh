import 'package:flutter/material.dart';
import 'package:worldlan_apps/models/models.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
          margin: EdgeInsets.only(top: 30, bottom: 50),
          width: double.infinity,
          height: 400,
          decoration: _cardBorders(),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              _BackgroundImage(product.picture),
              _ProductDetails(
                title: product.name,
                subTitle:
                    product.id!, // Con el ! confirmas que siempre hay products
              ),
              Positioned(
                  top: 0, right: 0, child: _PriceTag(product.price)), //etiqueta
              if (!product
                  .available) //Condicion para mostar Disponible o no Disponible
                Positioned(
                    top: 0,
                    left: 0,
                    child:
                        _NotAvailable()), //TODO muestra de manera condicional
            ],
          )),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 7), blurRadius: 10)
          ]);
}

class _NotAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain, //se adapta el texto a la imagen
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text("No Disponible",
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ),
      width: 100,
      height: 70,
      decoration: BoxDecoration(
          color: Colors.yellow[800],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
    );
  }
}

class _PriceTag extends StatelessWidget {
  // Precio de Product
  final double price; //se crea un constructor propiedad final con control .

  const _PriceTag(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain, //se adapta el texto a la imagen
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
              "\$$price", //el  \ es para saltar y tiene doble $$ porque para tomarlo como variable y el otro por el txt
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
      ),
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
      ),
    );
  }
}

//_productDetails()  Margen superior de tarjeta
class _ProductDetails extends StatelessWidget {
  final String title;
  final String subTitle;
// contructor con las variable control  .
  const _ProductDetails({required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 50),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          height: 70,
          decoration: _buildBoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title, // Titulo de Producto
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                subTitle, // Sub Titulo del producto
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          )),
    );
  }

//Borde de cuadro
  BoxDecoration _buildBoxDecoration() => BoxDecoration(
      color: Colors.greenAccent,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25), topRight: Radius.circular(25)));
}

class _BackgroundImage extends StatelessWidget {
  final String? url;
  const _BackgroundImage(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
          width: double.infinity,
          height: 400,
          child: url == null
              ? //condicional para cuando no tiene imagen
              Image(
                  image: AssetImage("assets/no-image.png"),
                  fit: BoxFit.cover,
                )
              : FadeInImage(
                  // TODO Productos cuando  cuando no hay imagen

                  placeholder: AssetImage(
                      "assets/jar-loading.gif"), // Ruta de imagenes de carga
                  image: NetworkImage(url!),
                  fit: BoxFit.cover,
                )),
    );
  }
}
