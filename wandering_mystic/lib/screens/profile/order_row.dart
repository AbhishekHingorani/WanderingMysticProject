import 'package:flutter/material.dart';
import '../../data_models/models/order_item.dart';
import '../../data_models/scoped_models/main_model.dart';

class OrderRow extends StatelessWidget{
  
  OrderRow(this.model, this.index){
    orderItem = model.orderItems[index];
  }

  final MainModel model;
  final int index;
  OrderItem orderItem;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 15.0),
        height: 100.0,
        decoration: BoxDecoration(
          color: Color.fromRGBO(250, 250, 250, 1.0),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(width: 0.8)
        ),

        child: Row(
          children: <Widget>[
            
            Container(
              height: 80.0,
              width: 80.0,
              margin: EdgeInsets.only(left: 10.0),
              child: Image.network(orderItem.imageUrl),
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
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      orderItem.productName,
                      style: TextStyle(
                        fontFamily: "SFProHeavy",
                        fontSize: 16.0
                      ),
                      overflow: TextOverflow.ellipsis, 
                    ),
                  ),


                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('QTY: ' + orderItem.quantity.toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: "SFPro"
                        ),
                      ),

                      Text('₹ ' + orderItem.price.toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontFamily: "SFPro"
                        ),
                      ),
                    ],
                  ),

                  Text(
                    orderItem.date,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: "SFPro"
                    ),
                  ),

                ],
              ),
            ),

            Container(
              width: 70.0,
              child: Text(
                orderItem.status.toUpperCase(),
                style: TextStyle(
                  color: Colors.grey,

                )
              ) 
            )

          ],
        ),
      ),
    );
  }


}