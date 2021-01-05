import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'components/bottomnecbar.dart';
import 'db_components/addhotdeals.dart';
import 'db_components/car_item_model.dart';
import 'drawer.dart';
import 'login_page.dart';


class HotDeals extends StatefulWidget {
  @override
  _HotDealsState createState() => _HotDealsState();
}

class _HotDealsState extends State<HotDeals> {
  
  CarModel hotdealobject = new CarModel("","","","","","");
  var hotdealstream;
  List<CarModel> hotdealobjectlist = <CarModel>[];

  String yesno;
  var myuser;
  UserModel userobj = new UserModel("","","","",""); 


  @override
  void initState() {
    // TODO: implement initState
    hotdealobject.getHotdealsData().then((result) {
      setState(() {
        hotdealstream = result;
      });
    });
    super.initState();
    //print();
    userobj.getCurrentUserDatanew().then((result) {
      setState(() {
        myuser = result;
      });
    });
    //print("---------------------------Email is $email");
    //signInWithGoogle();
    
    super.initState();

    
  }

  Widget sliverGridWidget(context) {
     return StaggeredGridView.countBuilder(
       padding: const EdgeInsets.all(8.0),
       shrinkWrap: true,
      primary: false,
      crossAxisCount: 4,
      itemCount: hotdealobjectlist.length, //staticData.length,
      
      itemBuilder: (BuildContext context, int index) {
        return hotAadCardForGrid(hotdealobjectlist[index]);
      },
     staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
     mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      
    );

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNvBar(),
      appBar: AppBar(
        title: Text("Special Offers",style: TextStyle( letterSpacing: 2),),
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
          Container(
            child: Center(
              //child: Text("Hot Deals"),
            ),
          ),
          StreamBuilder(
            stream: hotdealstream,
            builder: (context, snapshot)  {
              if(snapshot.hasData){
                hotdealobjectlist = <CarModel>[];
                
                 for (int i = 0; i < snapshot.data.documents.length; i++) {

                  //bool status = snapshot.data.documents[i].data['reviewstatus'];
                  // DocumentSnapshot snap = snapshot.data.documents[i];
                  
                    String docID = snapshot.data.documents[i].documentID;
                    String value1 =snapshot.data.documents[i].data['value1'];
                    String value2 = snapshot.data.documents[i].data['value2'];
                    String value3 = snapshot.data.documents[i].data['value3'];
                    String value4 = snapshot.data.documents[i].data['value4'];
                    String carimage =
                        snapshot.data.documents[i].data['urls'][0];                  
                    hotdealobjectlist.add(CarModel(value1,value2,value3,value4,carimage,docID));
                  
                  
                  
                }
                return sliverGridWidget(context); 
              }else{
                return Text("No Special Offers at this moment");
              }
                 
                 
              },
          ),
        ],
      ),
      
    );
  }
}