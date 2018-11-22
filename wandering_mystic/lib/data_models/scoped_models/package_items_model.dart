import "package:scoped_model/scoped_model.dart";
import '../models/package.dart';
import 'package:http/http.dart' as http;
import '../../utils/backend_calls.dart';
import 'dart:convert';

class PackageItemsModel extends Model {

  BackendCalls backendCalls = BackendCalls();
  List<Package> _packages = [];
  bool _isLoading = false;

  Package temp = new Package(
    id: 1,
    title: "VENTURE VARANASI", 
    subtitle: "SERENE FAMILY TRIP",
    price: 20000,
    days: 3,
    nights: 2,
    imageUrl: "http://www.varthabharati.in/sites/default/files/images/articles/2018/07/5/141416.jpg"
  );

  void fetchPackages(){
    if(_packages.isEmpty){
      _isLoading = true;
      backendCalls.getPackages().then((http.Response response){
        var data = json.decode(response.body);
        print("PACKAGES: ");
        print(response.body);
        data.forEach((data){
          _packages.add(Package.fromJson(data));
        });
        _isLoading = false;
        notifyListeners(); 
      });
    } 
  }

  void refreshPackages(){
    _isLoading = true;
    notifyListeners();
    _packages.removeRange(0, _packages.length);
    backendCalls.getPackages().then((http.Response response){
      var data = json.decode(response.body);
      data.forEach((data){
        _packages.add(Package.fromJson(data));
      });
      _isLoading = false;
      notifyListeners(); 
    });
  }

  void searchPackages(String value){
    _isLoading = true;
    notifyListeners();
    _packages.removeRange(0, _packages.length);
    backendCalls.searchPackages(value).then((http.Response response){
      var data = json.decode(response.body);
      data.forEach((data){
        _packages.add(Package.fromJson(data));
      });
      _isLoading = false;
      notifyListeners(); 
    });
  }

  List<Package> get packages{
    return List.from(_packages);
  }

  bool get isPackagesLoading{
    return _isLoading;
  }

  void addPackage(Package package) {
    _packages.add(package);
  }

  void addMorePackages() {
    _packages.add(temp);
    _packages.add(temp);
    _packages.add(temp);
  }
}

