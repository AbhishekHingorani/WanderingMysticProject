import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../data_models/scoped_models/main_model.dart';
import './order_row.dart';
import '../inquiry_form/inquiry_form.dart';

class Profile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => new _ProfileState();
}

class _ProfileState extends State<Profile>{

  MediaQueryData queryData;
  
  static const IconData bookIcon = const IconData(0xe900, fontFamily: "profilepageicons");
  static const IconData envelopeIcon = const IconData(0xe901, fontFamily: "profilepageicons");
  static const IconData userIcon = const IconData(0xe902, fontFamily: "profilepageicons");
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model){

        model.fetchOrderItems(model.user.id);

        return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
              backgroundColor: Color.fromRGBO(250, 250, 250, 1.0),
              elevation: 0.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  margin: EdgeInsets.all(20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 30.0,),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                userIcon, 
                                color: Color.fromRGBO(64, 46, 50, 1.0),
                                size: 20.0,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                model.user.name.toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: "SFProHeavy",
                                  //fontSize: 25.0,
                                  fontSize: MediaQuery.textScaleFactorOf(context) * 20,
                                  color: Color.fromRGBO(64, 46, 50, 1.0),
                                ),
                              ),
                            ),
                            

                            Container(
                              height: 30.0,
                              width: 110.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1.0),
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) => InquiryForm()
                                  ));
                                },
                                child: Text(
                                  "INQUIRE",
                                  style: TextStyle(
                                    color: Color.fromRGBO(64, 46, 50, 1.0),
                                  ),
                                ),
                              )
                            )
                          ],
                        ),

                        Container(
                          decoration: BoxDecoration(
                            border: Border(top: BorderSide(width: 0.8)),
                            color: Colors.grey
                          ),
                          margin: EdgeInsets.only(top: 12.0, right: 180.0, bottom:12.0),
                        ),

                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Icon(
                                envelopeIcon, 
                                color: Color.fromRGBO(64, 46, 50, 1.0),
                                size: 15.0,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                model.user.email,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: "SFProBold",
                                  fontSize: 13.0,
                                  color: Color.fromRGBO(64, 46, 50, 1.0),
                                ),
                              ),
                            ),
                            

                            Container(
                              height: 30.0,
                              width: 110.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1.0),
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: InkWell(
                                onTap: (){
                                  model.logout();
                                },
                                child: Text(
                                  "LOGOUT",
                                  style: TextStyle(
                                    color: Color.fromRGBO(64, 46, 50, 1.0),
                                  ),
                                ),
                              )
                            )
                          ],
                        ),

                        Container(
                          decoration: BoxDecoration(
                            border: Border(top: BorderSide(width: 0.8)),
                            color: Colors.grey
                          ),
                          margin: EdgeInsets.only(top: 12.0, right: 180.0, bottom: 12.0),
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: Icon(
                                bookIcon, 
                                color: Color.fromRGBO(64, 46, 50, 1.0),
                                size: 20.0,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    model.user.addressLine1 + ",",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: "SFProBold",
                                      fontSize: 14.0,
                                      color: Color.fromRGBO(64, 46, 50, 1.0),
                                    ),
                                  ),
                                  Text(
                                    model.user.addressLine2 + ",",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: "SFProBold",
                                      fontSize: 14.0,
                                      color: Color.fromRGBO(64, 46, 50, 1.0),
                                    ),
                                  ),
                                  Text(
                                    model.user.city + ", " + model.user.state + ". " + model.user.zipCode,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: "SFProBold",
                                      fontSize: 14.0,
                                      color: Color.fromRGBO(64, 46, 50, 1.0),
                                    ),
                                  ),
                                ],
                              )
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 40.0,),
                          child: Text("ORDERS",
                            style: TextStyle(
                              fontSize: 14.0, fontFamily: "SFProBold"
                            ),
                          ),
                        ),
                      ],
                    )
                )
              ),
            ),
          ];
        },



        body: model.isFetchingOrderItems ? 
        Center(child: CircularProgressIndicator(),) :
        ListView.builder(
          padding: EdgeInsets.all(0.0),
          itemCount: model.orderItems.length,
          itemBuilder: (context, index) {
            return OrderRow(model, index);
          },
        ),


        
      ); })
    );
  }
}