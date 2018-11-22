import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../data_models/scoped_models/main_model.dart';

class TravelSearchArea extends StatelessWidget {
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
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 25.0),
            child: Text(
              "Where do you wanna go?",
              style: const TextStyle(
                  fontFamily: "SFProHeavy",
                  fontWeight: FontWeight.w800,
                  fontSize: 23.0,
                  color: Colors.white),
            ),
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
                        offset: Offset(0.0, 3.0)
                    )
                  ]
              ),

              child: ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model){
                return TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search, color: Colors.grey,),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "Search for places, tags, destinations...",
                    contentPadding: EdgeInsets.fromLTRB(25.0, 10.0, 0.0, 0.0),
                  ),
                  onFieldSubmitted: (v) => onSearch(v, model),
                );
              })
            ),
          )
        ],
      ),
    );
  }

  onSearch(value, MainModel model){
    model.searchPackages(value);
  }
}
