import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './login_page.dart';
import './allavailableEvents.dart';
import './rememberuserpassword.dart';
import './inevent.dart';
import './QRscanner.dart';
import '../providers/events.dart';
import '../providers/auth.dart';
import 'inevent.dart';
import './yesfavorite.dart';

class DashPage extends StatelessWidget {
  static const routeName='/dashboard';
  @override
  Widget build(BuildContext context) {
     var username=Provider.of<Auth>(context).username;
    username=username.toString().split(' ')[0];
    username=username[0].toString().toUpperCase()+username.toString().substring(1);
    return Scaffold(
      backgroundColor: Color(0xFF21BFBD),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  child:
                   Row(
                     children: <Widget>[
                       Icon(Icons.arrow_back_ios,color: Colors.white,),
                       SizedBox(width: 5,),
                       Text('Logout',style: TextStyle(
                         color: Colors.white,
                         fontSize: 18
                       ),),
                     ],
                   ), 
                  color: Color(0xFF21BFBD),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Begin()),
                    );
                  },
                ),
                Container(
                    width: 125.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ))
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
                  title: Text('View all events'),
                  onTap: () async{
                    await Provider.of<EventProvider>(context,listen: false).getEvents();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AllAvailable()),
                    );
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                  },
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                ListTile(
                  leading: Icon(Icons.event_available),
                  title: Text('Register for Event'),
                  onTap: () {Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InEvent()),
                      );},
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('Set Favourite'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => YesFavorite()),
                      );
                  },
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('Display Favourite'),
                  onTap: () {
                  },
                ),
                Padding(padding: EdgeInsets.only(top: 22.0)),
                ListTile(
                    leading: Icon(Icons.update),
                    title: Text('QR Code'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                      );
                    }),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                ListTile(
                  leading: Icon(Icons.security),
                  title: Text('Change Password'),
                  onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RememberUserPassword()),
                      );
                    }
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
