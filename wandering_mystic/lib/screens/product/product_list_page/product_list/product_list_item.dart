import 'package:flutter/material.dart';
import '../../../../data_models/models/list_product.dart';

class ProductListItem extends StatelessWidget {

  final ListProduct product;
  double height, width;

  ProductListItem({this.product, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      boxShadow: [
        new BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.25),
          blurRadius: 20.0,
          offset: Offset(0.0, 5.0)
        )
      ]),
      height: height == null ? 220.0 : height,
      width: width == null ? MediaQuery.of(context).size.width * 0.45 : width,
      child: Stack(
        children: <Widget>[
          //Background Image
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(product.imageUrl),
                //image: AssetImage("assets/images/varanasi.jpg"),
              ),
            ),
          ),

          //Gradient Overlay
          Opacity(
            opacity: 1.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                gradient: new LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0.0),
                    Color.fromRGBO(0, 0, 0, 0.0),
                    Color.fromRGBO(0, 0, 0, 0.0),
                    Color.fromRGBO(0, 0, 0, 0.0),
                    Color.fromRGBO(0, 0, 0, 0.0),
                    Color.fromRGBO(0, 0, 0, 0.0),
                    Color.fromRGBO(253, 139, 123, 0.1),
                    Color.fromRGBO(211, 118, 107, 0.2),
                    Color.fromRGBO(64, 46, 50, 0.4),
                    Color.fromRGBO(64, 46, 50, 0.7),
                    Color.fromRGBO(64, 46, 50, 1.0),
                  ],
                ),
              )
            )
          ),

          Container(
            height: 400.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 20.0), 
                    child: Text(
                      product.name,
                      textAlign: TextAlign.left, 
                      overflow: TextOverflow.ellipsis, 
                      style: TextStyle(
                        fontFamily: "SFProBold",
                        fontSize: 12.0,
                        color: Colors.white
                      ),
                    ),
                  )
                ),
                Container(
                  width: 60.0,
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 20.0), 
                  child: Text(
                    "₹ " + product.price.toString(),
                    textAlign: TextAlign.right, 
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: "SFProBold",
                      fontSize: 12.0,
                      color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}