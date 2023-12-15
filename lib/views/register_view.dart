import 'package:chat_app/constants.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email ;

  String? password ;

  GlobalKey<FormState> formkey = GlobalKey() ;

  bool hudisloading = false ;

  // Function(String)? onChanged ;
  @override
  Widget build(BuildContext context) {
    return  ModalProgressHUD(
      inAsyncCall: hudisloading,
      child: Scaffold(
        backgroundColor: kprimarycolor,
        body: Form(
          key: formkey ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(appPhoto,
              width: 160,
                height: 190,),
              const SizedBox(
                height: 60,
                child: Text('Hello, There' , 
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
                      return 'Field is required' ;
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
                Button(onPressed: () 
                async{
                  if (formkey.currentState!.validate()) {
          hudisloading =true ;
          setState(() {
            
          });
      try {
      await UserRegister();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Registered Succssefully'))) ;

      Navigator.pushNamed(context, ChatPage.id , arguments: email) ;

      } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password')
      {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Weak-password')));
      } else if (e.code == 'email-already-in-use')
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
        'email-already-in-use'
      ))) ;
      }
      } 
      catch(e)
      {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text( 
              'error'
            ))) ;
      }
      hudisloading = false ;
      setState(() {
        
      });
    }
    // else 
    // {
      
    // }                
                },
                  text: 'Register',),
                const SizedBox(
                  height: 11,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('already have an account? ',
                    style: TextStyle(
                      fontSize: 15
                    ),
                    ),
                    GestureDetector(
                      onTap: () 
                      {
                        Navigator.pop(context) ;
                      },
                      child: const  Text('Login',
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

  Future<void> UserRegister() async {
    UserCredential userauth = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email!, 
    password: password!) ;
  }
}