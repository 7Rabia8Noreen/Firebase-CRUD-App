import 'package:firebase_crud/pages/auth/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/round_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey= GlobalKey<FormState>();
  final emailController= TextEditingController();
   final passwordController= TextEditingController();

   @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Login'),
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
                title: 'Login',
                onTap: (){
                  if(_formKey.currentState!.validate()){
    
                  }
                },
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?'),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                  }, child: Text('Sign Up'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}