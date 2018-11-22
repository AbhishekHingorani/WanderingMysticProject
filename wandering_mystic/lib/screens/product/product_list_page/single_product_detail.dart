import 'package:flutter/material.dart';

import '../../../data_models/models/list_product.dart';
import '../../../data_models/scoped_models/main_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import '../../../utils/backend_calls.dart';
import 'dart:convert';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_rating/flutter_rating.dart';
//import './image_gallery.dart';

class SingleProductDetail extends StatefulWidget{
  
  final ListProduct product;
  final BackendCalls backendCalls = BackendCalls();

  SingleProductDetail(this.product);

  @override
  State<StatefulWidget> createState() => new _SingleProductDetailState();
}

class _SingleProductDetailState extends State<SingleProductDetail>{

  var data;
  double rating = 0.0;
  
  @override
  void initState() {
    print("object");
    widget.backendCalls.getSingleProductDetails(widget.product.id).then((http.Response response){
      data = json.decode(response.body); 
      setState(() {
        print(data);
      });
      
    });
    super.initState();
  }

  Widget build(BuildContext context) {

    
    
    Widget content;
    List<Widget> features; 
    List<NetworkImage> images;

    if(data == null)
      content = Scaffold(body: Center(child: CircularProgressIndicator()));
    else {

      features = new List.generate(data["featureArray"].length, (i)=> _buildFeatures(i));
      rating = double.parse(data["rating"].toString());

      images = new List.generate(data["imageArray"].length, (i) => _buildImages(i));
      images.insert(0, NetworkImage(widget.product.imageUrl));

      content = Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.5,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Carousel(
                    images: images,
                    autoplay: false,
                    dotBgColor: Colors.transparent,
                    boxFit: BoxFit.contain,
                    overlayShadow: true,
                    overlayShadowSize: 0.4,
                    dotSize: 5.0,
                    dotColor: Color.fromRGBO(64, 46, 50, 0.5),
                    overlayShadowColors: Color.fromRGBO(250, 250, 250, 0.0),
                  )
                ),
              ),
            ];
          },
          body: ListView(
            padding: EdgeInsets.only(left: 26.0, right: 26.0),
            children: <Widget>[
              
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(widget.product.name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 25.0, color: Colors.black, fontFamily: "SFProHeavy"
                  ),
                ),
              ),

              Text(
                data["description"],
                style: TextStyle(
                  fontFamily: "SFPro",
                  fontSize: 15.0,
                  height: 1.1
                ),
              ),

              FittedBox(
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      width: 220.0,
                      padding: EdgeInsets.only(top: 25.0, bottom: 5.0),
                      child: Text("INR " + widget.product.price.toString(),
                        style: TextStyle(
                          fontSize: 20.0, fontFamily: "SFPro"
                        ),
                      ),
                    ),

                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(top: 15.0),
                      child: StarRating(
                        size: 25.0,
                        rating: rating,
                        color: Colors.orange,
                        borderColor: Colors.grey,
                        starCount: 5,
                        onRatingChanged: (rating) => setState(
                          () {
                            this.rating = rating;
                          },
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),


              Padding(
                padding: EdgeInsets.only(top: 50.0, bottom: 10.0),
                child: Text("FEATURES",
                  style: TextStyle(
                    fontSize: 14.0, fontFamily: "SFProBold"
                  ),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: features,
              ),

            ]
          )
        ),

        bottomNavigationBar: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[

            Container(
              height: 70.0,
              decoration: BoxDecoration(
                gradient: new LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(128, 128, 128, 0.0),
                    Color.fromRGBO(128, 128, 128, 1.0)
                  ],
                ),
              ),
            ),

            Container(
              alignment: Alignment.center,
              height: 50.0,
              decoration: BoxDecoration(
                gradient: new LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color.fromRGBO(235, 139, 123, 1.0),
                    Color.fromRGBO(255, 140, 90, 1.0)
                    //Color.fromRGBO(226, 197, 125, 1.0)
                  ],
                ),
              ),
              child: Text(
                "ADD TO CART",
                style: TextStyle(
                  fontFamily: "SFProHeavy",
                  color: Colors.white
                ),
              ),
            ),

            Material(
              color: Colors.transparent,
              child: ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model){
                return InkWell(
                  onTap: (){
                    model.addProductToCart(model.user.id, widget.product);
                  },
                  child: _buildLoading(model)
                );
              }),
            ),
          ],
        ),
      );
    }

    return content;
  } 

  Widget _buildLoading(MainModel model){
    Widget content;

    if(model.isProductBeingAddedToCart == false){
      content = Container(height: 50.0,);
    }else{
      content = Container(
        alignment: Alignment.center,
        height: 50.0,
        decoration: BoxDecoration(
          gradient: new LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color.fromRGBO(235, 139, 123, 1.0),
              Color.fromRGBO(255, 140, 90, 1.0)
              //Color.fromRGBO(226, 197, 125, 1.0)
            ],
          ),
        ),
        child: Container(
          height: 20.0,
          width: 20.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white), 
            strokeWidth: 2.0,
          ),
        )
      );
    }

    return content;
  }

  NetworkImage _buildImages(i){
    return NetworkImage(data["imageArray"][i]);
  }

  Column _buildFeatures(int i){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, left: 5.0),
          child: Text(
            "•   " + data["featureArray"][i].toString(), 
            softWrap: true,
            style: TextStyle(
              fontFamily: "SFPro",
              fontSize: 15.0,
            ),
          ),
        ),
      ] 
    );
  }

}