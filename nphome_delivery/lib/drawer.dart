import 'package:flutter/material.dart';

import 'Authenication.dart';
import 'login_page.dart';

class MyDrawer extends StatefulWidget {
MyDrawer({
    this.auth,
    this.onSignedOut,
  });
  final AuthImplementation auth;
  final VoidCallback onSignedOut;


  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  
  String name123 = "$name";
  String email123 = '$email';
  String photourl = "$imageUrl";
  String signinORnot=" ";

  void _logOutUser() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e.toString());
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Drawer( 
            
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.amber[400],
              ),
              //accountName: Text("$name"),
              accountName: "$name".contains("null") ? Text("User Not Signed IN"):Text("$name"),
              //accountName: name123.contains(null) ? Text("data") : Text(name123),
              accountEmail: "$email".contains("null") ? Text(" "):Text("$email"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("$imageUrl"),
              ),
            ),
            //aliexpresspg
            SizedBox(height: 20,),
            Container(
              child: InkWell(
                onTap: (){
                  Navigator.pushNamed(context, '/firstpage');
                },
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 30,),
                    Icon(Icons.home,color: Colors.yellow,),
                    SizedBox(width: 20,),
                    Text("HomePage", style: TextStyle(fontSize: 20.0 ),)
                  ],
                ),
              ),
            ),
            Text('           _____________________________________________'),
            SizedBox(height: 20,),
            Container(
              child: InkWell(
                onTap: (){
                  Navigator.popAndPushNamed(context, '/hotdeals');
                },
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 30,),
                    Icon(Icons.favorite,color: Colors.red,),
                    SizedBox(width: 20,),
                    Text("Hot Deals", style: TextStyle(fontSize: 20.0 ),)
                  ],
                ),
              ),
            ),
            Text('           _____________________________________________'),
            SizedBox(height: 20,),
            Container(
              child: InkWell(
                onTap: (){
                  Navigator.popAndPushNamed(context, '/myorders');
                },
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 30,),
                    Icon(Icons.add_shopping_cart,color: Colors.blue,),
                    SizedBox(width: 20,),
                    Text("My Orders", style: TextStyle(fontSize: 20.0 ),)
                  ],
                ),
              ),
            ),
            //Text('           _____________________________________________'),
            //SizedBox(height: 20,),
            //Container(
            //  child: InkWell(
            //    onTap: (){
            //      Navigator.pushNamed(context, '/categories');
            //    },
            //    child: Row(
            //      children: <Widget>[
            //        SizedBox(width: 30,),
            //        Icon(Icons.category,color: Colors.green,),
            //        SizedBox(width: 20,),
            //        Text("Categories", style: TextStyle(fontSize: 20.0 ),)
            //      ],
            //    ),
            //  ),
            //),
            //Text('           _____________________________________________'),
            //SizedBox(height: 20,),
            ////admydetails
            //Container(
            //  child: InkWell(
            //    onTap: (){
            //      Navigator.popAndPushNamed(context, '/admydetails');
            //    },
            //    child: Row(
            //      children: <Widget>[
            //        SizedBox(width: 30,),
            //        Icon(Icons.add,color: Colors.purple,),
            //        SizedBox(width: 20,),
            //        Text("Ad My Details", style: TextStyle(fontSize: 20.0 ),)
            //      ],
            //    ),
            //  ),
            //),
            //mydetailsInterface
            Text('           _____________________________________________'),
            SizedBox(height: 20,),
            //admydetails
            Container(
              child: InkWell(
                onTap: (){
                  Navigator.popAndPushNamed(context, '/mydetailsInterface');
                },
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 30,),
                    Icon(Icons.add,color: Colors.purple,),
                    SizedBox(width: 20,),
                    Text("Ad My Details", style: TextStyle(fontSize: 20.0 ),)
                  ],
                ),
              ),
            ),
            //addPharmacyScript
            //Text('           _____________________________________________'),
            //SizedBox(height: 20,),
            //Container(
            //  child: InkWell(
            //    onTap: (){
            //      Navigator.popAndPushNamed(context, '/addPharmacyScript');
            //    },
            //    child: Row(
            //      children: <Widget>[
            //        SizedBox(width: 30,),
            //        Icon(Icons.local_pharmacy,color: Colors.red,),
            //        SizedBox(width: 20,),
            //        Text("Pharmacy", style: TextStyle(fontSize: 20.0 ),)
            //      ],
            //    ),
            //  ),
            //),
            //pharmacyInterface
            Text('           _____________________________________________'),
            SizedBox(height: 20,),
            Container(
              child: InkWell(
                onTap: (){
                  Navigator.popAndPushNamed(context, '/pharmacyInterface');
                },
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 30,),
                    Icon(Icons.local_pharmacy,color: Colors.red,),
                    SizedBox(width: 20,),
                    Text("Pharmacy", style: TextStyle(fontSize: 20.0 ),)
                  ],
                ),
              ),
            ),
            
            Text('           _____________________________________________'),
            SizedBox(height: 20,),
            Container(
              child: InkWell(
                onTap: (){
                  Navigator.popAndPushNamed(context, '/aboutus');
                },
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 30,),
                    Icon(Icons.details,color: Colors.blue,),
                    SizedBox(width: 20,),
                    Text("About Us", style: TextStyle(fontSize: 20.0 ),)
                  ],
                ),
              ),
            ),
            //Container(
            //  child: InkWell(
            //    onTap: (){
            //      Navigator.popAndPushNamed(context, '/login');
            //    },
            //    child: Row(
            //      children: <Widget>[
            //        SizedBox(width: 30,),
            //        Icon(Icons.input,color: Colors.blue,),
            //        SizedBox(width: 20,),
            //        Text("Log In", style: TextStyle(fontSize: 20.0 ),)
            //      ],
            //    ),
            //  ),
            //),
            //onPressed: _logOutUser,
            //Container(
            //  child: InkWell(
            //    onTap: _logOutUser,
            //    child: Row(
            //      children: <Widget>[
            //        SizedBox(width: 30,),
            //        Icon(Icons.input,color: Colors.blue,),
            //        SizedBox(width: 20,),
            //        Text("Log Out", style: TextStyle(fontSize: 20.0 ),)
            //      ],
            //    ),
            //  ),
            //),
            
            //ListTile(
            //  title: Text('Post a AD'),
            //    
            //  onTap: () {
            //    // Update the state of the app
            //    // ...
            //    //Navigator.pushNamed(context, '/login');
            //    // Then close the drawer
            //    Navigator.pop(context);
            //  },
            //),
            
            
          ],
        ),
      );
  }

}