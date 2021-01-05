import 'package:flutter/material.dart';
import '';

class MainListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      child: ListView(
        shrinkWrap : true,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SizedBox(width: 15,),
          InkWell(
            child: Column(
               children: <Widget>[
                Icon(Icons.category, size: 40,color: Colors.green,),
                SizedBox(height: 8,),
                //Image(image: AssetImage('images/listview/catagory.png'),fit: BoxFit.cover,height: 50,width: 50,),
                Text('Catagories')
                 
               ],
            ),
            onTap: (){
              Navigator.pushNamed(context, "/categories");
            },
          ),
          SizedBox(width: 25,),
          InkWell(
            child: Column(
               children: <Widget>[
                 Icon(Icons.favorite, size: 40,color: Colors.red,),
                SizedBox(height: 8,),
                //Image(image: AssetImage('images/listview/catagory.png'),fit: BoxFit.cover,height: 50,width: 50,),
                Text('Hot Deals')
                 
               ],
            ),
            onTap: (){
              Navigator.pushNamed(context, "/hotdeals");
            },
          ),
          SizedBox(width: 25,),
          
          InkWell(
            child: Column(
               children: <Widget>[
                Icon(Icons.local_pharmacy, size: 40,color: Colors.red,),
                SizedBox(height: 8,),
                //Image(image: AssetImage('images/listview/catagory.png'),fit: BoxFit.cover,height: 50,width: 50,),
                Text('Pharmacy')
                 
               ],
            ),
            onTap: (){
              Navigator.pushNamed(context, "/pharmacyInterface");
            },
          ),
          SizedBox(width: 25,),
          InkWell(
            child: Column(
               children: <Widget>[
                Icon(Icons.graphic_eq, size: 40,color: Colors.blue),
                SizedBox(height: 8,),
                //Image(image: AssetImage('images/listview/catagory.png'),fit: BoxFit.cover,height: 50,width: 50,),
                Text('ගෑස් වර්ග')
                 
               ],
            ),
            onTap: (){
              Navigator.pushNamed(context, "/specialGas");
            },
          ),
          SizedBox(width: 25,),
          InkWell(
            child: Column(
               children: <Widget>[
                Icon(Icons.book, size: 40,color: Colors.yellow,),
                SizedBox(height: 8,),
                //Image(image: AssetImage('images/listview/catagory.png'),fit: BoxFit.cover,height: 50,width: 50,),
                Text('Stationary')
                 
               ],
            ),
            onTap: (){
              Navigator.pushNamed(context, "/specialStationary");
            },
          ),
          SizedBox(width: 25,),
          InkWell(
            child: Column(
               children: <Widget>[
                Icon(Icons.face, size: 40,color: Colors.pink),
                SizedBox(height: 8,),
                //Image(image: AssetImage('images/listview/catagory.png'),fit: BoxFit.cover,height: 50,width: 50,),
                Text('Facial Care')
                 
               ],
            ),
            onTap: (){
              Navigator.pushNamed(context, "/specialFacialCare");
            },
          ),
          SizedBox(width: 25,),
          InkWell(
            child: Column(
               children: <Widget>[
                 Icon(Icons.face, size: 40,color: Colors.grey),
                SizedBox(height: 8,),
                //Image(image: AssetImage('images/listview/catagory.png'),fit: BoxFit.cover,height: 50,width: 50,),
                Text('Hair Care')
                 
               ],
            ),
            onTap: (){
              Navigator.pushNamed(context, "/specialHairCare");
            },
          ),
          SizedBox(width: 25,),
          //InkWell(
          //  child: Column(
          //     children: <Widget>[
          //      Icon(Icons.more, size: 40,),
          //      SizedBox(height: 8,),
          //      //Image(image: AssetImage('images/listview/catagory.png'),fit: BoxFit.cover,height: 50,width: 50,),
          //      Text('Essentials')
          //       
          //     ],
          //  ),
          //  onTap: (){
          //    Navigator.pushNamed(context, "/specialEssentials");
          //  },
          //),
           SizedBox(width: 15,),
          

          
          //InkWell(
          //  child: Listitmes(
          //    image_location: 'images/listview/catagory.png',
          //    image_caption: 'ranish',  
          //  ),
          //  onTap: (){
          //    Navigator.pushNamed(context, "/catago");
          //  },
          //),
          
          //Listitmes(
          //  image_location: 'images/listview/catagory.png',
          //  image_caption: 'Catagories',
          //  
          //   
          //),
          ////edited up here
          //Listitmes(
          //  image_location: 'images/listview/catagory.png',
          //  image_caption: 'Catagories',
          //  
          //),
          //Listitmes(
          //  image_location: 'images/listview/catagory.png',
          //  image_caption: 'Hot Deals',
          //),
          //Listitmes(
          //  image_location: 'images/listview/catagory.png',
          //  image_caption: 'Bid here',
          //),
          //Listitmes(
          //  image_location: 'images/listview/catagory.png',
          //  image_caption: 'Catagories',
          //),
          //Listitmes(
          //  image_location: 'images/listview/catagory.png',
          //  image_caption: 'Catagories',
          //),
          //Listitmes(
          //  image_location: 'images/listview/catagory.png',
          //  image_caption: 'Catagories',
          //),
          //Listitmes(
          //  image_location: 'images/listview/catagory.png',
          //  image_caption: 'Catagories',
          //),
          //Listitmes(
          //  image_location: 'images/listview/catagory.png',
          //  image_caption: 'Catagories',
          //),
          //Listitmes(
          //  image_location: 'images/listview/catagory.png',
          //  image_caption: 'Catagories',
          //),
          //
          //
          

        ],
      ),
    );
  }
}

//class Listitmes extends StatelessWidget {
//  final String image_location;
//  final String image_caption;
//
//  
//  Listitmes({
//    this.image_location,
//    this.image_caption
//
//    
//  });
//
//  
//  @override
//  Widget build(BuildContext context) {
//    return Padding(padding: const EdgeInsets.all(2.0),
//    child: InkWell(onTap: (){},
//    child: Container(
//          width: 90.0,
//          child: ListTile(
//        title: Image.asset(
//          image_location,
//          width: 50.0,
//          height: 50.0,
//          ),
//        subtitle: Container(
//          alignment: Alignment.topCenter,
//          child: Text(image_caption),
//        ),
//      ),
//    ),
//    ),
//      
//    );
//  }
//}
//
