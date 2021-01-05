import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'components/bottomnecbar.dart';
import 'db_components/car_item_model.dart';
import 'db_components/add_card_gridview.dart';
import 'drawer.dart';
import 'login_page.dart';


class PharmacyHistory extends StatefulWidget {
  @override
  _PharmacyHistoryState createState() => _PharmacyHistoryState();
}
String email123 = '$email';

class _PharmacyHistoryState extends State<PharmacyHistory> {
  
  List<PharmacyModel> _pharcatagoryCbjects = <PharmacyModel>[];
  
  PharmacyModel itemObject = new PharmacyModel("", "", "", "", "", "", "",'');
  var pharmacyItem;

  @override
  void initState() {
    // TODO: implement initState
    itemObject.getPharmacyData().then((result) {
      setState(() {
        pharmacyItem = result;
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
      itemCount: _pharcatagoryCbjects.length, //staticData.length,

      itemBuilder: (BuildContext context, int index) {
        return AadPharmacyCardGrid(_pharcatagoryCbjects[index]);
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
        title: Text("History"),
      ),
      //drawer: MyDrawer(),
      body: ListView(
        children: <Widget>[
          //Text('ranish'),
          SizedBox(height: 25,),
          StreamBuilder(
            stream: pharmacyItem,
            builder: (context, snapshot) {
              if(snapshot.hasData){
            _pharcatagoryCbjects = <PharmacyModel>[];
            print("LENGTH :::::::"+snapshot.data.documents.length.toString());
                
            for (int i = 0; i < snapshot.data.documents.length; i++){
                //_listOfObjects = <CarModel>[]; _catagoryCbjects
                //_catagoryCbjects = <OrderModel>[];

                String emailcheck = snapshot.data.documents[i].data['email'];
                String value3,docID,useraddress,username,userphone,userid,email;
                print("MYEMAIL :::::::::::::"+emailcheck);
                print("DATABASE MAIL :::::::"+email123);
                if (emailcheck.contains(email123)) {
                  //print("NO PROBLEM THERE:::::::::::::::::::::::");
                  docID = snapshot.data.documents[i].documentID;
                  email = snapshot.data.documents[i].data['email'];
                  value3 = snapshot.data.documents[i].data['value3'];
                  useraddress = snapshot.data.documents[i].data['useraddress'];
                  username = snapshot.data.documents[i].data['username'];
                  userphone = snapshot.data.documents[i].data['userphone'];
                  userid = snapshot.data.documents[i].data['userid'];
                  String prescriptionimage =
                        snapshot.data.documents[i].data['urls'][0];
                  print(docID+email+value3+useraddress+username);

                  _pharcatagoryCbjects.add(PharmacyModel(email,value3 , docID,useraddress,userid,username,userphone,prescriptionimage));

                }
                else{
                  print("WE PROBLEM THERE:::::::::::::::::::::::");
                }
                
                
              }




            if(snapshot.data.documents.length==0){
              return Text("No History",style: TextStyle(fontSize: 17),);
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