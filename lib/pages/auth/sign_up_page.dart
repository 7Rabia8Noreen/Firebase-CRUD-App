import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/pages/auth/login_page.dart';
import 'package:firebase_crud/pages/auth/sign_up_page.dart';
import 'package:firebase_crud/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../widgets/round_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey= GlobalKey<FormState>();
  final emailController= TextEditingController();
   final passwordController= TextEditingController();
   bool loading= false;

   FirebaseAuth _auth= FirebaseAuth.instance;
    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    
    passwordController.dispose();
  }

  void signUp(){
     _auth.createUserWithEmailAndPassword(
                    email: emailController.text.toString(), 
                    password: passwordController.text.toString()).then((value) {
                      setState(() {
                        loading= false;
                      });
                      Constants().showToastMessage(value.user!.email.toString());

                    }).onError((error, stackTrace) {
                       setState(() {
                        loading= false;
                      });
                     Constants().showToastMessage(error.toString());
                    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          //mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                   TextFormField(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter email',
                      prefixIcon: Icon(Icons.email_outlined)
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                         return 'Please enter email';
                      }
                      return null;
                    },
                   ),
                   SizedBox(
                    height: 10,
                   ),
                   TextFormField(
                    controller: passwordController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Enter password',
                      prefixIcon: Icon(Icons.lock_outlined)
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                         return 'Please enter password';
                      }
                      return null;
                    },
                   )
                ],
              )
            ),
            SizedBox(
              height: 50,
            ),
            RoundButton(
              title: 'Sign Up',
              loading: loading,
              onTap: (){
                setState(() {
                  loading= true;
                });
                if(_formKey.currentState!.validate()){
                 signUp();
                }
              },
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?'),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                }, child: Text('Login'))
              ],
            )
          ],
        ),
      ),
    );
  }
}