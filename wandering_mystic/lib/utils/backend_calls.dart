import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class BackendCalls {
  static final BackendCalls _singleton = new BackendCalls._internal();
  factory BackendCalls() {
    return _singleton;
  }
  BackendCalls._internal();


  //String url = "172.20.10.4:2018";
  String url = "https://wandering-mystic.firebaseio.com";
  String url2 = "http://192.168.43.115:2018";
  Map<String, String> headers = { "Accept" : "application/json" };
  //Map<String, String> headers = { "Content-Type" : "text/plain" };

  Future<http.Response> login(email, password){
    return http.get(
      Uri.encodeFull(url + "/login.json"),
      headers: headers
    );
  }

  Future<http.Response> signup(name, email, number, password){
    print(name + ", " + email + ", " + number + ", " + password);

    final Map<String, dynamic> userDetails = {
      "name": name,
      "email": email,
      "number": number,
      "password": password
    };

    return http.post(
      //Uri.encodeFull(url + "/login.json"),
      Uri.encodeFull(url2 + "/customer"),
      headers: headers,
      body: json.encode(userDetails)
    );
  }

  Future<http.Response> getPackages() {
    return http.get(
      //Uri.encodeFull(url + "/packages.json"),
      Uri.encodeFull(url2 + "/packages"),
      headers: headers,
    );
  }

  Future<http.Response> getSinglePackageDetails(int id) {
    return http.get(
      //Uri.encodeFull(url + "/packageDetails/" + id.toString() + ".json"),
      Uri.encodeFull(url2 + "/packageDetails/" + id.toString()),
      headers: headers
    );
  }

  Future<http.Response> searchPackages(String value) {
    return http.get(
      //Uri.encodeFull(url + "/searchPackages.json"),
      Uri.encodeFull(url2 + "/search/packages?search=" + value),
      headers: headers,
      //body: "{'query' : '" + value + "'}"
    );
  }

  Future<http.Response> getProductsList() {
    return http.get(
      //Uri.encodeFull(url + "/products.json"),
      Uri.encodeFull(url2 + "/products"),
      headers: headers
    );
  }

  Future<http.Response> getSingleProductDetails(int id) {
    return http.get(
      //Uri.encodeFull(url + "/productDetails/" + id.toString() + ".json"),
      Uri.encodeFull(url2 + "/productDetails/" + id.toString()),
      headers: headers
    );
  }

  Future<http.Response> addProductToCart(String userid, int id){
    print("fired");
    return http.post(
      //Uri.encodeFull(url + "/cart.json"),
      Uri.encodeFull(url2 + "/customer/" + userid + "/cart/product/" + id.toString()),
      headers: headers,
    );
  }

  Future<http.Response> getCartItems(String userid){
    return http.get(
      //Uri.encodeFull(url + "/cart.json"), //cartItems.json
      Uri.encodeFull(url2 + "/customer/" + userid + "/cart"), //cartItems.json
      headers: headers,
    );
  }

  Future<http.Response> incrementCartQtyOfProduct(String userid, String prodid){
    return http.post(
      //Uri.encodeFull(url + "/cart.json"), //cartItems.json
      Uri.encodeFull(url2 + "/customer/"+userid+"/cart/product/"+prodid+"/quantity/1"), //cartItems.json
      headers: headers,
    );
  }

  Future<http.Response> decrementCartQtyOfProduct(String userid, String prodid){
    return http.post(
      //Uri.encodeFull(url + "/cart.json"), //cartItems.json
      Uri.encodeFull(url2 + "/customer/"+userid+"/cart/product/"+prodid+"/quantity/-1"), //cartItems.json
      headers: headers,
    );
  }

  Future<http.Response> deleteCartItem(String userid, String prodid){
    return http.delete(
      //Uri.encodeFull(url + "/cart.json"), //cartItems.json
      Uri.encodeFull(url2 + "/customer/"+userid+"/cart/product/"+prodid), //cartItems.json
      headers: headers,
    );
  }

  Future<http.Response> getOrderItems(String id){
    return http.get(
      Uri.encodeFull(url + "/order.json"),
      headers: headers,
    );
  }

  Future<http.Response> getShippingAddresses(String userid){
    return http.get(
      //Uri.encodeFull(url + "/address.json"),
      Uri.encodeFull(url2 + "/customer/" + userid + "/address"),
      headers: headers,
    );
  }

  Future<http.Response> addNewShippingAddress(userid, add1 ,add2, city, state, country, zipCode){
    final Map<String, dynamic> addDetails = {
      "line1": add1,
      "line2": add2,
      "city": city,
      "state": state,
      "country": country,
      "zip": zipCode
    };
    print("looooooooooooooooooooooooooolll");
    return http.post(
      Uri.encodeFull(url2 + "/customer/" + userid + "/address"),
      headers: headers,
      body: json.encode(addDetails)
    );
  }

}