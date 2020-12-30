import 'package:flutter/material.dart';
import 'package:someapp/screens/statpay.dart';
import './thirdRoute.dart';
import './newevent.dart';
import './makediffevents.dart';
import './vanquishevents.dart';
import './DifferentPassword.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
class SelectDash extends StatelessWidget {
  static const routeNamed='/dashboards';
  @override
  Widget build(BuildContext context) {
    var username=Provider.of<Auth>(context).username;
    username=username.toString().split(' ')[0];
    username=username[0].toString().toUpperCase()+username.toString().substring(1);
    return Scaffold(
      backgroundColor: Color(0xFFEF6C00),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ThirdRoute()),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Row(
              children: <Widget>[
                Text('Welcome',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0)),
                SizedBox(width: 10.0),
                Text(username!=null?username:'User',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: 25.0))
              ],
            ),
          ),
          SizedBox(height: 40.0),
          Container(
            height: MediaQuery.of(context).size.height - 185.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(left: 25.0, right: 20.0, top: 60),
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.event),
                  title: Text('Add new event'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewEvents()),
                    );
                  },
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit existing event'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Makediferentevents()),
                    );
                  },
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                ListTile(
                  leading: Icon(Icons.event_busy),
                  title: Text('Delete event'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Vanquishevents()),
                    );
                  },
                ),
                Padding(padding: EdgeInsets.only(top: 29.0)),
                ListTile(
                  leading: Icon(Icons.security),
                  title: Text('Change Password'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DifferentPassword()),
                    );
                  },
                ),
                Padding(padding: EdgeInsets.only(top: 36.0)),
                ListTile(
                  leading: Icon(Icons.people_outline),
                  title: Text('View stats of interested people'),
                   onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StatPay()),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}