import "package:scoped_model/scoped_model.dart";
import 'package:http/http.dart' as http;
import '../../utils/backend_calls.dart';
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class LoginModel extends Model {

  BackendCalls backendCalls = BackendCalls();
  bool _isLoading = false;
  //String _token;
  User _user;


  void login(email, password){
    _isLoading = true;
    notifyListeners(); 
    backendCalls.login(email, password).then((http.Response response){
        final Map<String, dynamic> data = json.decode(response.body);

        if(data.containsKey("token") != null){
          String token = data["token"];
          _saveToken(token);
        }
        else
          print("NOOO");

        _isLoading = false;
        notifyListeners(); //
      });
  }

  void signup(name, email, number, password){
    _isLoading = true;
    notifyListeners(); 
    backendCalls.signup(name, email, number, password).then((http.Response response){
        print(response.body);
        _isLoading = false;
        notifyListeners(); //
      });
  }

  void logout() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    //_token = null;
    _user = null;
    notifyListeners();
  }

  bool get isLoggingIn{
    return _isLoading;
  }

  void _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    //_token = token;
    _createUserFromToken(token);
  }

  void retriveTokenIfAvailable() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _token = prefs.getString("token");
    _createUserFromToken(_token);
    notifyListeners();
  }

  // bool get isTokenAvailable{
  //   return _token == null ? false : true;
  // }

  bool get isUserAvailable{
    return _user == null ? false : true;
  }

  _createUserFromToken(String token){
    Map<String, dynamic> userData = _parseJwt(token);
    _user = User(
      id: userData["id"],
      name: userData["name"],
      email: userData["email"],
      phoneNo: userData["phoneNo"],
      addressLine1: userData["addressLine1"],
      addressLine2: userData["addressLine2"],
      city: userData["city"],
      state: userData["state"],
      country: userData["country"],
      zipCode: userData["zipCode"]
    );
  }

  User get user{
    return _user;
  }

  Map<String, dynamic> _parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

}