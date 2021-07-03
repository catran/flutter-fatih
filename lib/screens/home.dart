import 'package:chat_application/components/categories.dart';
import 'package:chat_application/components/custom_appbar.dart';
import 'package:chat_application/components/header_title.dart';
import 'package:chat_application/components/search_widget_home.dart';
import 'package:chat_application/components/subtitle_text.dart';
import 'package:chat_application/components/top_doctors.dart';
import 'package:chat_application/screens/detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

String _profilad = "";
String _isim = "umut 17074";
String name = "";
String uzmanlikAlani = "";
final List<String> nameList = <String>["item 1 "];
final List<String> uzmanList = <String>["item 1 "];
final List<String> hakkimdaList = <String>["item 1 "];
int uzmansayac = 0;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    getUsers();
    //getDanisman();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(),
        preferredSize: Size(MediaQuery.of(context).size.width, 60),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.white),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            HeaderTitle(),
            SearchWidgetHome(),

            SubtitleText(title: "Kategoriler"),
            Categories(),
            SubtitleText(title: "Popülerler"),
            TopDoctor(),
            Text(loginUserName),
            for (var i in nameList)
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(38.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.pinkAccent,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),

                              FlatButton(
                                onPressed: SetUserName(i.toString()),
                                child: Text(
                                  i.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),

                              //Text(uzmanList[uzmansayac++]),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 21.0,
                    )
                  ],
                ),
              ),
            //RaisedButton(onPressed: _profilad)
          ],
        ),
      ),
    );
  }

  Widget getUsers() {
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        name = doc["name"].toString();
        nameList.add(name);
        //uzmanlikAlani = doc["UzmanlikAlani"].toString();
        //uzmanList.add(uzmanlikAlani);
        String hakkimda = doc["Hakkımda"].toString();
        hakkimdaList.add(hakkimda);
        hakkimdaList.forEach((element) {
          hakkimda1 = element.toString();
        });
      });
      print("OK!");
      nameList.forEach((element) {
        print(element + "element");
      });
      // bu kısım return olmuyot galiba
    });

    // uzmnalık için liste
  }
/*
  Widget getDanisman() {
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        uzmanlikAlani = doc["UzmanlikAlani"].toString();
        uzmanList.add(uzmanlikAlani);
      });
      print("OK!");
      nameList.forEach((element) {
        print(element + "element");
      });
    });
  }
 */

  SetUserName(String name) {
    loginUserName = name;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DetailScreen()));
  }

  SetHakkimda(String hakkimda) {
    hakkimda1 = hakkimda;
  }
}
