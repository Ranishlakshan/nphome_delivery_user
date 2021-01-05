import 'package:flutter/material.dart';

import 'components/bottomnecbar.dart';
import 'drawer.dart';


class PharmacyInterface extends StatelessWidget {

// This widget is the root of your application
@override
Widget build(BuildContext context) {
	return Scaffold(
    bottomNavigationBar: BottomNvBar(),
		appBar: AppBar(
		backgroundColor: Colors.amber[400],
		title: Text("My Pharmacy"),
		),
    drawer: MyDrawer(),
		body: GridView.count(
	  	crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 8.0,
        children: <Widget>[
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, '/addPharmacyScript');
            },
            child: Card(
            child: Column(
              children: <Widget>[
                SizedBox(height: 30,),
                Icon(Icons.note_add,size: 40,color: Colors.red),
                SizedBox(height: 20,),
                Text("Send a Prescription"),
                SizedBox(height: 20,),
                Text("බෙහෙත් ලබාගැනීම"),
                SizedBox(height: 20,),
                
              ],
            ),
          ),
          ),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, '/pharmacyHistory');
            },
            child: Card(
            child: Column(
              children: <Widget>[
                SizedBox(height: 30,),
                Icon(Icons.note_add,size: 40,color: Colors.red,),
                SizedBox(height: 20,),
                Text("My History"),
                SizedBox(height: 20,),
                Text("පෙර ලබා ගත් බෙහෙත්"),
                SizedBox(height: 20,),
              ],
            ),
          ),
          ),
          //InkWell(
          //  child: Card(
          //  child: Column(
          //    children: <Widget>[
          //      Text(" sdfdsf")
          //    ],
          //  ),
          //),
          //),
          
        ],
		),
	
	);
}
}
