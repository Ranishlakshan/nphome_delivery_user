import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:number_inc_dec/number_inc_dec.dart';
import '../itemview.dart';
import '../login_page.dart';
import '../orderview.dart';
import '../pharmacyItemView.dart';
import 'car_item_model.dart';

//AadCardForGrid

int mynum=0;

class AadCardForGrid extends StatelessWidget {

  AadCardForGrid(this.ad);
  String documentid;
  CarModel ad;

  //var name1;

  //String name1 = ad.docID.toString();
  Widget _buildImageWidget() {
    //documentid = ad.docID;
    if (ad.carimage != null && ad.carimage != '') {
      //return Image.network(ad.carimage);
      return Stack(
        children: <Widget>[
          Image.network(ad.carimage),
          
          
        ],
      );
    } else {
      return Image.network('https://uae.microless.com/cdn/no_image.jpg');
    }
    
  }
  Widget _buildTitleWidget() {

    if (ad.value1 != null && ad.value1 != '') {
      return Text(ad.value1, style: TextStyle(fontWeight: FontWeight.bold),);
    } else {
      return SizedBox();
    }
  }

  Widget _buildPriceWidget() {
    if (ad.value2 != null && ad.value2 != '') {
      return Text("\Rs ${ad.value2}");
    } else {
      return SizedBox();
    }
  }

  Widget _buildTimeWidget() {
    if (ad.value4 != null && ad.value4 != '') {
      return Text(" ${ad.value4}");
    } else {
      return SizedBox();
    }
  }

  Widget _buildLocationWidget() {
    if (ad.value3 != null && ad.value3 != '') {
      return Row(
        children: <Widget>[
          Icon(Icons.location_on),
          SizedBox(width: 4.0,),
          Expanded(child: Text(ad.value3))
        ],
      );
    } else {
      return SizedBox();
    }
  }

  //functions
  


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        //'/itemview'
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ItemView(docID123: ad.docID)));
      },
      child: Card(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildImageWidget(),
          //_buildTitleWidget(),
          //SizedBox(height: 5,),
          //_buildPriceWidget(),
          //
          //_buildLocationWidget(),
          //Container(
          //  alignment: Alignment.bottomRight,
          //  child: _buildTimeWidget(),
          //),
          SizedBox(height: 5,),  
          Text('  ${ad.value1}'.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
          SizedBox(height: 2,),
          //Text('  Rs ${ad.value2}'),
          Row(
            children: <Widget>[
              SizedBox(width: 5,),
              Card(
            child: Text("Price : Rs "+ad.value2+' /=', style:TextStyle(background: Paint()
                    ..strokeWidth = 6.0
                    ..color = Colors.yellow
                    ..style = PaintingStyle.stroke
                    ..strokeJoin = StrokeJoin.round
                    ) 
                  ),
            //color: Colors.yellow,
            
            //margin: EdgeInsets.all(5),
          ),
            ],
          ),
          //const DecoratedBox(
          //  decoration: const BoxDecoration(color: Colors.blue,),
          //  child: const Text('Some text...'),
          //),
          SizedBox(height: 2,),
          Row(
            children: <Widget>[
              Icon(Icons.check, color: Colors.redAccent,size: 18,),
              Expanded(child: Text(ad.value3))
            ],
          ),
          //StatefulBuilder(
          //  builder: (context, setState){
          //     return Container(
          //       child: Column(
          //         children: <Widget>[
          //           Text("ranish"),
          //           RaisedButton(
          //             child: Text("ranish"),
          //             onPressed: (){
          //               mynum++;
          //             },
          //           ),
          //           Text(mynum.toString()),
          //         ],
          //       ),
          //     );
          //  }
          //),
          //SizedBox(height: 2,),
          Container(
            alignment: Alignment.bottomRight,
            child: IconButton(
                icon: Icon(Icons.add_shopping_cart),
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (context) {
                      int urnum = 1;
                      double subtotal = double.parse(ad.value2);
                      String contentText = "Content of Dialog";
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            title: Text("Select Quantity"),
                            content: Column(
                              children: <Widget>[

                                SizedBox(height: 30,),
                                Text("Item : "+ad.value1),
                                SizedBox(height: 10,),
                                Text("Unit Price : Rs."+ad.value2+" /="),
                                SizedBox(height: 15,),
                                Text("Category : "+ad.value3),
                                SizedBox(height: 15,),
                                
                                Text("____________"),
                                SizedBox(height: 15,),
                                
                                Text('Quantity'),
                                SizedBox(height: 10,),
                                Text(urnum.toString() +" units", style: TextStyle(fontSize: 26),),
                                //Text(ad.value1),
                                SizedBox(height: 20,),
                                //Row Start
                                Row(
                                      children: <Widget>[
                                        SizedBox(width: 15,),
                                        RaisedButton(
                                      onPressed: () {
                                      setState(() {
                                        //contentText = "Changed Content of Dialog";
                                        urnum++;
                                        subtotal = (double.parse(ad.value2))*urnum;
                                      });
                                    },
                                    child: Text("+", style: TextStyle(fontSize: 26),),
                                    ),
                                    SizedBox(width: 20,),
                                    RaisedButton(
                                      onPressed: () {
                                        if(urnum!=1){
                                          setState(() {
                                          //contentText = "Changed Content of Dialog";
                                          urnum--;
                                          subtotal = (double.parse(ad.value2))*urnum;
                                      });
                                        }

                                    },
                                    child: Text("-", style: TextStyle(fontSize: 26),),
                                    ),
                                      ],
                                ),
                                SizedBox(height: 15,),
                                Text("____________"),
                                SizedBox(height: 15,),


                                //Row end
                                //SizedBox(height: 30,),
                                //Text("Item : "+ad.value1),
                                //SizedBox(height: 10,),
                                //Text("Unit Price : "+ad.value2),
                                
                                Text("Total Price for this Product"),
                                SizedBox(height: 15,),
                                Text('Rs '+subtotal.toString()+' /=', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),

                                SizedBox(height: 15,),
                                Text("____________"),
                                SizedBox(height: 15,),


                                //2 nd row start
                                Row(
                                      children: <Widget>[
                                        SizedBox(width: 15,),
                                        RaisedButton(
                                      onPressed: () {
                                        Firestore.instance.collection('cart').document('$email').collection("items").document(ad.docID).setData({
                                        //'value0': mylist,
                                        'value1':ad.value1,
                                        'value2':ad.value2,
                                        'value3':ad.value3,
                                        'count':urnum.toString(),
                                        'subtotal':subtotal.toString(),
                                        'value4':DateTime.now().toString().substring(0, DateTime.now().toString().length - 10 ),
                                        });
                                        Navigator.pop(context);
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        
                                        Text("ADD to"),
                                        Icon(Icons.shopping_cart),
                                      ],
                                    ),
                                    ),
                                    SizedBox(width: 20,),
                                    RaisedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("Cancel"),
                                    ),
                                  ],
                                ),
                                //2 nd row END 


                                
                                
                              ],
                            ),
                            //actions: <Widget>[
                            //  FlatButton(
                            //    onPressed: () => Navigator.pop(context),
                            //    child: Text("Cancel"),
                            //  ),
                            //  FlatButton(
                            //    onPressed: () {
                            //      setState(() {
                            //        contentText = "Changed Content of Dialog";
                            //        urnum++;
                            //      });
                            //    },
                            //    child: Text("Change"),
                            //  ),
                            //],
                          );
                        },
                      );
                    },
                  );
                },
              ),
          ),
          //SizedBox(height: 2,),
          Container(
            alignment: Alignment.bottomRight,
            child: Text("More than ${ad.value4} units Available ",style: TextStyle(color: Colors.grey),),
          ),
        ],
      ),
    )
    );
  }
}


