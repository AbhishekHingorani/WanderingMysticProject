import 'package:flutter/material.dart';
import '../../../data_models/models/package.dart';
import 'package:http/http.dart' as http;
import '../../../utils/backend_calls.dart';
import 'dart:convert';
import './image_gallery.dart';

class SinglePackageDetails extends StatefulWidget {

  final Package package;
  final BackendCalls backendCalls = BackendCalls();
  

  SinglePackageDetails(this.package);

  @override
    State<StatefulWidget> createState() => new _SinglePackageDetailsState();
}

class _SinglePackageDetailsState extends State<SinglePackageDetails>{
  
  var data;
  
  @override
  void initState() {
    print("object");
    widget.backendCalls.getSinglePackageDetails(widget.package.id).then((http.Response response){
      data = json.decode(response.body); 
      setState(() {
        print("PackageDetails: ");
        print(data);
      });
      
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    Widget content;
    List<Widget> itineraryItems; 

    if(data == null)
      content = Scaffold(body: Center(child: CircularProgressIndicator()));
    else {

      itineraryItems = new List.generate(data["itineraryArray"].length, (i)=> _buildItinerary(i));

      content = Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.3,
                forceElevated: true,

                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[ 

                      Image.network(
                        widget.package.imageUrl,
                        fit: BoxFit.cover,
                      ),

                      Opacity(
                        opacity: 0.3,
                        child: Container(
                          decoration: BoxDecoration(
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


                    ]
                  )
                ),
              ),
            ];
          },
          body: ListView(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            children: <Widget>[
              
              Padding(
                padding: EdgeInsets.only(top: 30.0, bottom: 10.0),
                child: Text(widget.package.title.toUpperCase(),
                  style: TextStyle(
                    fontSize: 25.0, color: Colors.black, fontFamily: "SFProBold"
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

              Padding(
                padding: EdgeInsets.only(top: 25.0, bottom: 5.0),
                child: Text(widget.package.nights.toString() + " NIGHTS " + widget.package.days.toString() + " DAYS",
                  style: TextStyle(
                    fontSize: 15.0, fontFamily: "SFPro"
                  ),
                ),
              ),

              Text("INR " + widget.package.price.toString(),
                style: TextStyle(
                  fontSize: 18.0, fontFamily: "SFPro"
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 25.0, bottom: 5.0),
                child: Text("PHOTOS",
                  style: TextStyle(
                    fontSize: 12.0, fontFamily: "SFProBold"
                  ),
                ),
              ),

              Container(
                height: 160.0,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: 4,
                    // itemExtent: 10.0,
                    // reverse: true, //makes the list appear in descending order
                    itemBuilder: (BuildContext context, int index) {
                      return _buildImages(index, context);
                    }
                )
              ),


              Padding(
                padding: EdgeInsets.only(top: 25.0, bottom: 10.0),
                child: Text("ITINERARY",
                  style: TextStyle(
                    fontSize: 14.0, fontFamily: "SFProBold"
                  ),
                ),
              ),


              
              // Text(
              //   "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ",
              //   style: TextStyle(
              //     fontFamily: "SFPro",
              //     fontSize: 15.0,
              //     height: 1.1
              //   ),
              // ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: itineraryItems,
              ),

              Padding(
                padding: EdgeInsets.only(top: 25.0, bottom: 10.0),
                child: Text("ACCOMODATION",
                  style: TextStyle(
                    fontSize: 12.0, fontFamily: "SFProBold"
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  data["accommodation"],
                  style: TextStyle(
                    fontFamily: "SFPro",
                    fontSize: 15.0,
                    height: 1.1
                  ),
                ),
              ),

            ],
          )
        ),
      );
    }

    return content;
  }

  Widget _buildImages(int index, BuildContext context) {
    return new Container(
    // color: Colors.blue,
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 15.0, 10.0),
      child: new Row(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) => ImageGallery(
                  backgroundColor: Colors.black87,
                  image1: NetworkImage(data["imageArray"][0]),
                  image2: NetworkImage(data["imageArray"][1]),
                  image3: NetworkImage(data["imageArray"][2]),
                  image4: NetworkImage(data["imageArray"][3]),
                  index: index,
                )
              ));
            },
            child: new Row(children: [
              //new Image.asset("assets/images/varanasi.jpg"),
              Stack(
                children: <Widget>[
                  Container(
                    width: 130.0,
                    decoration: BoxDecoration(  
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(data["imageArray"][index]),
                        //image: AssetImage("assets/images/varanasi.jpg"),
                      ),
                    ),
                  ),

                  Opacity(
                    opacity: 0.3,
                    child: Container(
                      width: 130.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        gradient: new LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(255, 140, 90, 1.0),
                            Color.fromRGBO(64, 46, 50, 1.0)
                          ],
                        ),
                      )
                    )
                  ),
                ],
              ),
            ]),
          )
        ],
      ),
    );
  }

  Column _buildItinerary(int i){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "DAY " + (i+1).toString() + " : ",
          style: TextStyle(
            fontSize: 12.0, fontFamily: "SFProBold"
          )
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            data["itineraryArray"][i].toString(), 
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