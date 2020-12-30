import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './items.dart';
import '../providers/showstat.dart';
import '../providers/auth.dart';
class StatPay extends StatefulWidget {
 
  

  @override
  _StatPay createState() => _StatPay();
}

class _StatPay extends State<StatPay> {
  // var isinit=true;
  // @override
  // void didChangeDependencies()async {
  //   if(isinit){
  //     await Provider.of<StatsProvider>(context,listen: false).getstat();
  //   }
  //   super.didChangeDependencies();
  // }
  @override
  Widget build(BuildContext context) {
    // var events=Provider.of<StatsProvider>(context,listen: false).events;
    var uid=Provider.of<Auth>(context,listen: false).uid;
    return Scaffold(
        body: FutureBuilder(
          future: Provider.of<StatsProvider>(context,listen: false).getstat(uid) ,
          builder:(ctx,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child:CircularProgressIndicator()
              );
            }
            List<Stats> events=snapshot.data;
            print(events[0].name);
            return    
        Container(
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
                        Text(events[index].regstatus.toString()),
                        Text(events[index].branch.toString()),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
    );
          } ,
        )
     
    );
  }
}

