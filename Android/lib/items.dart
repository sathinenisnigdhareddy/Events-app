// To parse this JSON data, do
//
//     final items = itemsFromJson(jsonString);

import 'dart:convert';

List<Items> itemsFromJson(String str) => List<Items>.from(json.decode(str).map((x) => Items.fromJson(x)));

String itemsToJson(List<Items> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Items {
    Items({
        this.event,
        this.dateTime,
    });

    String event;
    String dateTime;

    factory Items.fromJson(Map<String, dynamic> json) => Items(
        event: json["Event"],
        dateTime: json["Date;Time"],
    );

    Map<String, dynamic> toJson() => {
        "Event": event,
        "Date;Time": dateTime,
    };
}
