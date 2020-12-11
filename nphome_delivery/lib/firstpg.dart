import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'components/bottomnecbar.dart';
import 'components/listview_horizontal.dart';
import 'db_components/add_card_gridview.dart';
import 'db_components/car_item_model.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  
  var carosal_img;
  List<String> _listOfImages = <String>[];
  List<CarModel> _listOfObjects = <CarModel>[];
  CarModel carObjec = new CarModel("","","","","","");
  var car;
  List<CarModel> _catagoryCbjects = <CarModel>[];
  var catagoryMain,catagorySub;

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



  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       bottomNavigationBar: BottomNvBar(),
      appBar: AppBar(
        title: Text('NP Home Delivery'),
      ),
      body: ListView(
        ///////////////////////
        shrinkWrap: true,
        physics: ScrollPhysics(),
        ///////////////////////
        children: <Widget>[
          StreamBuilder(
                stream: carosal_img,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _listOfImages = [];
                    for (int i = 0; i < snapshot.data['urls'].length; i++) {
                      _listOfImages.add(snapshot.data['urls'][i]);
                    }
                  }
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
                                  onTap: (){
                                    Navigator.pushNamed(context, "/hotdeals");
                                  },
                                  
                                  ),
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
          ),
          SizedBox(height: 20,),
          MainListView(),
          SizedBox(height: 20.0,),
          Text('ranish'),
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