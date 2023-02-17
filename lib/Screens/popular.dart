// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
//
// import '../constants/contstants.dart';
// import '../utils/utils.dart';
// import 'extra_chezain.dart';
// import 'home_screen.dart';
//
//
// class Popular extends StatefulWidget {
//   const Popular({Key? key}) : super(key: key);
//
//   @override
//   State<Popular> createState() => _PopularState();
// }
//
// class _PopularState extends State<Popular> {
//
//   bool loading = false;
//   File? _image;
//   final picker = ImagePicker();
//   Future getGalleryImage()async{
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
//     setState(() {
//       if(pickedFile != null){
//
//         _image = File(pickedFile.path);
//       }else{
//         print('No image selected');
//       }
//     });
//
//   }
//
//   final FirebaseAuth _auth = FirebaseAuth.instance ;
//   firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
//
//   final _formKey = GlobalKey<FormState>();
//
//   final firestore = FirebaseFirestore.instance.collection('Popular');
//   //final databaseRef =FirebaseDatabase.instance.ref('Post');
//   TextEditingController namecontroller = TextEditingController();
//   TextEditingController pricecontroller = TextEditingController();
//   TextEditingController descriptioncontroller = TextEditingController();
//   TextEditingController typecontroller = TextEditingController();
//   TextEditingController Categorycontroller = TextEditingController();
//
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//
//     namecontroller.dispose();
//     pricecontroller.dispose();
//     descriptioncontroller.dispose();
//     typecontroller.dispose();
//     Categorycontroller.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [appColor1, appColor2],
//             ),
//           ),
//         ),
//
//         title: const Text(
//           "Rebecca's Delight Retailer",
//           style: TextStyle(fontSize: 25),
//         ),
//
//         // automaticallyImplyLeading: false,
//       ),
//       drawer: Drawer(
//         child: ListView(padding: EdgeInsets.zero, children: [
//           UserAccountsDrawerHeader(
//
//               decoration: const BoxDecoration(
//                 color: appColor1,
//               ),
//
//
//               accountName: Text(
//               'Taimoor',
//                 style: txtstyll,
//               ),
//               accountEmail: null),
//           ListTile(
//             leading: const Icon(
//               Icons.home,
//               color: appColor2,
//             ),
//             title: const Text(
//               'Home',
//               style: sadaF,
//             ),
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
//             },
//           ),
//           Divider(
//             color: appColor1,
//           ),
//           const ListTile(
//             leading: Icon(
//               Icons.local_fire_department_outlined,
//               color: appColor2,
//             ),
//             title: Text(
//               'Popular',
//               style: sadaF,
//             ),
//           ),
//           const Divider(
//             color: appColor1,
//           ),
//
//           ListTile(
//             leading: const Icon(
//               Icons.takeout_dining,
//               color: appColor2,
//             ),
//             title: const Text(
//               'Extra Chezain',
//               style: sadaF,
//             ),
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>Extra_Chezain()));
//             },
//           ),
//           const Divider(
//             color: appColor1,
//           ),
//
//         ]),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Column(
//                   children: [
//                     TextFormField(
//                       controller: namecontroller,
//                       decoration: InputDecoration(
//                         hintText: 'Enter Food name',
//                       ),
//                     ),
//
//                     Center(
//                       child: InkWell(
//                         onTap: (){
//                           getGalleryImage();
//                         },
//                         child: Container(
//                           height: 200,
//                           width: 200,
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                                   color: Colors.black
//                               )
//                           ),
//                           child: _image!= null ? Image.file(_image!.absolute) : Icon(Icons.image),
//                         ),
//                       ),
//                     ),
//                     TextFormField(
//                       controller: pricecontroller,
//                       decoration: InputDecoration(
//                         hintText: 'Price',
//                       ),
//                     ),
//                     TextFormField(
//                       controller: descriptioncontroller,
//                       decoration: InputDecoration(
//                         hintText: 'Enter Description',
//                       ),
//                     ),
//                     TextFormField(
//                       controller: Categorycontroller,
//                       decoration: InputDecoration(
//                         hintText: 'Category',
//                       ),
//                     ),
//                     TextFormField(
//                       controller: typecontroller,
//                       decoration: InputDecoration(
//                         hintText: 'Type',
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(15.0),
//                       child: InkWell(
//                         onTap: (){
//
//                         },
//                         child: InkWell(
//                           onTap: ()async{
//                             setState(() {
//                               loading = true;
//                             });
//                             var id = DateTime.now().millisecondsSinceEpoch.toString();
//                             firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('/popu/'+id);
//                             firebase_storage.UploadTask uplaodTask = ref.putFile(_image!.absolute);
//
//                             await Future.value(uplaodTask).then((value) async{
//                               var newUrl = await ref.getDownloadURL();
//
//
//                               firestore.doc(id).set({
//                                 'id' : id,
//                                 'name': namecontroller.text.toString(),
//                                 'description': descriptioncontroller.text.toString(),
//                                 'price': pricecontroller.text.toString(),
//                                 'delivery_time': typecontroller.text.toString(),
//                                 'image' : newUrl.toString(),
//                                 'category' : Categorycontroller.text.toString(),
//
//                               }).then((value) {
//                                 setState(() {
//                                   loading = false;
//                                 });
//                                 Utils().toastMessage('Uploaded');
//
//                               }).onError((error, stackTrace) {
//                                 setState(() {
//                                   loading = false;
//                                 });
//                                 Utils().toastMessage(error.toString());
//
//                               });
//                             });
//
//
//
//                           },
//                           child: Container(
//                             width: MediaQuery.of(context).size.width,
//                             height: 50,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 gradient: LinearGradient(colors: [appColor1, appColor2])
//                             ),
//                             child: Center(
//                                 child:loading? CircularProgressIndicator(strokeWidth: 3, color: Colors.white,):Text( 'Enter', style: TextStyle(fontSize: 25, color: Colors.white),)),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//
//
//
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
