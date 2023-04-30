import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:rebecca_delight_back/Screens/popular.dart';

import '../constants/contstants.dart';
import '../utils/utils.dart';
import 'home_screen.dart';


class Extra_Chezain extends StatefulWidget {
  const Extra_Chezain({Key? key}) : super(key: key);

  @override
  State<Extra_Chezain> createState() => _Extra_ChezainState();
}

class _Extra_ChezainState extends State<Extra_Chezain> {

  bool loading = false;
  File? _image;
  final picker = ImagePicker();
  Future getGalleryImage()async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if(pickedFile != null){

        _image = File(pickedFile.path);
      }else{
        print('No image selected');
      }
    });

  }

  final FirebaseAuth _auth = FirebaseAuth.instance ;
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  final _formKey = GlobalKey<FormState>();

  final firestore = FirebaseFirestore.instance.collection('Food_Items');
  //final databaseRef =FirebaseDatabase.instance.ref('Post');
  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();
  TextEditingController Categorycontroller = TextEditingController();

  void dispose() {
    // TODO: implement dispose
    super.dispose();

    namecontroller.dispose();
    pricecontroller.dispose();
    descriptioncontroller.dispose();
    timecontroller.dispose();
    Categorycontroller.dispose();
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
           ListTile(
            leading: Icon(
              Icons.home,
              color: appColor2,
            ),
            title: Text(
              'Home',
              style: sadaF,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
            },

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
          const ListTile(
            leading: Icon(
              Icons.takeout_dining,
              color: appColor2,
            ),
            title: Text(
              'Extra Chezain',
              style: sadaF,
            ),

          ),
          const Divider(
            color: appColor1,
          ),


        ]),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    TextFormField(
                      controller: namecontroller,
                      decoration: const InputDecoration(
                        hintText: 'Enter Food name',
                      ),
                    ),

                  ],
                ),
                Column(
                  children: [
                    Center(
                      child: InkWell(
                        onTap: (){
                          getGalleryImage();
                        },
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black
                              )
                          ),
                          child: _image!= null ? Image.file(_image!.absolute) : Icon(Icons.image),
                        ),
                      ),
                    )

                  ],
                ),
                Column(
                  children: [
                    TextFormField(
                      controller: pricecontroller,
                      decoration: InputDecoration(
                        hintText: 'Price',
                      ),
                    ),

                  ],
                ),
                Column(
                  children: [
                    TextFormField(
                      controller: descriptioncontroller,
                      decoration: InputDecoration(
                        hintText: 'Enter Description',
                      ),
                    ),

                  ],
                ),
                Column(
                  children: [
                    TextFormField(
                      controller: Categorycontroller,
                      decoration: InputDecoration(
                        hintText: 'Category',
                      ),
                    ),

                  ],
                ),
                Column(
                  children: [
                    TextFormField(
                      controller: timecontroller,
                      decoration: InputDecoration(
                        hintText: 'Delivery Time',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: InkWell(
                        onTap: ()async{
                          setState(() {
                            loading = true;
                          });
                          var id = DateTime.now().millisecondsSinceEpoch.toString();
                          firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/stuff/'+id);
                          firebase_storage.UploadTask uplaodTask = ref.putFile(_image!.absolute);

                          await Future.value(uplaodTask).then((value) async{
                            var newUrl = await ref.getDownloadURL();


                            firestore.doc(id).set({
                              'id' : id,
                              'name': namecontroller.text.toString(),
                              'description': descriptioncontroller.text.toString(),
                              'price': pricecontroller.text.toString(),
                              'delivery_time': timecontroller.text.toString(),
                              'image' : newUrl.toString(),
                              'category' : Categorycontroller.text.toString(),

                            }).then((value) {
                              setState(() {
                                loading = false;
                              });
                              Utils().toastMessage('Uploaded');

                            }).onError((error, stackTrace) {
                              setState(() {
                                loading = false;
                              });
                              Utils().toastMessage(error.toString());

                            });
                          });



                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(colors: [appColor1, appColor2])
                          ),
                          child: Center(
                              child:loading? CircularProgressIndicator(strokeWidth: 3, color: Colors.white,):Text( 'Enter', style: TextStyle(fontSize: 25, color: Colors.white),)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
