


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CrudScreen extends StatefulWidget {
  @override
  _CrudScreenState createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  Map data = {'Usrname':'tom','Password':'pass@123'};

  addData() {
    Map<String,dynamic> demoData = {"name": "rahat", "motto": "chill bro!"};

    CollectionReference collectionReference = FirebaseFirestore.instance.collection('data');
    collectionReference.add(demoData);
    print("added");

  }


  fetchData() {

    CollectionReference collectionReference = FirebaseFirestore.instance.collection('data');
    collectionReference.snapshots().listen((snapshot) {
      setState(() {
        data = snapshot.docs[0].data();
      });
      print(data);

    });

  }

  deleteData() async {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('data');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.delete();
    collectionReference.snapshots().listen((snapshot) {
      setState(() {
        data = {};
      });
      print(data);
  });}

  updateData() async {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('data');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.update({"name": "kapoor","motto": "hadippa"});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 90,),
              MaterialButton(onPressed: fetchData,
                height: 50,
                minWidth: double.maxFinite,
                color: Colors.amber[900],
                child: Text("Fetch data",style: TextStyle(color: Colors.white),),
              ),
              SizedBox(height: 20,),
              MaterialButton(onPressed: addData,
                height: 50,
                minWidth: double.maxFinite,
                color: Colors.pink[900],
                child: Text("Add data",style: TextStyle(color: Colors.white),),
              ),
              SizedBox(height: 20,),
              MaterialButton(onPressed: updateData,
                height: 50,
                minWidth: double.maxFinite,
                color: Colors.orange[900],
                child: Text("Update data",style: TextStyle(color: Colors.white),),
              ),
              SizedBox(height: 20,),
              MaterialButton(onPressed: deleteData,
                height: 50,
                minWidth: double.maxFinite,
                color: Colors.red[900],
                child: Text("Delete data",style: TextStyle(color: Colors.white),),
              ),
              SizedBox(height: 20,),
              Text(data['name'].toString(),textAlign: TextAlign.center,)

            ],
          ),
        ),
      ),
    );
  }
}
