import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nphome_delivery/zoomimage.dart';

import 'db_components/car_item_model.dart';

class PharmacyItemView extends StatefulWidget {
  final String docID123;

  const PharmacyItemView({ this.docID123}) ;

  
  @override
  _PharmacyItemViewState createState() => _PharmacyItemViewState();
}

class _PharmacyItemViewState extends State<PharmacyItemView> {
  
  var cars;

  List<String> _listOfImages = <String>[];

  


  @override
  void initState() {
    // TODO: implement initState
    cars = Firestore.instance
        .collection('pharmacy')
        .document('${widget.docID123}')
        .snapshots();
        
    super.initState();

    
  }

  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[400],
        title: Text("Prescription and Details"),
      ),
      body: ListView(
        children: <Widget>[
          //Text("ranish"),
          //Text(),
          StreamBuilder(
            stream: cars,
            builder: (context, snapshot){
              if(snapshot.hasData){
                _listOfImages = [];
                    for (int i = 0; i < snapshot.data['urls'].length; i++) {
                      _listOfImages.add(snapshot.data['urls'][i]);
                    }
                //sliverGridWidget(context);
                return CarouselSlider(
                      items: _listOfImages.map((e){
                        return ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            child: Container(
                              height: 200.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: GestureDetector(
                                  //image appear in correct width and height
                                  //child: Image.network(e, fit: BoxFit.fill),
                                  child: Image.network(e),
                                  onTap: () {
                                    Navigator.push<Widget>(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ZoomImage(zoomlistOfImages: _listOfImages),
                                      ),
                                    );
                                  }),
                            ));
                      }).toList(),
                      options: CarouselOptions(
                        height: 300,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      )); 
              }
              else{
                return Text("no data");
              }
            },
          ),
          SizedBox(height: 25,),
          //Text('____________________________'),
          //Text("CUstomer Details"),
          StreamBuilder(
            stream: cars,
            builder: (context, snapshot){
              if(snapshot.hasData){
                String name,address,id,phone,email,total,orderstate;

                name = snapshot.data['username'];
                address = snapshot.data['useraddress'];
                phone = snapshot.data['userphone'];
                id = snapshot.data['userid'];
                email = snapshot.data['email'];
                //total = snapshot.data['total'];
                //orderstate = snapshot.data['orderstate'];

                return Column(
                  children: <Widget>[
                    //Text("Total Bill : Rs."+total+" /=",style: TextStyle(fontSize:20,color: Colors.blue,),),
                    Text('______________________________________'),
                    SizedBox(height: 15,),
                    Text("Customer Details",style: TextStyle(fontSize:20,color: Colors.black,),),
                    SizedBox(height: 10,),
                    Text("Customer ID : "+id),
                    Text("Customer Name : "+name),
                    Text("Customer Address : "+address),
                    Text("Customer Phone : "+phone),
                  ],
                );

              }else{
                return Text('Connection Error');
              }
            },
          ),
          //SizedBox(height: 30,),
          //RaisedButton(
          //  child: Text("delete"),
          //  onPressed: (){
          //    Firestore.instance.collection('pharmacy').document('${widget.docID123}').delete();
          //    //FirebaseStorage.instance.ref().child(images).delete();
          //    
          //    
          //    Navigator.popAndPushNamed(context, '/neworders');
          //  },
          //),
          //SizedBox(height: 30,),
          //RaisedButton(
          //  child: Text("accept"),
          //  onPressed: (){
          //    setState(() {
          //                    Firestore.instance.collection('pharmacy').document('${widget.docID123}').updateData({'orderstate':"accepted"});
          //    //FirebaseStorage.instance.ref().child(images).delete();
          //    
          //    
          //    Navigator.pop(context);
          //                  });
          //  },
          //),
          //SizedBox(height: 30,),
          //RaisedButton(
          //  child: Text("delivered"),
          //  onPressed: (){
          //    setState(() {
          //                    Firestore.instance.collection('pharmacy').document('${widget.docID123}').updateData({'orderstate':"delivered"});
          //    //FirebaseStorage.instance.ref().child(images).delete();
          //    
          //    
          //    Navigator.pop(context);
          //                  });
          //  },
          //)
        ],
      ),
    );
  }
}