import 'package:flutter/material.dart';

import 'db_components/car_item_model.dart';

class AddMyDetails extends StatefulWidget {
  @override
  _AddMyDetailsState createState() => _AddMyDetailsState();
}

class _AddMyDetailsState extends State<AddMyDetails> {
  

  CarModel carObjec = new CarModel("","","","","","");
  var users;
  List<CarModel> _listOfObjects = <CarModel>[];

  
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
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add My Details'),
      ),
      body: ListView(
        children: <Widget>[
          Text('ranish'),
          RaisedButton(
            child: Text('Press'),
            onPressed: (){
              
            },
          )
        ],
      ),
    );
  }
}