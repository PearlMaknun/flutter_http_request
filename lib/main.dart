import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //menghandle http req
import 'dart:async';
import 'dart:convert'; //konversi http respon ke json format

/**
 * Author: Lu'lu' Al-Maknun
 * Course: Youtube Video
 * data from: https://reqres.in/
 */

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(title: 'Http Request'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map data;
  List userData;

  Future getData() async {
    http.Response response =
        await http.get("https://reqres.in/api/users?page=2");
    data = json.decode(response.body);
    //debugPrint(response.body);
    setState(() {
      userData = data["data"];
    });
    debugPrint(userData.toString());
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: userData == null ? 0 : userData.length,
        itemBuilder: (BuildContext context, int index) {
          /*return Card(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(24.0),
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(userData[index]["avatar"]),
                ),
              ],
            ),
          );*/
          return Card(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircleAvatar(
                    radius: 54.0,
                    backgroundImage: NetworkImage(userData[index]["avatar"]),
                  ),
                ),
                Text(
                    "${userData[index]["first_name"]} ${userData[index]["last_name"]}")
              ],
            ),
          );
        },
      ),
    );
  }
}
