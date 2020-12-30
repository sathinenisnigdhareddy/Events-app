import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './items.dart';
import '../providers/events.dart';
class AllAvailable extends StatefulWidget {
 
  

  @override
  _AllAvailableState createState() => _AllAvailableState();
}

class _AllAvailableState extends State<AllAvailable> {
  var isinit=true;
  @override
  void didChangeDependencies()async {
    if(isinit){
      await Provider.of<EventProvider>(context,listen: false).getEvents();
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    var events=Provider.of<EventProvider>(context,listen: false).events;
    return Scaffold(
        body: Container(
            child: ListView.builder(
            itemCount: events.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              // Items item = snapshot.data[index];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          events[index].name,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(events[index].branch),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
    ));
  }
}

