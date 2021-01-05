import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'components/bottomnecbar.dart';
import 'components/listviewHorizontal.dart';
//import 'components/listview_horizontal.dart';
import 'db_components/add_card_gridview.dart';
import 'db_components/car_item_model.dart';
import 'drawer.dart';
import 'login_page.dart';

class FirstPageTemp extends StatefulWidget {
  @override
  _FirstPageTempState createState() => _FirstPageTempState();
}

class _FirstPageTempState extends State<FirstPageTemp> {
  
  var carosal_img;
  List<String> _listOfImages = <String>[];
  List<CarModel> _listOfObjects = <CarModel>[];
  CarModel carObjec = new CarModel("","","","","","");
  var car;
  List<CarModel> _catagoryCbjects = <CarModel>[];
  var catagoryMain,catagorySub;

  List<UserModel> myuserdocuments = <UserModel>[];
  String userid,username,userphone,docmailID;
  //String useraddress='E';
  var myuser;
  UserModel userobj = new UserModel("","","","","");  
  String haveaddress = "yes";
  String yesno;
  
  

  @override
  void initState() {

    carObjec.getData().then((result) {
      setState(() {
        car = result;
      });
    });
    //print("---------------------------Email is $email");
    //signInWithGoogle();
    
    super.initState();

    //print();
    carosal_img = Firestore.instance
        .collection('maincarosal')
        .document('imageset')
        .snapshots();
        
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

  Widget sliverGridWidget(context) {
     return StaggeredGridView.countBuilder(
       padding: const EdgeInsets.all(8.0),
       shrinkWrap: true,
      primary: false,
      crossAxisCount: 4,
      itemCount: _listOfObjects.length, //staticData.length,
      
      itemBuilder: (BuildContext context, int index) {
        return AadCardForGrid(_listOfObjects[index]);
      },
     staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
     mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      
    );

  }

  static const colord = const Color(0xFFB74093);

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: BottomNvBar(),
      appBar: AppBar(
        backgroundColor: Colors.amber[400],
        title: Text('NP Home Delivery'),
        actions: <Widget>[
          IconButton(
             icon: Icon(Icons.add),
              onPressed: (){
                Navigator.pushNamed(context, '/admydetails');
              },
              //cartview

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
      //drawer: MyDrawer(),
      body: ListView(
        ///////////////////////
        shrinkWrap: true,
        physics: ScrollPhysics(),
        ///////////////////////
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
                  return Text(' ');  
                }
                else{
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
          //StreamBuilder(
          //      stream: carosal_img,
          //      builder: (context, snapshot) {
          //        if (snapshot.hasData) {
          //          _listOfImages = [];
          //          for (int i = 0; i < snapshot.data['urls'].length; i++) {
          //            _listOfImages.add(snapshot.data['urls'][i]);
          //          }
          //        }
          //        return CarouselSlider(
          //            items: _listOfImages.map((e){
          //              return ClipRRect(
          //                  borderRadius:
          //                      BorderRadius.all(Radius.circular(10.0)),
          //                  child: Container(
          //                    height: 200.0,
          //                    margin: EdgeInsets.all(10.0),
          //                    decoration: BoxDecoration(
          //                      color: Colors.white,
          //                    ),
          //                    child: GestureDetector(
          //                        //image appear in correct width and height
          //                        //child: Image.network(e, fit: BoxFit.fill),
          //                        child: Image.network(e),
          //                        onTap: (){
          //                          Navigator.pushNamed(context, "/hotdeals");
          //                        },
          //                        
          //                        ),
          //                  ));
          //            }).toList(),
          //            options: CarouselOptions(
          //              height: 300,
          //              aspectRatio: 16 / 9,
          //              viewportFraction: 0.8,
          //              initialPage: 0,
          //              enableInfiniteScroll: true,
          //              reverse: false,
          //              autoPlay: true,
          //              autoPlayInterval: Duration(seconds: 3),
          //              autoPlayAnimationDuration: Duration(milliseconds: 800),
          //              autoPlayCurve: Curves.fastOutSlowIn,
          //              enlargeCenterPage: true,
          //              scrollDirection: Axis.horizontal,
          //            ));
          //      }
          //),
          //SizedBox(height: 20,),
          //MainListView(),
          //SizedBox(height: 20.0,),
          ////Text('ranish'),
          ////Text(car.toString()),
          StreamBuilder(
            stream: car,
            builder: (context, snapshot)  {
              if(snapshot.hasData){
                _listOfObjects = <CarModel>[];
                
                 for (int i = 0; i < snapshot.data.documents.length; i++) {

                    String docID = snapshot.data.documents[i].documentID;
                    String value1 =snapshot.data.documents[i].data['value1'];
                    String value2 = snapshot.data.documents[i].data['value2'];
                    String value3 = snapshot.data.documents[i].data['value3'];
                    String value4 = snapshot.data.documents[i].data['value4'];
                    String carimage =
                        snapshot.data.documents[i].data['urls'][0];                  
                    _listOfObjects.add(CarModel(value1,value2,value3,value4,carimage,docID));
                  
                }
                return sliverGridWidget(context); 
              }else{
                return Text("loading");
              }
                 
                 
              },
          ),


        ],
      ),
    );
  }
}