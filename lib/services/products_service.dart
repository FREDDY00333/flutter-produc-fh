// Acceso a la nube de Firebase

import 'dart:convert';
//import 'dart:html';
//importacion de Galeria y Camra
import 'dart:io';
//import 'dart:html';
import 'package:flutter/material.dart';

import 'package:worldlan_apps/models/product.dart';

import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-42112-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  // TODO HACER FETCH DE PRODUCTOS ------- Puedo agregar productos
  late Product selectedProduct;
  //Todo sobre GALERIA Y CAMARA
  File? newPictureFile;

  bool isLoading = true;
  bool isSaving = false;

  ProductsService() {
    this.loadProducts();
  }

  //Todo
  Future<List<Product>> loadProducts() async {
    this.isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, "products.json");
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);
    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      this.products.add(tempProduct);
    });

    this.isLoading = false;
    notifyListeners();
    return this.products;
  }

//Funcion para crea, actualizar o guardar Productos
  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      // Es necesario Crear
      await this.createProduct(product);
    } else {
      //Actualizar
      await this.updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

//actualizar
  Future<String> updateProduct(Product product) async {
    // Hace la peticion de backen - https://flutter-varios-42112-default-rtdb.firebaseio.com/products/ABC123  en el products se aplica la condicion "products/${product.id}.json"
    final url = Uri.https(_baseUrl, "products/${product.id}.json");
    final resp = await http.put(url, body: product.toJson());
    final decodedData = resp.body;

// actualizar el listado de productos clase 233

    final index =
        this.products.indexWhere((element) => element.id == product.id);
    this.products[index] = product;

    return product.id!;
  }

//CREATE PRODUCTO   IMPORTANTE PUT = Reemplaza la Informacion POST =Postea la informacion
  Future<String> createProduct(Product product) async {
    // Hace la peticion de backen - https://flutter-varios-42112-default-rtdb.firebaseio.com/products/ABC123  en el products se aplica la condicion "products/${product.id}.json"
    final url = Uri.https(_baseUrl, "products.json");
    final resp = await http.post(url, body: product.toJson());
    final decodedData = json.decode(resp.body);

// actualizar el listado de productos

    product.id = decodedData["name"];
    this.products.add(product);

    return product.id!;
  }

//Metodo de Camara y Galeria

  void updateSelectedProductImage(String path) {
    this.selectedProduct.picture = path;
    this.newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners(); //Redibuja los Widget
  }

  Future<String?> uploadImage() async {
    if (this.newPictureFile == null) return null;
    this.isLoading = true;
    notifyListeners();

    final url = Uri.parse(
        "https://api.cloudinary.com/v1_1/dj6acguct/image/upload?upload_preset=uimkhhlv");

    final imageUploadRequest = http.MultipartRequest("POST", url);
    final file =
        await http.MultipartFile.fromPath("file", newPictureFile!.path);
    imageUploadRequest.files.add(file);
    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print("Algo salio mal");
      print(resp.body);
      return null;
    }

    this.newPictureFile = null;
    final decodedData = jsonDecode(resp.body);
    return decodedData["secure_url"];
  }
}
