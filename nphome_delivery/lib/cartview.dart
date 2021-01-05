import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'components/bottomnecbar.dart';
import 'db_components/add_card_gridview.dart';
import 'db_components/car_item_model.dart';
import 'drawer.dart';
import 'login_page.dart';


//var cartdart = Firestore.instance.collection("cart").document('$email').collection('items').snapshots();

class CartView extends StatefulWidget {
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  
  CarModel carObjec = new CarModel("","","","","","");
  ItemModel cartobj = new ItemModel("","","","","","","");
  UserModel userobj = new UserModel("","","","","");  
  var car;
  var myuser;
  List<CarModel> _listOfObjects = <CarModel>[];
  List<ItemModel> _listofCart = <ItemModel>[];
  List<UserModel> myuserdocuments = <UserModel>[];
  bool checkout= false;
  QuerySnapshot querySnapshot;
  double totalprice =0;
  double deliverycharge =0;

  String useraddress,userid,username,userphone,docmailID;

  String docID; 
  String value1;
  String value2;
  String value3;
  String value4;
  String subtotal;
  String count;

  
  getCartData() async {
        return await Firestore.instance.collection("cart").document('$email').collection('items').getDocuments();
      }


  @override
  void initState() {

    // TODO: implement initState
    carObjec.getCart().then((result) {
      setState(() {
        car = result;
      });
    });
    //print("---------------------------Email is $email");
    //signInWithGoogle();
    
    //super.initState();

  userobj.getCurrentUserData().then((result) {
      setState(() {
        myuser = result;
      });
    });
    //print("---------------------------Email is $email");
    //signInWithGoogle();
    
    super.initState();


    //print();
    
  }

