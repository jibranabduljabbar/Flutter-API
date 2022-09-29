import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class Api extends StatefulWidget {
  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {
  getuser() async {
    List<dynamic> users = [];

    var response =
        await http.get(Uri.https("jsonplaceholder.typicode.com", "users"));
    var jsonData = jsonDecode(response.body);

    for (var i in jsonData) {
      UserModel user = UserModel(i["id"], i["name"], i["company"]["name"]);
      users.add(user);
    }

    return users;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.more_vert_outlined,color: Colors.white,),onPressed: (){
            print("More");
          },),
          actions:[ 
            IconButton(icon: Icon(Icons.notifications,color: Colors.white,),onPressed: (){
            print("Move to Notifications Page!");
          },)],
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text("Flutter API",style: GoogleFonts.sourceSansPro(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 20
          )),),
          body: FutureBuilder(
        future: getuser(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Container(
                child: Text("Nothing in API!"),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [

                  SizedBox(height: 10),

                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.white,
                            child: ListTile(
                              leading: CircleAvatar(backgroundColor: Colors.black,radius: 20,child: Text("${snapshot.data[index].id}",style: GoogleFonts.sourceSansPro(
                                color: Colors.white,
                                fontWeight: FontWeight.w900
                              ),)),
                              title: Text(snapshot.data[index].name,style: GoogleFonts.sourceSansPro(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 17
                              ),),
                              subtitle: Text("${snapshot.data[index].company}",style: GoogleFonts.sourceSansPro(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                              ),),
                              
                                              ),
                          ),
                        );
                      }),
                ],
              ),
            );
          }
        },
      )),
    );
  }
}

class UserModel {
  var id;
  var name;
  var company;

  UserModel(this.id, this.name, this.company);
}
