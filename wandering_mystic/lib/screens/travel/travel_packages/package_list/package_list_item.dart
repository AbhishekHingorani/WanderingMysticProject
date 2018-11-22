import 'package:flutter/material.dart';
import '../../../../data_models/models/package.dart';

class PackageListItem extends StatelessWidget {

  final Package packageItem;

  PackageListItem({this.packageItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          new BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 20.0,
            offset: Offset(0.0, 5.0))
        ]),
      height: 200.0,
      width: MediaQuery.of(context).size.width * 0.85,
      child: Stack(
        children: <Widget>[
          //Background Image
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(packageItem.imageUrl),
                //image: AssetImage("assets/images/varanasi.jpg"),
              ),
            ),
          ),

          //Gradient Overlay
          Opacity(
            opacity: 0.3,
            child: Container(
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
                        packageItem.title.toUpperCase(),        //Title of card 
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
                        packageItem.subtitle, 
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


          //Bottom Text
          Container(
            height: 200.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 20.0), 
                    child: Text(
                      packageItem.nights.toString() + " NIGHTS " + packageItem.days.toString() + " DAYS",
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
                  width: 140.0,
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 20.0), 
                  child: Text(
                    "INR " + packageItem.price.toString() + " ONWARDS",
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
        ]
      ),
    );
  }
}
