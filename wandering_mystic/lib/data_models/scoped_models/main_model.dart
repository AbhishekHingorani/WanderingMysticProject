import "package:scoped_model/scoped_model.dart";

import './package_items_model.dart';
import './product_items_model.dart';
import './cart_model.dart';
import './login_model.dart';
import './oder_model.dart';
import './shipping_addresses.dart';

class MainModel extends Model with PackageItemsModel, ProductItemsModel, CartModel, LoginModel, ShippingAddressModel, OrderModel{}