class AadCardForCardGrid extends StatelessWidget {

  AadCardForCardGrid(this.ad);
  String documentid;
  ItemModel ad;

  //var name1;

  //String name1 = ad.docID.toString();
  //Widget _buildImageWidget() {
  //  //documentid = ad.docID;
  //  if (ad.carimage != null && ad.carimage != '') {
  //    //return Image.network(ad.carimage);
  //    return Stack(
  //      children: <Widget>[
  //        Image.network(ad.carimage),
  //        
  //        //Center(child: Text(ad.value2,textDirection: ,),)
  //        //Card(
  //        //  child: Text("Rs "+ad.value2),
  //        //  color: Colors.yellow,
  //        //  margin: EdgeInsets.all(10),
  //        //  
  //        //  //shape: CircleBorder(),  
  //        //),
  //      ],
  //    );
  //  } else {
  //    return Image.network('https://uae.microless.com/cdn/no_image.jpg');
  //  }
  //  
  //}
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        //'/itemview'
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ItemView(docID123: ad.docID)));
      },
      child: Card(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          SizedBox(height: 5,),  
          Text('  ${ad.value1}'.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
          SizedBox(height: 2,),
          //Text('  Rs ${ad.value2}'),
          Row(
            children: <Widget>[
                  SizedBox(width: 5,),
                  Card(
                child: Text(" Rs "+ad.subtotal, style:TextStyle(background: Paint()
                        ..strokeWidth = 6.0
                        ..color = Colors.yellow
                        ..style = PaintingStyle.stroke
                        ..strokeJoin = StrokeJoin.round
                        ) 
                      ),
                //color: Colors.yellow,

                //margin: EdgeInsets.all(5),
              ),
              SizedBox(width: 30,),
              IconButton(
                alignment: Alignment.bottomRight,
                icon: Icon(Icons.delete),
                onPressed: (){
                  Firestore.instance.collection('cart').document('$email').collection("items").document(ad.docID).delete();
                  
                },
              ),
              
            ],
          ),
          //const DecoratedBox(
          //  decoration: const BoxDecoration(color: Colors.blue,),
          //  child: const Text('Some text...'),
          //),
          SizedBox(height: 2,),
          Row(
            children: <Widget>[
              Icon(Icons.arrow_right, color: Colors.redAccent,size: 18,),
              Expanded(child: Text(ad.value3))
            ],
          ),
          SizedBox(height: 2,),
          //
          //Container(
          //  alignment: Alignment.bottomRight,
          //  child: IconButton(
          //      alignment: Alignment.bottomRight,
          //      icon: Icon(Icons.delete),
          //      onPressed: (){
          //        Firestore.instance.collection('cart').document('$email').collection("items").document(ad.docID).delete();
          //        
          //      },
          //    ),
          //),
          //
          Text("   ${ad.value2} "+"*"+" ${ad.count}   "),
          //
          Container(
            alignment: Alignment.bottomRight,
            child: Text(" ${ad.value4}  ",style: TextStyle(color: Colors.grey),),
          ),
        ],
      ),
    )
    );
  }
}



