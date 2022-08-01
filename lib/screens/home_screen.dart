import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:worldlan_apps/models/models.dart';
import 'package:worldlan_apps/screens/screens.dart';

import 'package:worldlan_apps/services/services.dart';
//import 'package:worldlan_apps/widgets/auth_background.dart';
import 'package:worldlan_apps/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  //HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);

    if (productsService.isLoading) return LoadingSceen();

    return Scaffold(
      appBar: AppBar(
        title: Text("Productos"),
      ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            //Condicion para seleccionar producto 2da pagina
            productsService.selectedProduct =
                productsService.products[index].copy();
            Navigator.pushNamed(context, "product");
          },
          child: ProductCard(
            product: productsService.products[index],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          productsService.selectedProduct =
              new Product(available: false, name: '', price: 0);
          Navigator.pushNamed(context, "product");
        },
      ),
    );
  }
}
