import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:someapp/items.dart';

class Stats {
  int id;
  String name;
  String branch;
  String uid;
  String fav;
  String regstatus;

  Stats({
    this.id,
    this.branch,
    this.name,
    this.uid,
    this.fav,
    this.regstatus,
  });
}

class StatsProvider with ChangeNotifier {
  List<Stats> events = [];

  Future<List<Stats>> getstat(String uid) async {
  print("called stats provider");
    List<Stats> ev=[];
    var url = "https://cosc-api.herokuapp.com/registered";
    var resp = await http.post(url,body:
    {
    'user_id':uid,
    }
    );
    var result = json.decode(resp.body) as List<dynamic>;
    print(result);
    result.forEach((e) {
      ev.add(Stats(
        id: e['event_id'],
        uid: e['user_id'],
        branch: e['event_branch'],
        name: e['event_name'],
        fav: e['isfav'],
        regstatus: e['registration_status'],
      ));
      events=ev;
    });
    // print('events');
    // print(ev[0].name);
    notifyListeners();
   return ev; 
  }
}
