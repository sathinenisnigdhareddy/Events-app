import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:someapp/items.dart';

class Events {
  int id;
  String name;
  String branch;
  String club;
  String desc;
  String venue;
  String location;
  Events({
    this.id,
    this.branch,
    this.club,
    this.desc,
    this.location,
    this.name,
    this.venue,
  });
}

class EventProvider with ChangeNotifier {
  List<Events> events = [];

  Future<void> getEvents() async {
    List<Events> ev=[];
    var url = "https://cosc-api.herokuapp.com/events";
    var resp = await http.get(url);
    var result = json.decode(resp.body) as List<dynamic>;
    print(result);
    result.forEach((e) {
      ev.add(Events(
        branch: e['event_branch'],
        club: e['club_name'],
        desc: e[' event_description'],
        id: e['event_id'],
        location: e['event_loc'],
        name: e['event_name'],
        venue: e['event_venue'],
      ));
      events=ev;
    });
    print('events');
    print(ev);
    notifyListeners();
  }
}
