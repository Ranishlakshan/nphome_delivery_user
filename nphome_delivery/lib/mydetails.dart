import 'package:flutter/material.dart';

import 'components/bottomnecbar.dart';
import 'db_components/car_item_model.dart';
import 'drawer.dart';
import 'login_page.dart';

class MydetailsInterface extends StatefulWidget {
  @override
  _MydetailsInterfaceState createState() => _MydetailsInterfaceState();
}

class _MydetailsInterfaceState extends State<MydetailsInterface> {
  // This widget is the root of your application

String yesno;
  var myuser;
  UserModel userobj = new UserModel("","","","",""); 


@override
  void initState() {
    
    userobj.getCurrentUserDatanew().then((result) {
      setState(() {
        myuser = result;
      });
    });
    //print("---------------------------Email is $email");
    //signInWithGoogle();
    super.initState();
    //myname();
    super.initState();

  }

  

//MydetailsInterface
@override
Widget build(BuildContext context) {
	return Scaffold(
    bottomNavigationBar: BottomNvBar(),
		appBar: AppBar(
		backgroundColor: Colors.amber[400],
		title: Text("My Details"),
		),
    drawer: MyDrawer(),
		body: GridView.count(
	  	crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 8.0,
        children: <Widget>[
          InkWell(//mydataview
            onTap: (){
              Navigator.pushNamed(context, '/mydataview');
              //if(yesno.contains('yes')){
              //    Navigator.pushNamed(context, '/mydataview');
              //  }
              //  else{
              //    Navigator.pushNamed(context, '/admydetails');
              //  }
                //N
            },
            child: Card(
            child: Column(
              children: <Widget>[
                SizedBox(height: 30,),
                Icon(Icons.face,size: 40,color: Colors.blue),
                SizedBox(height: 20,),
                Text("View My Details"),
                SizedBox(height: 20,),
                Text("මාගේ විස්තර බැලීම"),
                SizedBox(height: 20,),
                
              ],
            ),
          ),
          ),
          //InkWell(
          //  onTap: (){
          //    Navigator.pushNamed(context, '/pharmacyHistory');
          //  },
          //  child: Card(
          //  child: Column(
          //    children: <Widget>[
          //      SizedBox(height: 30,),
          //      Icon(Icons.update,size: 40,color: Colors.blue,),
          //      SizedBox(height: 20,),
          //      Text("Update My Details"),
          //      SizedBox(height: 20,),
          //      Text("මාගේ විස්තර අලුත් කිරීම"),
          //      SizedBox(height: 20,),
          //    ],
          //  ),
          //),
          //),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, '/admydetails');
            },
            child: Card(
            child: Column(
              children: <Widget>[
                SizedBox(height: 30,),
                Icon(Icons.add,size: 40,color: Colors.blue,),
                SizedBox(height: 20,),
                Text("Insert My details"),
                SizedBox(height: 20,),
                Text("මාගේ විස්තර ඇතුලත් කිරීම"),
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