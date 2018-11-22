import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../data_models/scoped_models/main_model.dart';
import './confirm_checkout.dart';

class SelectShippingAddress extends StatefulWidget{

  MainModel model;

  SelectShippingAddress(this.model);

  @override
  State<StatefulWidget> createState() => new _SelectShippingAddressState();
}

class _SelectShippingAddressState extends State<SelectShippingAddress>{

  String _radioValue;
  String add1, add2, city, state, country, zipcode;

  @override
  void initState() {
    widget.model.fetchShippingAddresses(widget.model.user.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model){

      return Scaffold(
        appBar: AppBar(
          title: Text("SELECT SHIPPING ADDRESS"),
          backgroundColor: Color.fromRGBO(250, 250, 250, 1.0),
          elevation: 0.0,
        ),
        body: widget.model.isFetchingAddresses 
          ? Center(child: CircularProgressIndicator()) : 
          ListView.builder(
            itemCount: model.shippingAddresses.length,
            itemBuilder: (context, index) {
              return ListTile(
                isThreeLine: true,
                contentPadding: EdgeInsets.only(top: 10.0),
                leading: Radio(
                  value: widget.model.shippingAddresses[index].id,
                  onChanged: (val){
                    setState(() {
                      _radioValue = val;
                      print(_radioValue);
                    });
                  },
                  groupValue: _radioValue,
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.model.shippingAddresses[index].addressLine1 + ","),
                    Text(widget.model.shippingAddresses[index].addressLine2 + ","),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.model.shippingAddresses[index].city + ","),
                    Text(widget.model.shippingAddresses[index].state + ", " + widget.model.shippingAddresses[index].zipCode + "."),
                  ],
                ),
              );
            },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showDialog(
                context: context,
                builder: (_) => new AlertDialog(
                    title: new Text("ADD NEW ADDRESS"),
                    content: Column(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "Address line 1",
                            ),
                            onChanged: (String value){
                              add1 = value;
                            },
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "Address line 2",
                            ),
                            onChanged: (String value){
                              add2 = value;
                            },
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "City",
                            ),
                            onChanged: (String value){
                              city = value;
                            },
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "State",
                            ),
                            onChanged: (String value){
                              state = value;
                            },
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "Country",
                            ),
                            onChanged: (String value){
                              country = value;
                            },
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "ZipCode",
                            ),
                            onChanged: (String value){
                              zipcode = value;
                            },
                          ),
                        ),
                        MaterialButton(
                          height: 30.0,
                          color: Colors.black,
                          child: Text("SEND", style: TextStyle(color: Colors.white),),
                          onPressed: (){
                            widget.model.addNewAddress(widget.model.user.id ,add1, add2, city, state, country, zipcode);
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                )
            );
          },
          child: Icon(Icons.add, color: Colors.white,),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(100.0, 0.0, 100.0, 20.0),
          child: Builder(
            builder: (BuildContext context){
              return InkWell(
                onTap: (){
                  print(_radioValue);
                  if(_radioValue == null){
                    Scaffold.of(context).showSnackBar(new SnackBar(
                      content: new Text('Please Select an Address!'),
                    ));
                  }
                  else{
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (BuildContext context) => ConfirmCheckout(_radioValue, model)
                    ));
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        blurRadius: 20.0,
                        offset: Offset(0.0, 5.0)
                      )
                    ],
                    borderRadius: BorderRadius.circular(100.0),
                    gradient: new LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color.fromRGBO(235, 139, 123, 1.0),
                        Color.fromRGBO(255, 140, 90, 1.0),
                      ],
                    ),
                  ),
                  height: 50.0,
                  width: 10.0,
                  child: Text(
                    "PROCEED",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),

                ),
              );
            })
        ),
      );

    });
  }
}
