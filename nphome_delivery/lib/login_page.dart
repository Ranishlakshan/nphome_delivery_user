import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'admydata.dart';
import 'db_components/car_item_model.dart';
import 'firstpg.dart';
import 'firstpgtemp.dart';



String name;
String email;
String imageUrl;

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

//
  
//

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  @override
  void initState() {
    // TODO: implement initState
    //if(email==null){
//
    //  print("NO EMAIL");
    //}
    //else{
    //  print("I HAVE EMAIL"+ '$email');
    //}
    //super.initState();
    

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            
              FlutterLogo(size: 150),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
    signInWithGoogle().whenComplete(() {
      Navigator.of(context).push(
        //newly added for remove unregistered users
        MaterialPageRoute(
          builder: (context) {
            //start new add 
                        //checkuser=true;
                        //print("RANISH ::::::::::::::::"+yesno);
                        //if(yesno.contains('yes')){
                        //   return FirstPage();
                        //}
                        //else{
                        //  return AddMyDetails();
                        //}
                        //-end new add
                        //return FirstPageTemp();
                        return FirstPage();
                      },
                    ),
                  );
                });
              },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                  highlightElevation: 0,
                  borderSide: BorderSide(color: Colors.grey),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Sign in with Google',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            
              
}

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;
  //
  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);
  
  name = user.displayName;
  email = user.email;
  imageUrl = user.photoUrl;
  
  // Only taking the first part of the name, i.e., First Name
  if (name.contains(" ")) {
     name = name.substring(0, name.indexOf(" "));
}
  //

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);
  //checkuser =true;
  return 'signInWithGoogle succeeded: $user';
}

Future<String> signInWithGoogleFirst() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;
  //
  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);
  
  name = user.displayName;
  email = user.email;
  imageUrl = user.photoUrl;
  
  // Only taking the first part of the name, i.e., First Name
  if (name.contains(" ")) {
     name = name.substring(0, name.indexOf(" "));
}
  //

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  return 'signInWithGoogle succeeded: $user';
}



void signOutGoogle() async{
  await googleSignIn.signOut();

  print("User Sign Out");
}