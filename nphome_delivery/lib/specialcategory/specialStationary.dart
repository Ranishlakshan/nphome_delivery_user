import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nphome_delivery/db_components/add_card_gridview.dart';
import 'package:nphome_delivery/db_components/car_item_model.dart';

class SpecialElectronics extends StatefulWidget {
  @override
  _SpecialElectronicsState createState() => _SpecialElectronicsState();
}

class _SpecialElectronicsState extends State<SpecialElectronics> {
  
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

  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: BottomNvBar(),
      appBar: AppBar(
        title: Text('Stationary',style: TextStyle(letterSpacing: 2),),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: <Widget>[
          StreamBuilder(
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

              if (dbCatagory.contains('Stationary')) {
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
          ),
        ],
      ),
    );
  }
}