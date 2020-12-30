import 'package:flutter/material.dart';
import './rememberccpassword.dart';
import '../Animation/FadeAnimation.dart';
import './login_page.dart';
import './secondRoute.dart';
import './selectdash.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../providers/auth.dart';

class ThirdRoute extends StatelessWidget {
  var username = TextEditingController();

  var pswd = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.blue[900],
          Colors.blue[800],
          Colors.blue[400]
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "CC",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        FadeAnimation(
                            1.4,
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(32, 132, 232, .3),
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextField(
                                      controller:username,
                                      decoration: InputDecoration(
                                          hintText: "User ID",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextField(
                                      controller:pswd,
                                      obscureText:true,
                                      decoration: InputDecoration(                                          
                                          hintText: "Password",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        
                        GestureDetector(
                          onTap: () {
                            print('forget working working');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RememberCCPassword()),
                            );
                          },
                          child: Container(
                            child: FadeAnimation(
                                1.5,
                                Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: Colors.grey),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                          1.6,
                          FlatButton(
                            onPressed: () async {
                              print('object');
                              try {
                                await Provider.of<Auth>(context, listen: false)
                                    .cclogin(username.text, pswd.text);
                                var status = await Provider.of<Auth>(context,
                                        listen: false)
                                    .status;
                                print(status);
                                if (status) {
                                  Fluttertoast.showToast(
                                msg: "Login Success",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.white,
                                textColor: Colors.greenAccent,
                                fontSize: 14.0
                              );
                                  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectDash()),
                            );
                                }
                                else{
                                  Fluttertoast.showToast(
                              msg: "Login failed. Please check your details",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.white,
                              textColor: Colors.greenAccent,
                              fontSize: 14.0
                              );
                                  print('invalid creds');
                                }
                              } catch (error) {
                                print(error);
                              }
                              
                              // await Auth().login(username.text,pswd.text);

                              //    Navigator.push(
                              // context,
                              // MaterialPageRoute(builder: (context) => DashPage()),
                              //   );
                            

                              // await Auth().login(username.text,pswd.text);

                              //    Navigator.push(
                              // context,
                              // MaterialPageRoute(builder: (context) => DashPage()),
                              //   );
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.blue[900]),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(height: 60),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SecondRoute()),
                            );
                          },
                          child: Container(
                            child: FadeAnimation(
                                1.5,
                                Text(
                                  "Don't have an Account? Sign Up",
                                  style: TextStyle(color: Colors.grey),
                                )),
                          ),
                        ),
                        SizedBox(height: 50),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Begin()),
                            );
                          },
                          child: Container(
                            child: FadeAnimation(
                                1.5,
                                Text(
                                  "Registered User? Sign In",
                                  style: TextStyle(color: Colors.grey),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
