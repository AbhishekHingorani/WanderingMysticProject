import "package:scoped_model/scoped_model.dart";
import '../models/cart_item.dart';
import '../models/list_product.dart';
import 'package:http/http.dart' as http;
import '../../utils/backend_calls.dart';
import 'dart:convert';

class CartModel extends Model {

  BackendCalls backendCalls = BackendCalls();
  List<CartItem> _cartItems = [];
  bool _isProductBeingAddedToCart = false;
  bool _isLoading = false;
  bool _areItemsFetched = false;

  void fetchCartItems(String userId){
    if(_areItemsFetched == false){
      _areItemsFetched = true;
      _isLoading = true;
      notifyListeners();
      backendCalls.getCartItems(userId).then((http.Response response){
        var data = json.decode(response.body);
        print("data:");
        print(response.body);
        data.forEach((data){
          _cartItems.add(CartItem.fromJson(data));
        });
        _isLoading = false;
        notifyListeners(); 
      });
    }
  }

  void addItemToCart(CartItem item) {
    bool _added = false;
    _cartItems.forEach((f){
      if(f.productId == item.productId){
        f.quantity++;
        _added = true;
      }
    });
    if(!_added){
      _cartItems.add(item);
    }
  }

  void addProductToCart(String userid, ListProduct product){
    if(_isProductBeingAddedToCart == false){
      _isProductBeingAddedToCart = true;
      notifyListeners();
    
      backendCalls.addProductToCart(userid, product.id).then((http.Response response){
        //var data = json.decode(response.body);
        print(response.body);
      //});

        addItemToCart(CartItem(
          imageUrl: product.imageUrl,
          price: double.parse(product.price.toString()),
          productId: product.id,
          productName: product.name,
          quantity: 1
        ));

        _isProductBeingAddedToCart = false;
        notifyListeners(); 
      });
    }
  }

  void incrementItemQuantity(userid, index){
    _cartItems[index].quantity++;
    backendCalls.incrementCartQtyOfProduct(userid, _cartItems[index].productId.toString()).then(
      (http.Response response){
        print(response.body);
      }
    );
  }
  
  void decrementItemQuantity(userid, index){
    if(_cartItems[index].quantity > 1){
      _cartItems[index].quantity--;
      backendCalls.decrementCartQtyOfProduct(userid, _cartItems[index].productId.toString()).then(
        (http.Response response){
          print(response.body);
        }
      );
    }
  }

  void deleteCartItem(userid, index){
    backendCalls.deleteCartItem(userid, _cartItems[index].productId.toString()).then(
      (http.Response response){
        print(response.body);
        _cartItems.removeAt(index);
        notifyListeners();
      }
    );
  
  }

  bool get isProductBeingAddedToCart{
    return _isProductBeingAddedToCart;
  }

  List<CartItem> get cartItems{
    return List.from(_cartItems);
  }

  bool get isFetchingCartItems{
    return _isLoading;
  }

  int get cartItemsCount {
    if(_cartItems == null)
      return 0;
    else
      return _cartItems.length;
  }

  void deleteAllCartItems(){
    _cartItems = null;
    notifyListeners();
  }
}