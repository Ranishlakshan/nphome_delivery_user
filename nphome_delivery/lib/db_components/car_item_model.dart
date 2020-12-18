import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../login_page.dart';

class CarModel {
  String value1;
  String value2;
  String value3;
  String value4;
  //String caryear;
  String carimage;
  String docID;

  CarModel(String value1, String value2,String value3, String value4, String carimage ,String docID){
    this.value1 = value1;
    this.value2 = value2;
    this.value3 = value3;
    this.value4 = value4;
    this.carimage = carimage;
    this.docID = docID;
  }

  getData() async {
    return await Firestore.instance.collection('ads').orderBy('value4',descending: true).snapshots();
    
  }

  getCart() async {
    return await Firestore.instance.collection('cart').document('$email').collection("items").snapshots();
    
  }

  getHotdealsData() async {
    return await Firestore.instance.collection('hotdeals').snapshots();
    
  }
  //getUserData
  getUserData() async {
    return await Firestore.instance.collection('users').snapshots();
    
  }



//void setcarBrand(String carBrand){
//this.carBrand = carBrand;
//}
//
//void setcarYear(String carYear){
//this.carBrand = carYear;
//}
//
//void setcarImage(String carImage){
//this.carBrand = carBrand;
//}
//
//void setdocID(String docID){
//  this.docID = docID;
//}
//
//String getBrand(){
//  return carBrand;
//}
//String getYear(){
//  return caryear;
//}
String getdocID(){
  return docID;
}

getSearch(String text) async {
  
  //String 
    //Stream<QuerySnapshot> snapshot1 = await Firestore.instance.collection('ads').where(['searchkey','brand'], arrayContains: text ).snapshots();
    //Stream<QuerySnapshot> snapshot2 = await Firestore.instance.collection('ads').where(['searchkey','brand'], arrayContains: text ).snapshots();
    //QuerySnapshot snapshot = Observer ;
    //return await Firestore.instance.collection('ads').where('searchkey', isGreaterThanOrEqualTo: text ).snapshots();
    //return await Firestore.instance.collection('ads').where('searchkey', isGreaterThanOrEqualTo: text  ).snapshots();
    //return await Firestore.instance.collection('ads').where("searchkey" ,isGreaterThanOrEqualTo: text ).snapshots();
    return await Firestore.instance.collection('ads').snapshots();


}
}

class ItemModel {
  String value1;
  String value2;
  String value3;
  String value4;
  //String caryear;
  //String carimage;
  String docID;
  String count;
  String subtotal;

  ItemModel(String value1, String value2,String value3, String value4,String docID,String subtotal,String count){
    this.value1 = value1;
    this.value2 = value2;
    this.value3 = value3;
    this.value4 = value4;
    this.subtotal = subtotal;
    this.count = count;
    //this.carimage = carimage;
    this.docID = docID;
  }

  
  getHotdealsData() async {
    return await Firestore.instance.collection('hotdeals').snapshots();
    
  }

String getdocID(){
  return docID;
}

getSearch(String text) async {
    return await Firestore.instance.collection('ads').snapshots();


}
}