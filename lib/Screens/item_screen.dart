import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants/contstants.dart';
import '../constants/reusable.dart';

class item_screen extends StatelessWidget {
  final String image, name, price,text, time;
  final VoidCallback onTap_;
  final VoidCallback onTap2;
   item_screen({Key? key,required this.onTap_ ,
     required this.onTap2,required this.image,
     required this.text, required this.name,
     required this.price, required this.time,
     }) : super(key: key);

  final firestore = FirebaseFirestore.instance.collection('Food_Items').snapshots();

  CollectionReference ref = FirebaseFirestore.instance.collection('Food_Items');

  int count =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [Container(
              decoration: const BoxDecoration(
                  color: Colors.black,

                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(200),
                      bottomRight: Radius.circular(200)
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.white,
                    )
                  ]
              ),
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 1,

            ),
            Image(
                height: 200,
                image: NetworkImage(image))],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              children: [


                GradientIcon(Icons.star, 30, LinearGradient(
                  colors: [appColor1,appColor2]
                ),
                ),

                GradientIcon(Icons.star, 30, LinearGradient(
                    colors: [appColor1,appColor2]
                ),
                ),

                GradientIcon(Icons.star, 30, LinearGradient(
                    colors: [appColor1,appColor2]
                ),
                ),

                GradientIcon(Icons.star, 30, LinearGradient(
                    colors: [appColor1,appColor2]
                ),
                ),

                GradientIcon(Icons.star_border, 30, LinearGradient(
                    colors: [appColor1,appColor2]
                ),
                ),

                Expanded(

                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text('Rs. ' +price, style: txtstyll,)))
              ],
            ),
          ),


           Padding(
             padding: const EdgeInsets.symmetric(vertical: 15.0),
             child: Row(
              children: [
                Text(name , style: txtstyllb,),

              ],
          ),
           ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              children: [
                Flexible(child: Text(text , style: txtstyllc,))

              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Delivery Time', style: txtstyll,),
                Text(time+ ' mnts', style: txtstyll,)
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
               onTap:onTap_,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.42,
                  height: 50,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [appColor1,appColor2]),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:  Center(child: Text('Update', style: txtstyllb,)),
                ),
              ),

              InkWell(
                onTap: onTap2,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.42,
                  height: 50,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [appColor1,appColor2]),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child:  Center(child: Text('Delete', style: txtstyllb,)),
                ),
              ),
            ],
          ),




        ],
    ),
      ),);
  }
}
