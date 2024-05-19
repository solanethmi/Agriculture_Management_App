import 'package:flutter/material.dart';
import 'package:se_project/controllers/auth_controller.dart';
import 'package:se_project/controllers/deliver_controller.dart';
import 'package:se_project/utils/show_snackBar.dart';
import 'package:se_project/views/buyers/auth/deliver_register_screen.dart';
import 'package:se_project/views/buyers/auth/vendor_register_screen.dart';
import 'package:se_project/views/buyers/deliver_main_screen.dart';
import 'package:se_project/views/buyers/main_screen.dart';
import 'package:se_project/views/vendor_main_screen.dart';

class DeliverLoginScreen extends StatefulWidget {
  

  @override
  State<DeliverLoginScreen> createState() => _DeliverLoginScreenState();
}

class _DeliverLoginScreenState extends State<DeliverLoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DeliverController _authController = DeliverController();

  late String email;

  late String password;

  bool _isLoading = false;


  _loginUsers()async{
    setState(() {
      _isLoading = true;
    }); 
    if(_formKey.currentState!.validate()){
      await _authController.loginUsers(email,password);

       return Navigator.pushReplacement(context,
       MaterialPageRoute(builder: (BuildContext context){
        return DeliverMainScreen();
       })); 
      
    }else{
      setState(() {
        _isLoading = false;
      });
      return showSnack(context, 'Please fields must not be empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Container(
            decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/icons/deliver.jpg",),
        fit: BoxFit.cover,
        opacity: 0.4,
        
        ),),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Delivery Person Login',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    ),
                    ),
          
          
                    SizedBox(
                      height: 80,
                      child: Image.asset(
                        "assets/icons/deliver.jpg",
                        fit: BoxFit.contain,
                      ),
                    ),
          
          
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty){
                            return 'Please Email Field must not be empty';
                          }else{
                            return null;
                          }
                        },
                        onChanged: (value) {
                          email= value;
                        },
                        decoration: InputDecoration(
                        labelText: 'Enter Email',
                      ),
                      ),
                    ),
                  
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: true,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please Password Field not be Empty';
                          }else{
                            return null;
                          }
                        },
                        onChanged: (value) {
                          password= value;
                        },
                        decoration: InputDecoration(
                        labelText: 'Enter Password',
                      ),
                      ),
                    ),
                  
                    SizedBox(height: 5,),
                  
                    InkWell(
                      onTap: () {
                        _loginUsers();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width -40,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 14, 14, 14),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child:_isLoading
                          ? CircularProgressIndicator(
                            color: Colors.white,
                          ) 
                          :Text(
                            'Log In',
                            style: TextStyle(
                              letterSpacing: 4,
                              color: Colors.white,
                              fontSize: 30,
                              
                            ),
                          ),
                        ),
                      ),
                    ),
                  
                   

                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Text('If you are Vendor, Dont have an Account?',style: TextStyle(fontSize: 18),),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DeliverRegisterScreen()));
                      },
                       child: Text(
                        'SignUp',
                        style: TextStyle(fontSize: 20),
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