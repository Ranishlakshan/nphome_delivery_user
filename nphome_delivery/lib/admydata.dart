import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'db_components/car_item_model.dart';
import 'login_page.dart';

class AddMyDetails extends StatefulWidget {
  @override
  _AddMyDetailsState createState() => _AddMyDetailsState();
}

class _AddMyDetailsState extends State<AddMyDetails> {
  

  CarModel carObjec = new CarModel("","","","","","");
  var users;
  List<CarModel> _listOfObjects = <CarModel>[];

  String username,useraddress,usertpnumber;
  bool useridgetting= false;
  int usercount=0;
  String ranish;
  String availableUsers=":";

  
  @override
  void initState() {
    // TODO: implement initState
    carObjec.getUserData().then((result) {
      setState(() {
        users = result;
      });
    });
    super.initState();
    //print();
  }

  void countDocuments() async {
    QuerySnapshot _myDoc = await Firestore.instance.collection('users').getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    print(" dsf ::::::"+ _myDocCount.length.toString());
    availableUsers= (_myDocCount.length + 1).toString();
    //setState(() {
    //      availableUsers= (_myDocCount.length + 1).toString();
    //    });
    print("Available Users ::"+availableUsers);
        
      // Count of Documents in Collection
}

//  gettingID(){
//    return StreamBuilder(
//      stream: users,
//      builder: (context, snapshot){
//        if(snapshot.hasData && useridgetting==true){
//            setState(() {
//              usercount = 1 + snapshot.data.documents.length;
//            ranish = snapshot.data.documents.length.toString();
//            print("usercount : " + usercount.toString());            
//                        });
//            
//            //useridgetting=false;
//            return Text(' ');
//        }
//        else{
//          return Text(' ');
//        }
//
//        //String sentdata="";
//        //String specaracter='~';
//        //if(snapshot.hasData && checkout==true){
//        //  for (int i = 0; i < snapshot.data.documents.length; i++){
//        //      String docID = snapshot.data.documents[i].documentID;
//        //      String value1 =snapshot.data.documents[i].data['value1'];
//        //      String value2 = snapshot.data.documents[i].data['value2'];
//        //      //String value3 = snapshot.data.documents[i].data['value3'];
//        //      //String value4 = snapshot.data.documents[i].data['value4'];
//        //      Firestore.instance.collection('cart').document('$email').collection("items").document(docID).delete();
//        //      String all = docID+"|"+value1+"|"+value2+specaracter;
//        //      sentdata+=all;
//        //  }
//        //  //Firestore.instance.collection('cart').document('$email').delete();
//        //  String documnetID = DateTime.now().millisecondsSinceEpoch.toString();
//        //  //List list123 = 
//        //  //carBrand,carModel,carYear,carMilleage,carTransmission,carFuelType,carEngineCapacity,carDescription,carPrice,carCondition
//        //  Firestore.instance.collection('orders').document(documnetID).setData({
//        //    'value1':sentdata,
//        //    'value2':'$email',
//        //    'value3':DateTime.now().toString().substring(0, DateTime.now().toString().length - 10 ),
//        //    //
//        //    
////
//        //  });
//        //  useridgetting = false;
//        //  //totalprice=0;
//        //  //Firestore.instance.collection('cart').document('$email').delete();
//        //  //return Text('data');
//        //  return Text(sentdata);
//        //}
//        //else{
//        //  return Text(' ');
//        //}
//      },
//    );
//  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[400],
        title: Text('Add My Details'),
      ),
      //drawer: MyDrawer(),
      
      body: ListView(
        children: <Widget>[
          //Text('start'),
          SizedBox(height: 30,),

          Card(
            child: Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onChanged:  (value) {
                         username=value;         
                                },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter Your Name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)
                      ),
                      hintText: 'Enter your Name',
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.add_circle) 
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    onChanged:  (value) {
                         usertpnumber=value;         
                                },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter Phone Number';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)
                      ),
                      hintText: 'Enter Phone Number',
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.add_circle) 
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 15,
                    onChanged:  (value) {
                         useraddress=value;
                         countDocuments();         
                                },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter Address';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.black)
                       ),
                      hintText: 'Enter Address',
                      labelText: 'Address ',
                      prefixIcon: Icon(Icons.add_circle)
                    ),
                  ),
                  SizedBox(height: 20.0),
                  //gettingID(),
                  RaisedButton(
                    onPressed: (){
                      
                      //gettingID();
                      //countDocuments();
                      setState(() {
                        useridgetting=true;
                        countDocuments();
                         
                        //gettingID();               
                      });
                      //gettingID();
                      for(int i=1;i<3;i++){
                        
                      String documnetID = DateTime.now().millisecondsSinceEpoch.toString();
                      //List list123 = 
                      //String testLocation = '${loccz.getTownname()},${loccz.getdistrictName()}';
                      //print(testLocation);
                      //carBrand,carModel,carYear,carMilleage,carTransmission,carFuelType,carEngineCapacity,carDescription,carPrice,carCondition
                      Firestore.instance.collection('users').document('$email').setData({
                        'userid':availableUsers,
                        'username':username,
                        'userphone':usertpnumber,
                        'useraddress':useraddress,


                      });
                      }
                      Navigator.pushReplacementNamed(context, '/firstpage');
                    },
                    child: Text("Save",),
                     color: Colors.blue,
                  ),
                  //gettingID(),
                ],
              ),
            ),
          ),

          SizedBox(height: 30,),
          //Text('end'),

          //RaisedButton(
          //  child: Text('Press'),
          //  onPressed: (){
          //    
          //  },
          //)
        ],
      ),
    );
  }
}