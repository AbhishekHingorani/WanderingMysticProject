import 'package:flutter/material.dart';
import './cart_row.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../data_models/scoped_models/main_model.dart';
import '../checkout/select_shipping_address.dart';

class Cart extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _CartState();
}

class _CartState extends State<Cart>{

  @override
  Widget build(BuildContext context) {

    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model){

      return Scaffold(
        appBar: AppBar(
          title: Text("CART"),
          backgroundColor: Color.fromRGBO(250, 250, 250, 1.0),
          elevation: 0.0,
        ),
        body: ListView.builder(
          itemCount: model.cartItemsCount,
          itemBuilder: (context, index) {
            return CartRow(model, index);
          },
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(100.0, 0.0, 100.0, 20.0),
          child: InkWell(
            onTap: (){
              if(model.cartItemsCount > 0){
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (BuildContext context) => SelectShippingAddress(model)
                ));
              }
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    blurRadius: 20.0,
                    offset: Offset(0.0, 5.0)
                  )
                ],
                borderRadius: BorderRadius.circular(100.0),
                gradient: new LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color.fromRGBO(235, 139, 123, 1.0),
                    Color.fromRGBO(255, 140, 90, 1.0),
                  ],
                ),
              ),
              height: 50.0,
              width: 10.0,
              child: Text(
                "CHECKOUT",
                style: TextStyle(
                  color: Colors.white
                ),
              ),

            ),
          ),
        ),
      );

    });
  }
}