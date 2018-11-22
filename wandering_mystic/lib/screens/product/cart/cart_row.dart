import 'package:flutter/material.dart';
import '../../../data_models/models/cart_item.dart';
import '../../../data_models/scoped_models/main_model.dart';

class CartRow extends StatefulWidget{
  
  CartRow(this.model, this.index);

  final MainModel model;
  final int index;
  
  @override
  State<StatefulWidget> createState() => new _CartRowState();
}

class _CartRowState extends State<CartRow>{

  CartItem cartItem;
  double total;

  @override
  void initState() {
    print("index : ");
    print(widget.index);
    this.cartItem = widget.model.cartItems[widget.index];
    calcTotal();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        margin: EdgeInsets.all(10.0),
        height: 120.0,
        decoration: BoxDecoration(
          color: Color.fromRGBO(250, 250, 250, 1.0),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            new BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 20.0,
              offset: Offset(0.0, 5.0)
            )
          ]
        ),

        child: Row(
          children: <Widget>[
            
            Container(
              height: 100.0,
              width: 100.0,
              margin: EdgeInsets.only(left: 10.0),
              child: Image.network(cartItem.imageUrl),
            ),

            Container(
              width: 220.0,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(10.0),
              child: Flex(
                crossAxisAlignment: CrossAxisAlignment.start,
                direction: Axis.vertical,
                children: <Widget>[
                  
                  
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                    child: Text(
                      cartItem.productName,
                      style: TextStyle(
                        fontFamily: "SFProHeavy",
                        fontSize: 16.0
                      ),
                      overflow: TextOverflow.ellipsis, 
                    ),
                  ),


                  
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text("INR " + total.toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: "SFProBold"
                      ),
                    ),
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[

                      Material(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100.0),
                          splashColor: Color.fromRGBO(235, 139, 123, 0.3),
                          onTap: (){
                            setState(() {
                              //cartItem.quantity--;
                              widget.model.decrementItemQuantity(widget.model.user.id, widget.index);
                              calcTotal();
                              //widget.model.decrementItemQuantity(widget.index);
                            });
                          },
                          child: Container(
                            height: 30.0,
                            width: 30.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              border: new Border.all(color: Colors.grey),
                            ),
                            child: Icon(
                              Icons.remove,
                              color: Colors.black,
                              size: 15.0,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Text(cartItem.quantity.toString()),
                      ),

                      Material(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(100.0),
                          splashColor: Color.fromRGBO(235, 139, 123, 0.3),
                          onTap: (){
                            setState(() {
                              //cartItem.quantity++;
                              widget.model.incrementItemQuantity(widget.model.user.id, widget.index);
                              calcTotal();
                              //widget.model.incrementItemQuantity(widget.index);
                            });
                          },
                          child: Container(
                            height: 30.0,
                            width: 30.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              border: new Border.all(color: Colors.grey),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 15.0,
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),


                ],
              ),
            ),

            Container(
              width: 50.0,
              child: InkWell(
                onTap: (){
                  widget.model.deleteCartItem(widget.model.user.id, widget.index);
                },
                child: Icon(Icons.delete, color: Colors.red),
              )
            )

          ],
        ),
      ),
    );
  }

  calcTotal(){
    total = cartItem.quantity * cartItem.price;
  }

}