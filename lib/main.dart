
import 'package:flutter/material.dart' ;
import 'package:date_time/10min.dart' as first;
import 'package:date_time/20_min.dart' as second;
import 'package:date_time/30_min.dart' as third;
void main() => runApp(MaterialApp(
      home: MyApp(),
      theme: ThemeData(
        canvasColor: Colors.blueGrey,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        accentColor: Colors.pinkAccent,
        brightness: Brightness.dark,
      ),
      routes: <String, WidgetBuilder>{
          '/mytabs1' : (BuildContext context)=> new first.MyApp10(),
          '/mytabs2' : (BuildContext context)=> new second.MyApp10(),
          '/mytabs3' : (BuildContext context)=> new third.MyApp10(),
          },
          //add more routes here
        
    ));

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Timings();
}


class Timings extends State<MyApp>{
  get child => null;

  @override 
  Widget build(BuildContext context)
  {
    ThemeData themeData=Theme.of(context);
            return Scaffold(
              appBar: AppBar(
                title: const Text('PauzR',style: TextStyle(fontSize: 30,color: Colors.white),),
                centerTitle: true,
                backgroundColor: Colors.redAccent,
                ),
            
          body: 
          Center(
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                child: Text('10 min.\n  5 points',
                style: TextStyle(fontSize: 20),),
                onPressed: () {
                  Navigator.of(context).pushNamed('/mytabs1');
                },
                padding: EdgeInsets.only(top:15.0),
                
                ),
                
                RaisedButton(
                child: Text('20 min \n10 points',
                style: TextStyle(fontSize: 20),),
                onPressed: () {
                  Navigator.of(context).pushNamed('/mytabs2');
                },
                padding: EdgeInsets.only(top:15.0),
                ),
                
                RaisedButton(
                child: Text('30 min\n20 points',
                style: TextStyle(fontSize: 20),),
                onPressed: () {
                  Navigator.of(context).pushNamed('/mytabs3');
                },
                padding: EdgeInsets.only(top:15.0),
                ),
              ],
            ),
            ),
            
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }

}

