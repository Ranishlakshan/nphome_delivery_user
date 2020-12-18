import 'package:flutter/material.dart';

import '../login_page.dart';

class BottomNvBar extends StatefulWidget {
  @override
  _BottomNvBarState createState() => _BottomNvBarState();
}

class _BottomNvBarState extends State<BottomNvBar> {
  int selectedindex=6;
  String loginORnot="";

  void initState() {
    // TODO: implement initState
    if(email!=null){
      print("NO EMAIL");
      loginORnot="NO EMAIL";
    }
    else{
      print("I HAVE EMAIL"+ '$email');
      loginORnot="I HAVE EMAIL";
    }
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
        buildNavBarIte(Icons.home,0,"/firstpage"),
        buildNavBarIte(Icons.search,1,"/searchtest"),
        buildNavBarIte(Icons.favorite,2,"/hotdeals"),
        buildNavBarIte(Icons.category,3,"/categories"),
        buildNavBarIte(Icons.shopping_cart,4,"/cartview"),
        
      ],
    );
  }

  Widget buildNavBarIte(IconData icon,int index,String route) {
    return GestureDetector(
          onTap: (){
            setState(() {
              selectedindex=index;              
            });
            Navigator.pushReplacementNamed(context, route);
            
          },
          child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width/5,
          decoration: BoxDecoration(
            //color: Colors.white
            color: index==selectedindex ? Colors.green : Colors.white
          ),
          child: Icon(icon),
          
        ),
    );
  }
}