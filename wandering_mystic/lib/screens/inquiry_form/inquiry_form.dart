import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class InquiryForm extends StatelessWidget {

  static String name, email, number, destination, message, headCount, date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          "Inquiry Form",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 35.0, color: Colors.black, fontFamily: "SFProHeavy"
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Theme(
        data: ThemeData(
          primaryColor: Color.fromRGBO(64, 46, 50, 1.0),
        ),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Full Name",
                ),
                onChanged: (String value){
                  //changeName(value);
                  name = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Number",
                ),
                keyboardType: TextInputType.number,
                onChanged: (String value){
                  number = value;
                  print(name);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (String value){
                  email = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Message",
                ),
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                onChanged: (String value){
                  message = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Destination",
                ),
                onChanged: (String value){
                  destination = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Head Count",
                ),
                keyboardType: TextInputType.number,
                onChanged: (String value){
                  headCount = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Date (dd/mm/yyyy)",
                ),
                keyboardType: TextInputType.datetime,
                onChanged: (String value){
                  date = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: MaterialButton(
                color: Colors.black,
                child: Text("SEND", style: TextStyle(color: Colors.white),),
                onPressed: (){
                  print("name");
                  print(name);
                  final Map<String, dynamic> formDetails = {
                    'name': name,
                    'number': number,
                    'email': email,
                    'destination': destination,
                    'message': message,
                    'headCount': headCount,
                    'dateOfTravel': date,
                  };
                  submit(formDetails, context);
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  void submit(Map<String, dynamic> formDetails, BuildContext context){
    print(formDetails);
    http.post("http://192.168.43.115:2018/inquiryform",
      headers: {"Content-Type": "application/json"},
      body: json.encode(formDetails),
    ).then((http.Response response){
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);

      if(response.statusCode == 200){
        Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text("Form sent successfully"),
        ));
      }
    });
  }
}
