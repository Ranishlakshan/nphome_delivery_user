import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'components/bottomnecbar.dart';
import 'db_components/car_item_model.dart';
import 'db_components/add_card_gridview.dart';
import 'drawer.dart';


class NewOrders extends StatefulWidget {
  @override
  _NewOrdersState createState() => _NewOrdersState();
}


class _NewOrdersState extends State<NewOrders> {
  
  List<OrderModel> _catagoryCbjects = <OrderModel>[];
  
  OrderModel itemObject = new OrderModel("", "", "", "", "", "", "", "", "", "");
  var ads;

  @override
  void initState() {
    // TODO: implement initState
    itemObject.getOrderData().then((result) {
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
      crossAxisCount: 2,
      itemCount: _catagoryCbjects.length, //staticData.length,

      itemBuilder: (BuildContext context, int index) {
        return AadOrderCardGrid(_catagoryCbjects[index]);
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
        backgroundColor: Colors.amber[400],
        title: Text("My Orders"),
      ),
      drawer: MyDrawer(),
      
      body: ListView(
        children: <Widget>[
          //Text('ranish'),
          SizedBox(height: 25,),
          StreamBuilder(
            stream: ads,
            builder: (context, snapshot) {
              if(snapshot.hasData){
            _catagoryCbjects = <OrderModel>[];
                
            for (int i = 0; i < snapshot.data.documents.length; i++){
                //_listOfObjects = <CarModel>[]; _catagoryCbjects
                //_catagoryCbjects = <OrderModel>[];

                String value1,value2,value3,orderstate,total,docID,useraddress,username,userphone,userid;

                docID = snapshot.data.documents[i].documentID;
                value1 = snapshot.data.documents[i].data['value1'];
                value2 = snapshot.data.documents[i].data['value2'];
                value3 = snapshot.data.documents[i].data['value3'];
                orderstate = snapshot.data.documents[i].data['orderstate'];
                total = snapshot.data.documents[i].data['total'];

                useraddress = snapshot.data.documents[i].data['useraddress'];
                username = snapshot.data.documents[i].data['username'];
                userphone = snapshot.data.documents[i].data['userphone'];
                userid = snapshot.data.documents[i].data['userid'];


                _catagoryCbjects.add(OrderModel(value1,value2,value3,orderstate , total, docID,useraddress,userid,username,userphone));

              }




            if(snapshot.data.documents.length==0){
              return Text("No New Orders At this Movement",style: TextStyle(fontSize: 17),);
            }else{
              return sliverGridWidget(context);
            }

            //return sliverGridWidget(context);
          }
          else{
              return Text("Loading");
          }
            },
          ),

        ],
      ),
    );
  }
}