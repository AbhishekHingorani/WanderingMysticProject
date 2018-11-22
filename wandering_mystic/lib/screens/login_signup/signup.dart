import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../data_models/scoped_models/main_model.dart';

class Signup extends StatefulWidget{

  @override
  State<StatefulWidget> createState() =>  _SignupState();

}

class _SignupState extends State<Signup>{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name;
  String email;
  String number;
  String password;
  String confirmPassword;
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomPadding: false,
        body:  Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              decoration:  BoxDecoration(
                image:  DecorationImage(
                  image:  AssetImage("assets/images/loginbackground.png"), 
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: ListView(
                padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                children: <Widget>[

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.53,
                  ),

                  Container(
                    padding: const EdgeInsets.only(top: 5.0),
                    alignment: Alignment.center,
                    height: 60.0,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(100.0),
                        boxShadow: [
                          new BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              blurRadius: 10.0,
                              offset: Offset(0.0, 3.0)
                          )
                        ]
                    ),

                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Full Name",
                      ),
                      onSaved: (val){
                        name = val;
                      }
                    )
                  ),


                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    padding: const EdgeInsets.only(top: 5.0),
                    alignment: Alignment.center,
                    height: 60.0,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(100.0),
                        boxShadow: [
                          new BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              blurRadius: 10.0,
                              offset: Offset(0.0, 3.0)
                          )
                        ]
                    ),

                    child: TextFormField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Email",
                      ),
                      validator: _validateEmail,
                      onSaved: (val){
                        email = val;
                      }
                    )
                  ),


                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    padding: const EdgeInsets.only(top: 5.0),
                    alignment: Alignment.center,
                    height: 60.0,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(100.0),
                        boxShadow: [
                          new BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              blurRadius: 10.0,
                              offset: Offset(0.0, 3.0)
                          )
                        ]
                    ),

                    child: TextFormField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Ph. Number",
                      ),
                      onSaved: (val){
                        number  = val;
                      }
                    )
                  ),


                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    padding: const EdgeInsets.only(top: 5.0),
                    alignment: Alignment.center,
                    height: 60.0,
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(100.0),
                        boxShadow: [
                          new BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              blurRadius: 10.0,
                              offset: Offset(0.0, 3.0)
                          )
                        ]
                    ),

                    child: TextFormField(
                      obscureText: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Password",
                      ),
                      onSaved: (val){
                        password = val;
                      }
                    )
                  ),

                  //confirmPassword
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    padding: const EdgeInsets.only(top: 5.0),
                    alignment: Alignment.center,
                    height: 60.0,
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(100.0),
                        boxShadow: [
                          new BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.25),
                              blurRadius: 10.0,
                              offset: Offset(0.0, 3.0)
                          )
                        ]
                    ),

                    child: TextFormField(
                      obscureText: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Confirm Password",
                      ),
                      validator: _validatePassword,
                      onSaved: (val){
                        confirmPassword = val;
                      }
                    )
                  ),


                  Container(
                    margin: EdgeInsets.only(top: 40.0, bottom: 5.0),
                    padding: const EdgeInsets.only(top: 5.0),
                    alignment: Alignment.center,
                    height: 60.0,
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: new BoxDecoration(
                        gradient: new LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color.fromRGBO(235, 139, 123, 1.0),
                            Color.fromRGBO(255, 140, 90, 1.0)
                          ],
                        ),
                        borderRadius: new BorderRadius.circular(100.0),
                        boxShadow: [
                          new BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.3),
                              blurRadius: 10.0,
                              offset: Offset(0.0, 10.0)
                          )
                        ]
                    ),

                    child: ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model){
                      return model.isLoggingIn ? 
                      CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white), 
                        strokeWidth: 2.0,
                      ) : 
                      InkWell(
                        onTap: (){
                          _validateInputs(model.signup);
                        },
                        child: Text(
                          "Signup",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }),
                  ),

                ],
              ),
            ),

          ],
        )
    );
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Enter email address";
    }
    // This is just a regular expression for email addresses
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }

    // The pattern of the email didn't match the regex above.
    return 'Email is not valid';
  }

  String _validatePassword(String value) {
    if (password == confirmPassword){
      return null;
    }
    return "Passwords don't match";
  }

  void _validateInputs(Function signup) {
    final form = _formKey.currentState;
    if (form.validate()) {
      // Text forms was validated.
      form.save();
      //login(email, password);
      signup(name, email, number, password);
    } 
    else {
      setState(() => _autoValidate = true);
    }
  }//
}