import 'package:flutter/material.dart';
import '../../../data_models/models/address.dart';
import '../../../data_models/scoped_models/main_model.dart';

class ConfirmCheckout extends StatelessWidget{

  String addressId;
  MainModel model;
  Address address;
  List<Widget> orderItems;
  double total = 0.0;

  ConfirmCheckout(this.addressId, this.model){
    address = model.findAddressFromId(addressId);
  }

  @override
  Widget build(BuildContext context) {

    orderItems = new List.generate(model.cartItems.length, (i)=> _buildOrderItem(i));
    for (int i = 0; i < model.cartItemsCount; i++) {
      total += (model.cartItems[i].quantity * model.cartItems[i].price);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("CONFIRM CHECKOUT"),
        backgroundColor: Color.fromRGBO(250, 250, 250, 1.0),
        elevation: 0.4,
      ),
      body: ListView(
        children: <Widget>[
          
          ListTile(
            leading: Text("SHIPPING TO", style: TextStyle(color: Colors.grey, fontSize: 16.0),),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(model.user.name.toUpperCase()),
              ],
            ),
          ),


          ListTile(
            leading: Text("SHIPPING ADDRESS", style: TextStyle(color: Colors.grey, fontSize: 16.0),),
            isThreeLine: true,
            contentPadding: EdgeInsets.all(10.0),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(address.addressLine1 + ","),
                Text(address.addressLine2 + ","),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(address.city + ","),
                Text(address.state + ", " + address.zipCode + "."),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("ITEMS", style: TextStyle(color: Colors.grey, fontSize: 16.0),),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: orderItems,
          ),

          ListTile(
            contentPadding: const EdgeInsets.all(10.0),
            leading: Text("TOTAL", style: TextStyle(color: Colors.grey, fontSize: 16.0),),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text("₹ " + total.toString(), style: TextStyle(fontSize: 20.0),),
              ],
            ),
          ),
        ],
      ),


      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(100.0, 0.0, 100.0, 20.0),
        child: Builder(
          builder: (BuildContext context){
            return InkWell(
              onTap: () async {
                for(int i=0; i<model.cartItemsCount; i++){
                  model.addNewOrder(
                    model.cartItems[i].productId, 
                    model.cartItems[i].productName, 
                    model.cartItems[i].price, 
                    model.cartItems[i].imageUrl, 
                    model.cartItems[i].quantity
                  );
                }
                model.deleteAllCartItems();
                Scaffold.of(context).showSnackBar(new SnackBar(
                  content: new Text('ORDER PLACED'),
                ));
                await new Future.delayed(const Duration(seconds: 2));
                Navigator.pop(context);
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
                  "CONFIRM",
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),

              ),
            );
          }
        )
      ),
    );
  }

  ListTile _buildOrderItem(int i){
    return ListTile(
      contentPadding: EdgeInsets.all(20.0),
      leading: Container(width: 80.0, child: Image.network(model.cartItems[i].imageUrl)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(model.cartItems[i].productName),
          Text("Qty: " + model.cartItems[i].quantity.toString()),
          Text("Price: " + (model.cartItems[i].price * model.cartItems[i].quantity).toString()),
        ],
      ),
    );
  }
}