import "package:scoped_model/scoped_model.dart";
import '../models/list_product.dart';
import 'package:http/http.dart' as http;
import '../../utils/backend_calls.dart';
import 'dart:convert';

class ProductItemsModel extends Model {

  BackendCalls backendCalls = BackendCalls();
  List<ListProduct> _products = [];
  bool _isLoading = false;

  ListProduct temp2 = new ListProduct(
    id: 1,
    name: "IPHONE 7", 
    price: 20000,
    imageUrl: "https://image.ibb.co/mfjkML/iphone.jpg"
  );

  void fetchProducts(){
    if(_products.isEmpty){
      _isLoading = true;
      backendCalls.getProductsList().then((http.Response response){
        var data = json.decode(response.body);
        print("PRODUCTS: ");
        print(products);
        data.forEach((data){
          _products.add(ListProduct.fromJson(data));
        });
        _isLoading = false;
        notifyListeners(); 
      });
    } 
  }

  List<ListProduct> get products{
    return List.from(_products);
  }

  bool get isProductsLoading{
    return _isLoading;
  }

  void addProduct(ListProduct product) {
    _products.add(product);
  }

  void addMoreProducts() {
    _products.add(temp2);
    _products.add(temp2);
    _products.add(temp2);
  }

  
}

