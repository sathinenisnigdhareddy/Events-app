import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:someapp/providers/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';


class DifferentPassword extends StatelessWidget {
  var uid = TextEditingController();
  var pswd= TextEditingController(); 
  var spswd=TextEditingController();
  @override

  Widget build(BuildContext context) {
    

    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(40),
                    child: Text(
                      'Change Password',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 28),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(60),
                    child: Text(
                      '',
                      style: TextStyle(fontSize: 14),
                    )),
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    controller: uid,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 0.0),
                      ),
                      labelText: 'Enter User ID',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    controller: pswd,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 0.0),
                      ),
                      labelText: 'Enter Password',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    controller: spswd,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 0.0),
                      ),
                      labelText: 'Confirm Password',
                    ),
                  ),
                ),
                Container(
                    height: 60,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.white)),
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Submit'),
                      onPressed: () {
                        print(uid.text);
                        print(pswd.text);
                        print(spswd.text);
                            if (pswd.text==spswd.text){
                            Provider.of<Auth>(context,listen: false).confirmpassword(uid.text,pswd.text);
                            Fluttertoast.showToast(
                                  msg: "Password Changed",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.greenAccent,
                                  fontSize: 14.0
                                    );
                            }
                            else{
                              Fluttertoast.showToast(
                                  msg: "Please check your password",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.greenAccent,
                                  fontSize: 14.0
                                    );
                            }
                      },
                    )),
              ],
            )));
  }
}
