

import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:productos_app/domain/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier{
  final String _baseUrl='flutter-varios-acf1d-default-rtdb.firebaseio.com';
  final List<Product>products=[];
  late Product selectedProdct;

  File? newPictureFile;
  
  bool isLoading=true;
  bool isSaving = false;
  
  ProductsService(){
    this.loadProducts();
  }
    //TODO <List<Product>>
  Future<List<Product>> loadProducts() async {
    this.isLoading=true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);
 
    final Map<String, dynamic> productsMap = json.decode(resp.body);
    productsMap.forEach(
      (key, value) {

        final tempProduct = Product.fromRawJson(json.encode(value));
        tempProduct.id = key;
        this.products.add(tempProduct);
      },
    );
    this.isLoading=false;
    notifyListeners();
    return this.products;
  }

  Future saveOrCreateProduct(Product product) async{

    isSaving=true;
    notifyListeners();

  if ( product.id==null ){
    //Es necesario crear
    await this.createProduct(product);
    
  }else{
     //actulizar

    await this.updateProduct(product);
  }


    isSaving=false;
    notifyListeners();

  }


Future<String> updateProduct(Product product) async{
   final url = Uri.https(_baseUrl, 'products/${ product.id }.json');
    final resp = await http.put(url, body: json.encode(product.toJson()));
    final decodedData= resp.body;

    
    //TODO actulizar el listado de prodcutos
    final index = this.products.indexWhere((element) => element.id==product.id);
    this.products[index]=product;
    return product.id!;

}
Future<String> createProduct(Product product) async{
   final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.post(url, body: json.encode(product.toJson()));
    final decodedData= json.decode(resp.body);

   product.id=decodedData['name'];
    
    this.products.add(product);


    return product.id!;
    
   

}

  void updateSelectProductImage(String path){

     this.selectedProdct.picture=path; 
     this.newPictureFile= File.fromUri(Uri(path: path));

      notifyListeners();

  }
  Future<String?>uploadImage()async{
    if( this.newPictureFile==null  ) return null;

    this.isSaving=true;
    notifyListeners();
   

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dlzsa2ygb/image/upload?upload_preset=pxdcpwgs');

    final ImageUploadRequest = http.MultipartRequest('POST',url);

    final file =await http.MultipartFile.fromPath('file', newPictureFile!.path);

    ImageUploadRequest.files.add(file);

    final streamedResponse=await ImageUploadRequest.send();
    final resp =await http.Response.fromStream(streamedResponse);


    if(resp.statusCode != 200 && resp.statusCode != 201){
      print('algo salio mal ');
      print(resp.body);
      return null;
    }
    this.newPictureFile=null;
    final decodedData =json.decode(resp.body);
    print(resp.body);
  }
}
