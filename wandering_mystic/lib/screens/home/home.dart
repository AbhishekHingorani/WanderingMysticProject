import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../data_models/models/list_product.dart';
import '../product/product_list_page/single_product_detail.dart';
import '../product/product_list_page/product_list/product_list_item.dart';

class Home extends StatefulWidget{
  @override
    State<StatefulWidget> createState() => new _HomeState();
}

class _HomeState extends State<Home>{

  Map<String, String> package = {
    "image": "https://www.telegraph.co.uk/content/dam/Travel/hotels/europe/france/paris/eiffel-tower-paris-p.jpg",
    "name": "paris"
  };


  List<ListProduct> products = [
    ListProduct(
      id: 1,
      name: "IPHONE 7", 
      price: 20000,
      imageUrl: "https://image.ibb.co/mfjkML/iphone.jpg"
    ),
    ListProduct(
      id: 1,
      name: "IPHONE 7", 
      price: 20000,
      imageUrl: "https://image.ibb.co/mfjkML/iphone.jpg"
    ),
    ListProduct(
      id: 1,
      name: "IPHONE 7", 
      price: 20000,
      imageUrl: "https://image.ibb.co/mfjkML/iphone.jpg"
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 10.0),
              child: Text(
                "FEATURED",
                style: TextStyle(
                  fontFamily: "SFProBold",
                  fontSize: 12.0,
                ),
              ),
            ),

            Container(
              alignment: Alignment.center,
              height: 280.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0)
              ),
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Swiper(
                outer: true,
                itemCount: 3,
                itemBuilder: (context , i) => _buildImages(context, i),
                autoplay: true,
                loop: true,
                pagination: SwiperPagination(),
              )
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 10.0),
              child: Text(
                "TRENDING PRODUCTS",
                style: TextStyle(
                  fontFamily: "SFProBold",
                  fontSize: 12.0,
                ),
              ),
            ),

            Container(
              height: 180.0,
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: products.length,
                  // itemExtent: 10.0,
                  // reverse: true, //makes the list appear in descending order
                  itemBuilder: (BuildContext context, int index) {
                    return buildListItem(products[index], index);
                  }
              )
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 50.0, 0.0, 10.0),
              child: Text(
                "POPULAR DESTINATIONS",
                style: TextStyle(
                  fontFamily: "SFProBold",
                  fontSize: 12.0,
                ),
              ),
            ),

            Container(
              height: 180.0,
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: 3,
                  // itemExtent: 10.0,
                  // reverse: true, //makes the list appear in descending order
                  itemBuilder: (BuildContext context, int index) {
                    return buildListPackages(package["image"], package["name"]);
                  }
              )
            ),
          ]
        ),
      ),
    );
  }

  Widget _buildImages(BuildContext context, int i){
    return Stack(
      children: <Widget>[
        
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.network(
            "http://www.varthabharati.in/sites/default/files/images/articles/2018/07/5/141416.jpg",
            fit: BoxFit.cover,
            height: 300.0,
          ),
        ),

        Opacity(
          opacity: 0.4,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(255, 140, 90, 1.0),
                  Color.fromRGBO(253, 139, 123, 1.0)
                ],
              ),
            )
          )
        ),

        //Center Text
        Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 200.0,
                    child: Text(
                      "VISIT VARANASI",        //Title of card 
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "SFProHeavy",
                        fontWeight: FontWeight.w800,
                        fontSize: 23.0,
                        color: Colors.white
                      ),
                    ),
                  ),
                  Container(
                    width: 230.0,
                    child: Text(
                      "SERENE AND RELIGIOUS FAMILY TRIP", 
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: "SFPro",
                        fontSize: 12.0,
                        color: Colors.white
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ),
      ],
    );
  }

  GestureDetector buildListItem(ListProduct product, int index){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context) => SingleProductDetail(product)
        ));
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 25.0, 10.0),
        child: ProductListItem(product: product, height: 200.0, width: 140.0,),
      ),
    );
  }

  Padding buildListPackages(String image, String name){
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 25.0, 10.0),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.network(
              image,
              width: 230.0,
            ),
          ),

          //Gradient
          Opacity(
            opacity: 0.3,
            child: Container(
              width: 230.0,
              height: 145.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                gradient: new LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(255, 140, 90, 1.0),
                    Color.fromRGBO(253, 139, 123, 1.0)
                  ],
                ),
              ),
            )
          ),

          //Center Text
          Container(
            height: 130.0,
            width: 230.0,
            alignment: Alignment.bottomCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      name.toUpperCase(),
                      textAlign: TextAlign.left, 
                      overflow: TextOverflow.ellipsis, 
                      style: TextStyle(
                        fontFamily: "SFProBold",
                        fontSize: 16.0,
                        color: Colors.white
                      ),
                    ),
                  )
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}