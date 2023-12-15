import 'package:chat_app/constants.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? email ;

  String? password ;

  GlobalKey<FormState> userlogin = GlobalKey() ;

  bool isloading = false ;

  @override
  Widget build(BuildContext context) {
    return  ModalProgressHUD(
      inAsyncCall: isloading ,
      child: Scaffold(
        backgroundColor: kprimarycolor, 
        body: Form(
          key: userlogin ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                appPhoto,
                width: 160,
                height: 190,),
              const SizedBox(
                height: 60,
                child: Text('ChatApp' , 
                  style: TextStyle(
                    fontSize: 27 ,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffAE00FD)
                  ),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field is required' ;
                    }
                  },
                  onChanged: (value) {
                    email = value ;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffAE00FD)
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    contentPadding: EdgeInsets.all(10),
                    filled: true,
                    labelText: 'Email'  ,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    suffixIcon: Icon(Icons.email_outlined ,
                    color: Color(0xffAE00FD), ) 
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field is required';
                    }
                  },
                    onChanged: (value) {
                      password = value ;
                    },
                  decoration: InputDecoration(
                    focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffAE00FD)
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    contentPadding: EdgeInsets.all(10),
                    filled: true,
                    labelText: 'Password' ,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffAE00FD)
                      ),
                      borderRadius: BorderRadius.circular(30),
                      
                    ),
                    suffixIcon: Icon(Icons.password,
                    color: Color(0xffAE00FD),)
                  ),
                ),
                ),
                  const SizedBox(
                    height: 30,
                  ),
                Button(
                  onPressed: () 
                  async{
                    if (userlogin.currentState!.validate()) {
                      isloading = true ;
                      setState(() {
                        
                      });
  try {
      await userLogin();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login Succssefully'))) ;

        Navigator.pushNamed(context, ChatPage.id , arguments: email) ;

      } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found')
      {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No user found for that email.')));
      } else if (e.code == 'wrong-password')
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
        'Wrong password provided for that user.'
      ))) ;
      }else
      {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text( 
              'invalid Email or password'
            ))) ;
      }
      } 
      // catch(e)
      // {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text( 
      //         'error'
      //       ))) ;
      // }
      isloading = false ;
      setState(() {
        
      });
}
                    
                  },
                  text: 'Login',),
                const SizedBox(
                  height: 11,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('dont have an account? ',
                    style: TextStyle(
                      fontSize: 15
                    ),
                    ),
                    GestureDetector(
                      onTap: () 
                      {
                        Navigator.pushNamed(context, 'RegisterPage') ;
                      },
                      child: Text('Register',
                      style: TextStyle(
                        color: Color(0xffAE00FD),
                        fontSize: 16
                      ),
                      ),
                    )
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> userLogin() async {
    UserCredential userlogin =await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email!, 
    password: password!) ;
  }
}