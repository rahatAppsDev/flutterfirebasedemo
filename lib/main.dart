import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/crudScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';


import 'package:cloud_firestore/cloud_firestore.dart';


void main() async {
  print("hola");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(123);


  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(onPressed: () async {
              User firebaseUser;
              firebaseAuth.signInWithEmailAndPassword(email: "rahat@gmail.com", password: "123456").then((authResult) {
                setState(() {
                  firebaseUser = authResult.user;
                });
                print(firebaseUser.email);
                Navigator.push(context, MaterialPageRoute(builder: (_) => CrudScreen()));
              });
            },
            color: Colors.green,child: Text("CRUD screen"),),
            FlatButton(onPressed: _signInWithGoogle, child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Sign-in with google"),
            ),color: Colors.orange,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _signInWithGoogle() async {

    print("presseddddddd");
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken,accessToken: googleAuth.accessToken);
    final User user = (await firebaseAuth.signInWithCredential(credential)).user;

  }
}
