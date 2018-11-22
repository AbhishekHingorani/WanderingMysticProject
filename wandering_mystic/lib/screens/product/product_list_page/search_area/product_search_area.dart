import 'package:flutter/material.dart';
import '../../../../utils/backend_calls.dart';
import '../../cart/cart.dart';
import '../../../../data_models/scoped_models/main_model.dart';

class ProductSearchArea extends StatefulWidget{
  
  BackendCalls backendCalls = BackendCalls();
  MainModel model;

  ProductSearchArea(this.model);

  @override
  State<StatefulWidget> createState() => new _ProductSearchAreaState();
}

class _ProductSearchAreaState extends State<ProductSearchArea> {

  @override
  void initState() {
    widget.model.fetchCartItems(widget.model.user.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        gradient: new LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color.fromRGBO(235, 139, 123, 1.0),
            Color.fromRGBO(226, 197, 125, 1.0)
          ],
        ),
      ),
      height: screenHeight * 0.2,
      width: screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0, left: 25.0),
                  child: Text(
                    "Search Products...",
                    style: const TextStyle(
                        fontFamily: "SFProHeavy",
                        fontWeight: FontWeight.w800,
                        fontSize: 23.0,
                        color: Colors.white),
                  ),
                ),
              ),

              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (BuildContext context) => Cart()
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0, bottom: 5.0),
                  child: Stack(
                    children: <Widget>[
                      new Icon(
                        Icons.shopping_cart, 
                        size: 35.0,
                        color: Colors.white,
                      ),
                      new Positioned(
                        top: 0.0,
                        right: 0.0,
                        child: Container(
                          alignment: Alignment.center,
                          height: 20.0,
                          width: 20.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.red,
                          ),
                          child: _buildCartItemsCount(),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),


          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 12.0),
            child: Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.center,
              height: 50.0,
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.circular(12.0),
                  boxShadow: [
                    new BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        blurRadius: 20.0,
                        offset: Offset(0.0, 3.0))
                  ]),
              child: new TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search, color: Colors.grey,),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: "Search for products, brands & more...",
                  contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 0.0, 0.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCartItemsCount(){
    Widget content;

    if(widget.model.isFetchingCartItems){
      content = Container(
        height: 10.0,
        width: 10.0,
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white), 
          strokeWidth: 2.0,
        ),
      );
    }
    else{
      content = Text(
        widget.model.cartItemsCount.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.0
        )
      );
    }

    return content;
  }
}
