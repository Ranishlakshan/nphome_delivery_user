import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'components/bottomnecbar.dart';
import 'db_components/add_card_gridview.dart';
import 'db_components/car_item_model.dart';
import 'drawer.dart';
import 'login_page.dart';



var catagory_names = Firestore.instance.collection("category").snapshots();
var catagoryMain,catagorySub;
String showItems;

String yesno;
  var myuser;
  UserModel userobj = new UserModel("","","","",""); 


class Catagories extends StatefulWidget {
  @override
  _CatagoriesState createState() => _CatagoriesState();
}

class _CatagoriesState extends State<Catagories> {

  List<CarModel> _catagoryCbjects = <CarModel>[];
  CarModel itemObject = new CarModel("", "", "", "","","");

  var ads;

  @override
  void initState() {
    // TODO: implement initState
    itemObject.getData().then((result) {
      setState(() {
        ads = result;
      });
    });
    super.initState();

    userobj.getCurrentUserDatanew().then((result) {
      setState(() {
        myuser = result;
      });
    });
    //print("---------------------------Email is $email");
    //signInWithGoogle();
    
    super.initState();

  }


  List<DropdownMenuItem> catagoryNamesSub = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNvBar(),
      appBar: AppBar(
        title: Text("Catagories",style: TextStyle(letterSpacing: 2),),
        backgroundColor: Colors.amber[400],
        actions: <Widget>[
            
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                
                Navigator.pushNamed(context, '/login');
                //addDialog(context);
              },
            ),
            IconButton(
             icon: Icon(Icons.shopping_cart),
              onPressed: (){
                if(yesno.contains('yes')){
                  Navigator.pushNamed(context, '/cartview');
                }
                else{
                  Navigator.pushNamed(context, '/admydetails');
                }
                //Navigator.pushNamed(context, '/cartview');
              },
              //cartview   
          )
          ],
      ),
      drawer: MyDrawer(),
      body: ListView(
        children: <Widget>[
          StreamBuilder(
            stream: myuser,
            builder: (context, snapshot)  {
              if(snapshot.hasData){
                String temp;
                
                print("LENGTH  :::::::::::::"+snapshot.data.documents.length.toString());
                for (int i = 0; i < snapshot.data.documents.length; i++){
                  temp = snapshot.data.documents[i].documentID;
                  print("DATABASE MAIL :::::::::::::::::::::"+temp);
                  if(temp.contains('$email')){
                    yesno = 'yes';
                    print('yes');
                    break;
                  }
                  else{
                    yesno = 'no';
                    print('no');
                  }
                  
                }
                //print("DATABASE MAIL :::::::::::::::::::::"+temp);
                if(yesno.contains('yes')){

                  return Text('');
                }
                else{
                  //Navigator.popAndPushNamed(context, '/admydetails');
                        
              
                //return Text('no data');
                  //Navigator.pushNamed(context, '/admydetails');
                  return Column(
                    children: <Widget>[
                      SizedBox(height: 30,),
                      Text('Before Start, Please',style: TextStyle(fontSize: 20),),
                      Text('Enter Your Details',style: TextStyle(fontSize: 20),),
                      Text('clicking below button',style: TextStyle(fontSize: 20),),
                      SizedBox(height: 15,),
                      Text('භාණ්ඩ තෝරාගැනීමට පෙර',style: TextStyle(fontSize: 20),),
                      Text('ඔබගේ නම,ලිපිනය,දුරකථන අංකය',style: TextStyle(fontSize: 20),),
                      Text('ඇතුලත් කිරීමට පහත බොත්තම ඔබන්න',style: TextStyle(fontSize: 20),),
                      SizedBox(height: 15,),
                      FloatingActionButton(
                        child: Text('ADD'),
                        onPressed: (){
                          Navigator.pushNamed(context, '/admydetails');
                        },
                      ),
                      SizedBox(height: 40,),
                    ],
                  );
                }  
                //return Text('ranish');
                //String useraddress,userid,username,userphone,docmailID;
                //print('MYUSERADDRESS 1 :::::::::;:::'+useraddress);
                //docmailID = snapshot.data.documentID;
                //useraddress = snapshot.data['useraddress'];
                //userid = snapshot.data['userid'];
                //useraddress = "ddd";
                //print("SNAPSHOT DATA :::::::::::::::::::"+snapshot.data.documents[1].documentID);
                //return Text(' have data');
                //return Text("I have data"+ docmailID+useraddress+userid+username+userphone);
              }
              else{
                return Text("I have no data");
              }
            },
          ),
          StreamBuilder(
            stream: catagory_names,
            builder:  (context, snapshot) {
              if (!snapshot.hasData){
                return Text("Loading.....");
              }
              else {
                List<DropdownMenuItem> catagorynamesMain = [];
                for (int i = 0; i < snapshot.data.documents.length; i++) {
                    DocumentSnapshot snap = snapshot.data.documents[i];
                    catagorynamesMain.add(
                      DropdownMenuItem(
                        child: Text(
                          snap.documentID,
                          style: TextStyle(color: Color(0xff11b719)),
                        ),
                        value: "${snap.documentID}",
                      ),
                    );
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 20.0),
                      DropdownButton(
                        items: catagorynamesMain,
                        onChanged: (value) {
                          setState(() {
                            catagoryMain=value;                            
                          });
                          for (int i = 0;i < snapshot.data.documents.length;i++) {
                            DocumentSnapshot snap = snapshot.data.documents[i];
                            if (snap.documentID == catagoryMain) {
                              catagoryNamesSub = [];
                              for (int j = 0; j < snap.data.length; j++) {
                                catagoryNamesSub.add(
                                  DropdownMenuItem(
                                    child: Text(
                                      snap.data['${j + 1}'].toString(),
                                      style:
                                          TextStyle(color: Color(0xff11b719)),
                                    ),
                                    value: snap.data['${j + 1}'].toString(),
                                  ),
                                );
                              }
                            }
                          }
                          final snackBar = SnackBar(
                            content: Text(
                              'Selected Catogory : $catagoryMain',
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        },
                        value: catagoryMain,
                        
                        isExpanded: false,
                        hint: new Text(
                          "Select Catagory",
                          style: TextStyle(color: Color(0xff11b719),letterSpacing: 2),
                        ),  
                      ),
                      DropdownButton(
                        hint: Text("Select Sub Catagory",style: TextStyle(letterSpacing: 2),),
                        items: catagoryNamesSub,
                        onChanged: (value) {
                          final snackBar = SnackBar(
                            content: Text(
                            'Selected Currency value is $value',
                            style: TextStyle(color: Color(0xff11b719)),
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                          setState(() {
                            showItems="A";
                            catagorySub = value;
                            catagorynamesMain = [];
                            catagoryNamesSub= [];
                          });
                        },
                      ),
                      _showCatagory(),
                    ],
                  );
              }              
            },
          ),
        ],
      ),
      
    );
    
    ///
  }

  //
  //ADDITIONAL wIDGET FROM HERE
  //
  Widget _showCatagory(){
    if(showItems=="A"){
      //Show catagory data here
      return StreamBuilder(
        stream: ads,
        builder:  (context, snapshot) {
          if(!snapshot.hasData){
            return Text('No Data for This Catagory');
          }
          else{
            _catagoryCbjects = <CarModel>[];

            for (int i = 0; i < snapshot.data.documents.length; i++){

              String dbCatagory = snapshot.data.documents[i].data['category'];
              String value1,value2,value3,value4,carimage,docID;

              if (dbCatagory.contains(catagorySub)) {
              docID = snapshot.data.documents[i].documentID;
              value1 = snapshot.data.documents[i].data['value1'];
              value2 = snapshot.data.documents[i].data['value2'];
              value3 = snapshot.data.documents[i].data['value3'];
              value4 = snapshot.data.documents[i].data['value4'];
              carimage = snapshot.data.documents[i].data['urls'][0];
            
              _catagoryCbjects.add(CarModel(value1,value2,value3,value4 , carimage, docID));
            }
            }
            return sliverGridWidget(context);
          }          
        },
      );



    }else{
      return Text(' ');
    }
  }

  Widget sliverGridWidget(context) {
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.all(8.0),
      shrinkWrap: true,
      primary: false,
      crossAxisCount: 4,
      itemCount: _catagoryCbjects.length, //staticData.length,

      itemBuilder: (BuildContext context, int index) {
        return AadCardForGrid(_catagoryCbjects[index]);
      },
      staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}