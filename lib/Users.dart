import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List user;
  Map datas;
  Future setUser() async {
    String url ="https://pixabay.com/api/?key=14001068-da63091f2a2cb98e1d7cc1d82&q=beautiful&image_type=photo&pretty=true";
    http.Response response = await http.get(url);
    datas = json.decode(response.body);
    debugPrint(response.body);
    setState(() {
    //  user  = json.decode(response.body); 
       user = datas['hits'];
    });
  }
  @override
  void initState() {
    super.initState();
    setUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User information"),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemCount: user == null ? 0 : user.length,
        itemBuilder: (BuildContext context, int i){
          return Card(
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage("${user[i]["previewURL"]}"),
                      ),
                      Text("${user[i]["user"]}"),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Image.network("${user[i]["largeImageURL"]}",
                            fit: BoxFit.cover,
                            width: 383,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}