//CARD OF THE ORDER Viewport
class AadOrderCardGrid extends StatelessWidget {

  AadOrderCardGrid(this.ad);
  String documentid;
  OrderModel ad;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        //'/itemview'
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Orderview(docID123: ad.docID)));
      },
      child: Card(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            //alignment: Alignment.bottomRight,
            child: Text(" ${ad.docID}  ",style: TextStyle(color: Colors.grey),),
          ),
          SizedBox(height: 5,),  
          Text("Customer ID : "+ '${ad.userid}'+ " | name :  "+  '${ad.username}'.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
          SizedBox(height: 2,),
          //Text('  Rs ${ad.value2}'),
          Row(
            children: <Widget>[
                  SizedBox(width: 5,),
                  Card(
                child: Text(" Rs "+ad.total, style:TextStyle(background: Paint()
                        ..strokeWidth = 6.0
                        ..color = Colors.yellow
                        ..style = PaintingStyle.stroke
                        ..strokeJoin = StrokeJoin.round
                        ) 
                      ),
                //color: Colors.yellow,

                //margin: EdgeInsets.all(5),
              ),
              SizedBox(width: 30,),
              //IconButton(
              //  alignment: Alignment.bottomRight,
              //  icon: Icon(Icons.delete),
              //  onPressed: (){
              //    //Firestore.instance.collection('orders').document(ad.docID).delete();
              //    
              //    
              //  },
              //),
              
            ],
          ),
          //const DecoratedBox(
          //  decoration: const BoxDecoration(color: Colors.blue,),
          //  child: const Text('Some text...'),
          //),
          SizedBox(height: 2,),
          Row(
            children: <Widget>[
              Icon(Icons.location_on, color: Colors.redAccent,size: 18,),
              Expanded(child: Text(ad.value3))
            ],
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: Text("Order State : ${ad.orderstate}  ",style: TextStyle(color: Colors.grey),),
          ),
        ],
      ),
    )
    );
  }
}



//Pharmacy Hostory view
class AadPharmacyCardGrid extends StatelessWidget {

  AadPharmacyCardGrid(this.ad);
  String documentid;
  PharmacyModel ad;

  Widget _buildImageWidget() {
    //documentid = ad.docID;
    if (ad.prescriptionimage != null && ad.prescriptionimage != '') {
      //return Image.network(ad.carimage);
      return Stack(
        children: <Widget>[
          Image.network(ad.prescriptionimage),
          
          
        ],
      );
    } else {
      return Image.network('https://uae.microless.com/cdn/no_image.jpg');
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        //'/itemview'
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PharmacyItemView(docID123: ad.docID)));
      },
      child: Card(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            //alignment: Alignment.bottomRight,
            child: Text(" ${ad.docID}  ",style: TextStyle(color: Colors.grey),),
          ),
          SizedBox(height: 5,),  
          Text("Customer ID : "+ '${ad.userid}'+ " | name :  "+  '${ad.username}'.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
          SizedBox(height: 2,),
          //Text('  Rs ${ad.value2}'),
          _buildImageWidget(),
          SizedBox(height: 2,),
          Row(
            children: <Widget>[
                  SizedBox(width: 5,),
              //    Card(
              //  child: Text(" Rs "+ad.total, style:TextStyle(background: Paint()
              //          ..strokeWidth = 6.0
              //          ..color = Colors.yellow
              //          ..style = PaintingStyle.stroke
              //          ..strokeJoin = StrokeJoin.round
              //          ) 
              //        ),
              //  //color: Colors.yellow,
//
              //  //margin: EdgeInsets.all(5),
              //),
              SizedBox(width: 30,),
              //IconButton(
              //  alignment: Alignment.bottomRight,
              //  icon: Icon(Icons.delete),
              //  onPressed: (){
              //    //Firestore.instance.collection('orders').document(ad.docID).delete();
              //    
              //    
              //  },
              //),
              
            ],
          ),
          //const DecoratedBox(
          //  decoration: const BoxDecoration(color: Colors.blue,),
          //  child: const Text('Some text...'),
          //),
          SizedBox(height: 2,),
          Row(
            children: <Widget>[
              Icon(Icons.location_on, color: Colors.redAccent,size: 18,),
              Expanded(child: Text(ad.value3))
            ],
          ),
          //Container(
          //  alignment: Alignment.bottomRight,
          //  child: Text("Order State : ${ad.orderstate}  ",style: TextStyle(color: Colors.grey),),
          //),
        ],
      ),
    )
    );
  }
}