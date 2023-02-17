import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rebecca_delight_back/Screens/extra_chezain.dart';
import 'package:rebecca_delight_back/Screens/item_screen.dart';
import 'package:rebecca_delight_back/Screens/popular.dart';
import 'package:rebecca_delight_back/utils/utils.dart';

import '../constants/contstants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../constants/reusable.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;

  final firestore = FirebaseFirestore.instance.collection('Food_Items').snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection('Food_Items');



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [appColor1, appColor2],
          ),
        ),
      ),

      title: const Text(
        "Rebecca's Delight Retailer",
        style: TextStyle(fontSize: 25),
      ),

      // automaticallyImplyLeading: false,
    ),
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
          const UserAccountsDrawerHeader(

              decoration: BoxDecoration(
                color: appColor1,
              ),


              accountName: Text(
                'Taimoor',
                style: txtstyll,
              ),
              accountEmail: null),
          const ListTile(
            leading: Icon(
              Icons.home,
              color: appColor2,
            ),
            title: Text(
              'Home',
              style: sadaF,
            ),

          ),
          const Divider(
            color: appColor1,
          ),
           ListTile(
            leading: const Icon(
              Icons.local_fire_department_outlined,
              color: appColor2,
            ),
            title: const Text(
              'Popular',
              style: sadaF,
            ),
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>Popular()));
            },
          ),

          const Divider(
            color: appColor1,
          ),
          ListTile(
            leading: const Icon(
              Icons.takeout_dining,
              color: appColor2,
            ),
            title: const Text(
              'Add Items',
              style: sadaF,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Extra_Chezain()));
            },
          ),
          const Divider(
            color: appColor1,
          ),


        ]),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: StreamBuilder<QuerySnapshot>(

                stream: firestore,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return CircularProgressIndicator();
                  }


                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index){
                        var test = snapshot.data!.docs[index];
                        return InkWell(
                          onTap: (){

                            Navigator.push(context, MaterialPageRoute(builder: (context)=> item_screen(
                              image: test['image'].toString(),
                              text:test['description'].toString(),
                              name: test['name'].toString(),
                              price: test['price'].toString(),
                              time: test['delivery_time'].toString(),
                              onTap_: () {

                                ref.doc(test['id'].toString()).update({
                                  'name' : 'Taimoor'
                                }).then((value){
                                  Utils().toastMessage('updated');
                                  print('ok');
                                }).onError((error, stackTrace) {
                                  Utils().toastMessage(error.toString());
                                  print('no k');

                                });
                              }, onTap2: () {
                                ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                                setState(() {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                                });
                            },

                            )));
                          },
                          child:    wideContainer(
                            image: test['image'].toString(),
                            name: test['name'].toString(),
                            english:  test['description'].toString(),
                            price: test['price'].toString(),
                            rating: "4.2  (100+)",
                            icon: Icons.star,
                            icon2: Icons.star,
                            icon3: Icons.star_border,
                          )
                        );

                      });
                }),
          ),
        ),
      ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Extra_Chezain()));
          },
          backgroundColor: Colors.white,
          child: GradientIcon(Icons.add, 40,
              const LinearGradient(colors: [appColor1, appColor2])),
        )
    );
  }
}
