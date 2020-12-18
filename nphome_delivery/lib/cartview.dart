import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'db_components/add_card_gridview.dart';
import 'db_components/car_item_model.dart';
import 'login_page.dart';


//var cartdart = Firestore.instance.collection("cart").document('$email').collection('items').snapshots();

class CartView extends StatefulWidget {
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  
  CarModel carObjec = new CarModel("","","","","","");
  ItemModel cartobj = new ItemModel("","","","","","","");
  var car;
  List<CarModel> _listOfObjects = <CarModel>[];
  List<ItemModel> _listofCart = <ItemModel>[];
  bool checkout= false;
  QuerySnapshot querySnapshot;
  double totalprice =0;

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
        if(snapshot.hasData && checkout==true){
          for (int i = 0; i < snapshot.data.documents.length; i++){
              String docID = snapshot.data.documents[i].documentID;
              String value1 =snapshot.data.documents[i].data['value1'];
              String value2 = snapshot.data.documents[i].data['value2'];
              //String value3 = snapshot.data.documents[i].data['value3'];
              //String value4 = snapshot.data.documents[i].data['value4'];
              Firestore.instance.collection('cart').document('$email').collection("items").document(docID).delete();
              String all = docID+"|"+value1+"|"+value2+specaracter;
              sentdata+=all;
          }
          //Firestore.instance.collection('cart').document('$email').delete();
          String documnetID = DateTime.now().millisecondsSinceEpoch.toString();
          //List list123 = 
          //carBrand,carModel,carYear,carMilleage,carTransmission,carFuelType,carEngineCapacity,carDescription,carPrice,carCondition
          Firestore.instance.collection('orders').document(documnetID).setData({
            'value1':sentdata,
            'value2':'$email',
            'value3':DateTime.now().toString().substring(0, DateTime.now().toString().length - 10 ),
            //
            

          });
          //Firestore.instance.collection('cart').document('$email').delete();
          //return Text('data');
          return Text(sentdata);
        }
        else{
          return Text(' ');
        }
      },
    );
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("my cart"),

      ),
      body: ListView(
        children: <Widget>[
          //Text('data'),
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

                    _listofCart.add(ItemModel(value1,value2,value3,value4,docID,subtotal,count));
                  
                }
                return Column(
                  children: <Widget>[
                    Text("No of Items : "+snapshot.data.documents.length.toString()),
                    //Text("Total : "+ totalprice.toString()),
                    Text("Total Price : "+totalprice.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
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
              //
              //Firestore.instance.collection('cart').document('$email').delete();
            },
          ),
          
          
        ],
      ),
    );
  }
}