import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Flutter Demo',

      theme: ThemeData(
          textTheme: TextTheme(

          )

        // primarySwatch: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(
        title: 'SPORTS HEADLINES ',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Map data;
  List userdata;

  Future<String> getData() async{
    http.Response response=await http.get("https://newsapi.org/v2/top-headlines?country=in&category=sports&apiKey=dc9a30994bd5431488d9a5bab6644ffd");
   debugPrint(response.body);
    data=json.decode(response.body);

    setState(() {
      userdata=data["articles"];
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {


    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
            title: Text(
              widget.title,
              style: TextStyle(color: new Color(0xFF3d3c3c)),
            ),
            centerTitle: true,
            backgroundColor: new Color(0xFFf6f8f8),
           ),
        body: ListView.builder(

          itemCount:  userdata==null ? 0   : userdata.length,itemBuilder: (BuildContext context, int index){
          return  new GestureDetector(
              onTap: () {
                Navigator.push(context, new MaterialPageRoute(
                  builder: (BuildContext context)=> new Page1(userdata[index]),
                )

                );
              },
            child:Card(

              child:Padding(
                  padding: const EdgeInsets.all(20.0),

                  child: Column(
                    children: <Widget>[
                      Image.network(

                        userdata[index]['urlToImage'],
                        fit: BoxFit.cover,
                        height: 250.0,
                        width: double.infinity,
                        //backgroundImage: NetworkImage(userdata[index]["urlToImage"]),
                      ),


                      Text("${userdata[index]["title"]} ",
                        style: TextStyle(

                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ),
                      )

                    ],
                  )

              )));
        },

        )
    );

  }
}
class Page1 extends StatelessWidget{

  Page1(this.userdata);
  Map data;
  final userdata;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'In Details',
            style: TextStyle(color: new Color(0xFF3d3c3c)),
          ),
          centerTitle: true,
          backgroundColor: new Color(0xFFf6f8f8),
        ),
        body: new Column(
          children: <Widget>[
            Card(

                child:Padding(
                    padding: const EdgeInsets.all(20.0),

                    child: Column(
                      children: <Widget>[
                        Image.network(userdata['urlToImage'],
                          fit: BoxFit.cover,
                          height: 250.0,
                          width: double.infinity,
                          //backgroundImage: NetworkImage(userdata[index]["urlToImage"]),
                        ),


                        Text("${this.userdata["title"]} ",
                          style: TextStyle(

                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          //width: 200.0,
                          height: 30.0,
                          //child: const Card(child: Text('Hello World!')),
                        ),
                        Text("${this.userdata["content"]} ",
                            style: TextStyle(

                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    )

                ))
          ],
        ),

      ),
    );
  }
}