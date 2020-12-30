import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User{
  String id;
  String name;
  int clubId;
  String phno;
  String email;
}

class Auth with ChangeNotifier{
  bool status=false;
  var uid;
  var username;
  Future<void> login(String uname,String pswd)async{
    print("login api calling");
    try{
      var url="https://cosc-api.herokuapp.com/userlogin";
    var resp=await http.post(url,body: {
      'user_id':uname,
      'password':pswd,
      'role':'user',
    });
    print(json.decode(resp.body));
    uid=json.decode(resp.body)['details'][0]['user_id'];
    username=json.decode(resp.body)['details'][0]['name'];
    var op=json.decode(resp.body)['message'];
    if(op=='Succesful'){
      status=true;
    }
    else{
      status=false;
    }
    }
    catch(error){
      throw error;
    }
    
    notifyListeners();
  }

  Future<void> cclogin(String uname,String pswd) async{
    print("login api calling");
    try{
      var url="https://cosc-api.herokuapp.com/cclogin";
    var resp=await http.post(url,body: {
      'user_id':uname,
      'password':pswd,
      'role':'CC',
    });
    print(json.decode(resp.body));
    var op=json.decode(resp.body)['message'];
    uid=json.decode(resp.body)['details'][0]['roll_no'];
    username=json.decode(resp.body)['details'][0]['name'];
    print(uid);
    if(op=='ALLOW ACCESS !!'){
      status=true;
    }
    else{
      status=false;
    }
    }
    catch(error){
      throw error;
    }
    
    notifyListeners();
  }
  Future<void> signup(String uid,String uname,String pswd,String phno,String email,) async{
    print('calling singup api ');
    var url="https://cosc-api.herokuapp.com/signup";
    var resp=await http.post(url,body: {
      'user_id':uid,
      'name':uname,
      'email':email,
      'password':pswd,
      'phone_no':phno,
    });
    print(resp.body);
  }

  Future<void> addevent(String uid,String name,String des,String cname,String binfo) async{
    print('calling addevent api ');
    var url="https://cosc-api.herokuapp.com/addevent";
    var resp=await http.post(url,body: {
      'event_id':uid,
      'event_name':name,
      'event_branch':binfo,
      'club_name':cname,
      'event_description':des,
      'event_venue':'Hyderabad',
      'event_loc':'Hyderabad',
    });
    print(resp.body);
  }
  Future<void> deleteevent(String uid) async{
    print('calling delete api ');
    var url="https://cosc-api.herokuapp.com/deleteevent";
    var resp=await http.post(url,body: {
      'event_id':uid,
    });
    print(resp.body);
  }
  Future<void> editevent(String uid,String name,String des,String cname,String binfo) async{
    print('calling editevent api ');
    var url="https://cosc-api.herokuapp.com/editevent";
    var resp=await http.post(url,body: {
      'event_id':uid,
      'event_name':name,
      'event_branch':binfo,
      'club_name':cname,
      'event_description':des,
      'event_venue':'Hyderabad',
      'event_loc':'Hyderabad',
    });
    print(resp.body);
  }
  Future<void> valevent(String uid,String name,String binfo) async{
    print('calling valevent api ');
    var url="https://cosc-api.herokuapp.com/registration";
    var resp=await http.post(url,body: {
      'user_id':uid,
      'event_name':name,
      'event_branch':binfo,
    });
    print(resp.body);
  }
  Future<void> confirmpassword(String uid,String pswd) async{
    print('calling confirmpassword api ');
    var url="https://cosc-api.herokuapp.com/changepassword";
    var resp=await http.post(url,body: {
      'user_id':uid,
      'password':pswd,
    });
    print(resp.body);
  }
  Future<void> setfavourite(String uid,String name,String binfo) async{
    print('calling favourites api ');
    var url="https://cosc-api.herokuapp.com/favourites";
    var resp=await http.post(url,body: {
      'user_id':uid,
      'event_name':name,
      'event_branch':binfo,
    });
    print(resp.body);
  }
  Future<void> findpassword(String uid) async{
    print('calling confirmpassword api ');
    var url="https://cosc-api.herokuapp.com/userforgotpassword";
    var resp=await http.post(url,body: {
      'user_id':uid,
    });
    print(resp.body);
  }
  Future<void> findccpassword(String uid) async{
    print('calling confirmpassword api ');
    var url="https://cosc-api.herokuapp.com/ccforgotpassword";
    var resp=await http.post(url,body: {
      'roll_no':uid,
    });
    print(resp.body);
  }
}