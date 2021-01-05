
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'components/bottomnecbar.dart';
import 'db_components/car_item_model.dart';
import 'drawer.dart';
import 'login_page.dart';

class AddPharmacyScript extends StatefulWidget {
  @override
  _AddPharmacyScriptState createState() => _AddPharmacyScriptState();
}

class _AddPharmacyScriptState extends State<AddPharmacyScript> {
  
  List<Asset> images = List<Asset>();
  bool carosal = false;
  String _error = 'No Error Dectected';
  List<String> imageUrls = <String>[];

  String useraddress,userid,username,userphone,docmailID;

  var myuser;
  List<UserModel> myuserdocuments = <UserModel>[];
  UserModel userobj = new UserModel("","","","","");  
  
  

@override
  void initState() {

    
  userobj.getCurrentUserData().then((result) {
      setState(() {
        myuser = result;
      });
    });
    //print("---------------------------Email is $email");
    //signInWithGoogle();
    
    super.initState();


    //print();
    
  }


Future<dynamic> postImage(Asset imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    print(storageTaskSnapshot.ref.getDownloadURL());
    return storageTaskSnapshot.ref.getDownloadURL();
  }

void uploadImages(){
  
    for ( var imageFile in images) {
      postImage(imageFile).then((downloadUrl) {
        imageUrls.add(downloadUrl.toString());
        if(imageUrls.length==images.length){
          String documnetID = DateTime.now().millisecondsSinceEpoch.toString();
          
          Firestore.instance.collection('pharmacy').document(documnetID).setData({
            'urls':imageUrls,
            'email' : '$email',
            'useraddress': useraddress,
            'username' : username,
            'userid': userid,
            'userphone': userphone,
            'value3':DateTime.now().toString().substring(0, DateTime.now().toString().length - 10 ),
            
            

          }).then((_){
            
            //SnackBar snackbar = SnackBar(content: Text('Data Uploaded Successfully'));
            //widget.globalKey.currentState.showSnackBar(snackbar);
            setState(() {
              images = [];
              imageUrls = [];
              carosal =false;
              
            });
          });
        }
      }).catchError((err) {
        print(err);
      });
    }

  }


  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Upload Image",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      print(resultList.length);
      print((await resultList[0].getThumbByteData(122, 100)));
      print((await resultList[0].getByteData()));
      print((await resultList[0].metadata));

    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      images = resultList;
      carosal = true;
      print('<<<<<<<<<<<<<<<<<<<');
      print(images);
      
      
      //_listOfImages = imageUrls.cast<NetworkImage>();
      _error = error;
    });
  }

  Widget _imageShow(){
    if(carosal==true){
      return CarouselSlider(
        items: images
        .map((e) => AssetThumb(asset:e, width: 300, height: 300,))
        .toList(),
        options: CarouselOptions(
          height: 400,
          aspectRatio: 16 /9 ,
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

        ),  
      );
    }
    else{
      //return Text('   Images not yet selected');
      return Text('   Images not yet selected | තවම චායාරූප තෝරාගෙන නැත');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNvBar(),
      appBar: AppBar(
        backgroundColor: Colors.amber[400],
        title: Text("Add Pharmacy Script"),
      ),
      //drawer: MyDrawer(),
      body: ListView(
        children: <Widget>[
          StreamBuilder(
            stream: myuser,
            builder: (context, snapshot)  {
              if(snapshot.hasData){
                //String useraddress,userid,username,userphone,docmailID;

                docmailID = snapshot.data.documentID;
                useraddress = snapshot.data['useraddress'];
                userid = snapshot.data['userid'];
                username = snapshot.data['username'];
                userphone = snapshot.data['userphone'];

                myuserdocuments.add(UserModel(useraddress, userid, username, userphone, docmailID));
                return Text(" ");
                //return Text("I have data"+ docmailID+useraddress+userid+username+userphone);
              }
              else{
                return Text("I have no data");
              }
            },
          ),
          SizedBox(height: 25,),
          RaisedButton(
            //child: Text("Add Photos"),
            
            child: Text("Add Photos of my Prescription (බෙහෙත් වට්ටෝරුව )"),
            onPressed: loadAssets,
          ),
          SizedBox(height: 25,),
          _imageShow(),
          SizedBox(height: 25,),
          RaisedButton(
            child: Text("Send Prescription"),
            onPressed: (){
              if(images.length==0){
                  showDialog(context: context,builder: (_){
                    return AlertDialog(
                      backgroundColor: Theme.of(context).backgroundColor,
                     content: Text("No image selected",style: TextStyle(color: Colors.white)),
                     actions: <Widget>[
                      RaisedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Center(child: Text("Ok",style: TextStyle(color: Colors.white),)),
                      )
                      
                     ],
                    );
                  });
                }
                else{
                  //await pr.show();
                  //SnackBar snackbar = SnackBar(content: Text('Please wait, Uploading details'));
                  //widget.globalKey.currentState.showSnackBar(snackbar);
                  uploadImages();
                  //Navigator.pushNamed(context, "/Uploadpg");
                  //Navigator.pushNamed(context, "/aliexpresspg");  
                  //Navigator.pushReplacementNamed(context, "/uploadwait");
                }
            },
          ),

        ],
      ),
    );
  }
}