import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'components/bottomnecbar.dart';
import 'drawer.dart';
import 'login_page.dart';

class ViewMyData extends StatefulWidget {
  final String docID123;
  

  const ViewMyData({ this.docID123}) ;

  
  @override
  _ViewMyDataState createState() => _ViewMyDataState();
}

class _ViewMyDataState extends State<ViewMyData> {
  
  var cars;
  String name1,address,id,phone,email1,total,orderstate;


  String name123 = "$name";
  String email123 = '$email';
  String photourl = "$imageUrl";
  

  @override
  void initState() {
    // TODO: implement initState
    cars = Firestore.instance
        .collection('users')
        .document('${email}')
        .snapshots();
        
    super.initState();

    
  }

  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNvBar(),
      
      appBar: AppBar(
        backgroundColor: Colors.amber[400],
        title: Text("My Details"),
      ),
      drawer: MyDrawer(),
      
      body: ListView(
        children: <Widget>[
          //Text("ranish"),
          //Text(),
          //StreamBuilder(
          //  stream: cars,
          //  builder: (context, snapshot){
          //    if(snapshot.hasData){
//
          //      return Text("have data");
          //    }
          //    else{
          //      return Text("no data");
          //    }
          //  },
          //),
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
          SizedBox(height: 25,),
          //Text('____________________________'),
          //Text("CUstomer Details"),
          StreamBuilder(
            stream: cars,
            builder: (context, snapshot){
              if(snapshot.hasData){
                //String name,address,id,phone,email,total,orderstate;

                name1 = snapshot.data['username'];
                address = snapshot.data['useraddress'];
                phone = snapshot.data['userphone'];
                id = snapshot.data['userid'];
                email1 = snapshot.data['value2'];
                //total = snapshot.data['total'];
                //orderstate = snapshot.data['orderstate'];

                return Column(
                  children: <Widget>[
                    //Text("Total Bill : Rs."+total+" /=",style: TextStyle(fontSize:20,color: Colors.blue,),),
                    //Text('______________________________________'),
                    SizedBox(height: 15,),
                    Text("My Details",style: TextStyle(fontSize:20,color: Colors.black,),),
                    SizedBox(height: 10,),
                    Text("My ID : "+id),
                    SizedBox(height: 5,),
                    Text("My Name : "+name1),
                    SizedBox(height: 5,),
                    Text("My Address : "+address),
                    SizedBox(height: 5,),
                    Text("My Phone : "+phone),
                  ],
                );

              }else{
                return Text('Connection Error');
              }
            },
          ),
          SizedBox(height: 30,),
          FloatingActionButton(
            child: Text("update"),
            onPressed: (){
              showDialog(
                    context: context,
                    builder: (context) {
                      int urnum = 1;
                      //double subtotal = double.parse(ad.value2);
                      String contentText = "Content of Dialog";
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            //title: Text("Select Quantity"),
                            content: Column(
                              children: <Widget>[
                                //SizedBox(height: 15,),
                                
                                //Text('Quantity'),
                                //Text("Title is : "+title),
                                TextFormField(
                                  initialValue: name1,
                                  onChanged:  (value) {
                                    //print(widget.cat1+","+widget.cat2);
                                       name1=value;         
                                              },
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Please enter Name';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black)
                                    ),
                                    //hintText: 'Enter Unit Name',
                                    labelText: 'Name',
                                    prefixIcon: Icon(Icons.add_circle) 
                                  ),
                                ),
                                SizedBox(height: 5,),
                                //PRICE
                                TextFormField(
                                  initialValue: address,
                                  onChanged:  (value) {
                                    //print(widget.cat1+","+widget.cat2);
                                       address=value;         
                                              },
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Address';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black)
                                    ),
                                    //hintText: 'Enter Unit Name',
                                    labelText: 'Address',
                                    prefixIcon: Icon(Icons.add_circle) 
                                  ),
                                ),
                                SizedBox(height: 5,),
                                //Description
                                TextFormField(
                                  initialValue: phone,
                                  onChanged:  (value) {
                                    //print(widget.cat1+","+widget.cat2);
                                       phone=value;         
                                              },
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Please enter Phone number';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black)
                                    ),
                                    //hintText: 'Enter Unit Name',
                                    labelText: 'Phone number',
                                    prefixIcon: Icon(Icons.add_circle) 
                                  ),
                                ),
                                SizedBox(height: 5,),
                                
                                //Text(urnum.toString() +" units", style: TextStyle(fontSize: 26),),
                                //Text(ad.value1),
                                //SizedBox(height: 20,),
                                ////Row Start
                                //
                                //SizedBox(height: 15,),
                                //Text("____________"),
                                //SizedBox(height: 15,),

                                RaisedButton(
                                  child: Text("Update"),
                                  onPressed: (){
                                    Firestore.instance.collection('users').document('$email').updateData({
                                      'username':name1,
                                      'useraddress':address,
                                      'userphone':phone,
                                      
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                
                              ],
                            ),
                            
                          );
                        },
                      );
                    },
                  );
            },
          ),
          
        ],
      ),
    );
  }
}