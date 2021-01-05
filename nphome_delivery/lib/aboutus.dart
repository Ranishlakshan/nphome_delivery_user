import 'package:flutter/material.dart';

import 'components/bottomnecbar.dart';
import 'drawer.dart';

class AboutUS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNvBar(),
		  appBar: AppBar(
		  backgroundColor: Colors.amber[400],
		  title: Text("About Us"),
		  ),
      drawer: MyDrawer(),
      body: GridView.count(
	  	crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 8.0,
        children: <Widget>[
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, '/aboutApplication');
            },
            child: Card(
            child: Column(
              children: <Widget>[
                SizedBox(height: 30,),
                Icon(Icons.apps,size: 50,color: Colors.red),
                SizedBox(height: 20,),
                Text("Our Application"),
                SizedBox(height: 20,),
                Text("ඇප් එක ගැන"),
                SizedBox(height: 20,),
                
              ],
            ),
          ),
          ),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, '/ourteam');
            },
            child: Card(
            child: Column(
              children: <Widget>[
                SizedBox(height: 30,),
                Icon(Icons.group,size: 50,color: Colors.red,),
                SizedBox(height: 20,),
                Text("Our Team"),
                SizedBox(height: 20,),
                Text(" ටීම් එක"),
                SizedBox(height: 20,),
              ],
            ),
          ),
          ),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, '/ourlocation');
            },
            child: Card(
            child: Column(
              children: <Widget>[
                SizedBox(height: 30,),
                Icon(Icons.location_on,size: 50,color: Colors.red,),
                SizedBox(height: 20,),
                Text("Our Locations"),
                SizedBox(height: 20,),
                Text("Shop එක තියන තැන"),
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