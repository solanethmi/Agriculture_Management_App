//import 'dart:js';

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se_project/controllers/auth_controller.dart';
import 'package:se_project/utils/show_snackBar.dart';
import 'package:se_project/views/buyers/auth/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController _authController = AuthController();  

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String email;

  late String fullName;

  late String phoneNumber;

  late String password;

  bool _isLoading = false;

  Uint8List ? _image;

  _signUpUser() async{
    setState(() {
      _isLoading = true;
    });
   if(_formKey.currentState!.validate()){
    await _authController.signUpUsers(
    email, fullName, phoneNumber, password, _image).whenComplete(() {
      setState(() {
        _formKey.currentState!.reset();
        _isLoading = false;
      });
    });
    return showSnack(
      context, 'Congratulations Account has been create for you');
   }else{
    setState(() {
      _isLoading = false;
    });
    return showSnack(context, 'Please Fields must not be empty ');
   }
  }

  selectGalleryImage() async{
   Uint8List im= await _authController.pickProfileImage(ImageSource.gallery);
   setState(() {
     _image = im;
   });
  }

  selectCameraImage() async{
   Uint8List im= await _authController.pickProfileImage(ImageSource.camera);
   setState(() {
     _image = im;
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              height: 900,
              decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/icons/firstpage.jpg",),
        fit: BoxFit.cover,
        opacity: 0.4,
        
        ),),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Create Customer Account.',
                  style: TextStyle(fontSize: 33,fontWeight: FontWeight.bold),
                  ),
                  Stack(
                    children: [
                    _image != null 
                      ? CircleAvatar(
                          radius: 60,
                          backgroundColor: Color.fromARGB(255, 254, 251, 219),
                          backgroundImage: MemoryImage(_image!),
                        )
                      : CircleAvatar(
                          radius: 40,
                          backgroundColor: Color.fromARGB(255, 249, 237, 128),
                          //backgroundImage: NetworkImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.freepik.com%2Ffree-photos-vectors%2Fdefault-user&psig=AOvVaw1Jc668_Ko7c3sJ2xKpPbSx&ust=1699071440127000&source=images&cd=vfe&ved=0CBIQjRxqFwoTCNC-tr_8poIDFQAAAAAdAAAAABAE'),
                        ),
                  Positioned(
                    right: 8,
                    top: 2,
                    child: IconButton(
                    onPressed: () {
                     selectGalleryImage();
                    },
                    icon: Icon(
                      CupertinoIcons.photo,
                      
                      ),
                    ),
                    ),
                  ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please Email must not be empty';
                        }else{
                          return null;
                        }
                      },
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: InputDecoration(
                      labelText: 'Enter Email',
                    ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please Full Name must not be empty';
                        }else{
                          return null;
                        }
                      },
                      onChanged: (value) {
                        fullName = value;
                      },
                      decoration: InputDecoration(
                      labelText: 'Enter Full Name',
                    ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please Phone Number must not be empty';
                        }else{
                          return null;
                        }
                      },
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                      decoration: InputDecoration(
                      labelText: 'Enter Phone Number',
                    ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: TextFormField(
                      obscureText: true
                      ,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please Password must not be empty';
                        }else{
                          return null;
                        }
                      },
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      _signUpUser();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width -40,
                      height: 50,
                      decoration: BoxDecoration(
                      color: Color.fromARGB(255, 246, 226, 43),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: _isLoading? CircularProgressIndicator(
                        color: Colors.white,
                      ): Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 5,
                          ),
                          )
                          ),
                    ),
                  ),
                    
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already Have an Account',style: TextStyle(fontSize: 24,),),
                      TextButton(onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context){
                          return LoginScreen();
                        }));
                      },
                       child: Text('Login',style: TextStyle(fontSize: 28),),
                       ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}