    Widget sliverGridWidget(context) {
     return StaggeredGridView.countBuilder(
       padding: const EdgeInsets.all(8.0),
       shrinkWrap: true,
      primary: false,
      crossAxisCount: 4,
      itemCount: _listofCart.length, //staticData.length,
      
      itemBuilder: (BuildContext context, int index) {
        return AadCardForCardGrid(_listofCart[index]);
      },
     staggeredTileBuilder: (int index) => StaggeredTile.fit(4),
     mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      
    );

  }
  carttoOrder(){
    return StreamBuilder(
      stream: car,
      builder: (context, snapshot){
        String sentdata="";
        String specaracter='~';
        if(snapshot.hasData && checkout==true ){
          for (int i = 0; i < snapshot.data.documents.length; i++){
              String docID = snapshot.data.documents[i].documentID;
              String value1 =snapshot.data.documents[i].data['value1'];
              String value2 = snapshot.data.documents[i].data['value2'];
              String count = snapshot.data.documents[i].data['count'];
              //String value3 = snapshot.data.documents[i].data['value3'];
              //String value4 = snapshot.data.documents[i].data['value4'];
              Firestore.instance.collection('cart').document('$email').collection("items").document(docID).delete();
              String all = docID+"|"+value1+"|"+value2+"|"+count+specaracter;
              sentdata+=all;
          }
          //Firestore.instance.collection('cart').document('$email').delete();
          String documnetID = DateTime.now().millisecondsSinceEpoch.toString();
          print("USER ADDRESS IS : "+useraddress);
          //List list123 = 
          //carBrand,carModel,carYear,carMilleage,carTransmission,carFuelType,carEngineCapacity,carDescription,carPrice,carCondition
          Firestore.instance.collection('orders').document(documnetID).setData({
            'value1':sentdata,
            'value2':'$email',
            'orderstate':'pending',
            'total':(totalprice).toString(),
            'useraddress': useraddress,
            'username' : username,
            'userid': userid,
            'userphone': userphone,
            'value3':DateTime.now().toString().substring(0, DateTime.now().toString().length - 10 ),
            //
            

          });
          checkout = false;
          //Navigator.pushNamed(context, '/myorders');
          //setState(() {
          //            totalprice=0;
          //          });
          //Firestore.instance.collection('cart').document('$email').delete();
          //return Text('data');
          return Text(' ');
        }
        else{
          return Text(' ');
        }

        //setState(() {
        //              totalprice=0;
        //});
      //Navigator.pushNamed(context, '/myorders');  
      },
    );
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNvBar(),
      appBar: AppBar(
        backgroundColor: Colors.amber[400],
        title: Text("My Cart"),

      ),
      drawer: MyDrawer(),
      body: ListView(
        children: <Widget>[
          //Text('data'+ totalprice.toString()),
          //StreamBuilder(
          //  stream: myuser,
          //  builder: (context, snapshot)  {
          //    if(snapshot.hasData){
          //      return showDialog(context: null);
          //    }
          //  }
          //),

          StreamBuilder(
            stream: myuser,
            builder: (context, snapshot)  {
              if(snapshot.hasData){
                //String useraddress,userid,username,userphone,docmailID;

                docmailID = snapshot.data.documentID;
                useraddress = snapshot.data['useraddress'];
                userid = snapshot.data['userid'];
                username = snapshot.data['username'];
                userphone = snapshot.data['userphone'];

                myuserdocuments.add(UserModel(useraddress, userid, username, userphone, docmailID));
                return Text(' ');
                //return Text("I have data"+ docmailID+useraddress+userid+username+userphone);
              }
              else{
                return Text("I have no data");
              }
            },
          ),


          StreamBuilder(
            stream: car,
            builder: (context, snapshot)  {
              if(snapshot.hasData){
                _listofCart = <ItemModel>[];
                
                //return Column(
                //  children: <Widget>[
                //    Text("data"),
                //    Text("data"),
                //    Text(snapshot.data.documents.length.toString()),
                //  ],
                //);
                //totalprice =
                  totalprice=0;
                  deliverycharge=0;
                 for (int i = 0; i < snapshot.data.documents.length; i++) {

                    //if(snapshot.data){}


                    docID = snapshot.data.documents[i].documentID;
                    value1 =snapshot.data.documents[i].data['value1'];
                    value2 = snapshot.data.documents[i].data['value2'];
                    value3 = snapshot.data.documents[i].data['value3'];
                    value4 = snapshot.data.documents[i].data['value4'];
                    subtotal = snapshot.data.documents[i].data['subtotal'];
                    count = snapshot.data.documents[i].data['count'];
                    //String carimage =snapshot.data.documents[i].data['urls'][0];
                    

                    totalprice = totalprice + double.parse(subtotal);
                    if(totalprice>5000){
                      deliverycharge=100;
                    }
                    else if(totalprice<5000){
                      deliverycharge=200;
                    }
                    else{
                      deliverycharge=0;
                    }
                    //totalprice =totalprice+deliverycharge;

                    _listofCart.add(ItemModel(value1,value2,value3,value4,docID,subtotal,count));
                  
                }
                return Column(
                  children: <Widget>[
                    Text("No of Items : "+snapshot.data.documents.length.toString()),
                    //Text("Total : "+ totalprice.toString()),
                    if(snapshot.data.documents.length.toString()=="0")
                        Text("You have no Items") ,
                    if(snapshot.data.documents.length.toString()!="0")
                        Text("Total Rs "+totalprice.toString()+" /=") ,
                        Text('Delivery Charge '+deliverycharge.toString()+' /='),    
                    
                    

                    //Text("Total Price : "+totalprice.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                    sliverGridWidget(context),

                  ],
                ); 
              }else{
                return Text("loading");
              }
                 
                 
              },
          ),
          SizedBox(height: 20,),
          carttoOrder(),
          RaisedButton(
            child: Text("Check Out"),
            onPressed: (){
              //
              setState(() {
                checkout=true;              
                            });
              print("USERADDRESS ::::::::::::"+useraddress);
              if(useraddress.length>1){
                showDialog(
                    context: context,
                    builder: (context) {
                      int urnum = 1;
                      //double subtotal = double.parse(ad.value2);
                      //String contentText = "Please Fill Your Detail first.";
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            title: Column(
                              children: <Widget>[
                                Text("Your Order Sent"), 
                                SizedBox(height: 25,),
                                Text('wait for your oder.stay safe'), 
                              ],
                            ),
                            //title: Text("Please Fill Your Detail first"),
                            content: Column(
                              children: <Widget>[

                                RaisedButton(
                                  child: Text("My Ordeds"),
                                  color: Colors.blue,
                                  onPressed: (){
                                    Navigator.popAndPushNamed(context, '/myorders');
                                  },
                                ),
                                SizedBox(height: 15,),
                                Text("____________"),
                                SizedBox(height: 15,),
                                Text('විශේෂ වට්ටම් ලබාගැනීමට පහතින් පිවිසෙන්න'),
                                SizedBox(height: 10,),
                                RaisedButton(
                                  child: Text("OFFERS"),
                                  color: Colors.blue,
                                  onPressed: (){
                                    Navigator.popAndPushNamed(context, '/hotdeals');
                                  },
                                ),
                                
                                //Text('Quantity'),
                                
                              ],
                            ),
                            
                          );
                        },
                      );
                    },
                  );
              }
              
              
              //
              //Firestore.instance.collection('cart').document('$email').delete();
            },
          ),
          
          
        ],
      ),
    );
  }
}