import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/pages/auth/cubit/auth_cubit.dart';
import 'package:firebase_crud/pages/auth/login_with_phone/login_with_phone.dart';
import 'package:firebase_crud/pages/auth/login_with_phone_number.dart';
import 'package:firebase_crud/pages/auth/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/constants.dart';
import '../../widgets/round_button.dart';
import '../posts/posts_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      setState(() {
        loading = false;
      });
      print('Login successful');
      Constants().showToastMessage(value.user!.email.toString());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PostsPage()));
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Constants().showToastMessage(error.toString());
    });
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
          child: SingleChildScrollView(
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
                              prefixIcon: Icon(Icons.email_outlined)),
                          validator: (value) {
                            if (value!.isEmpty) {
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
                              prefixIcon: Icon(Icons.lock_outlined)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                        )
                      ],
                    )),
                SizedBox(
                  height: 50,
                ),
                RoundButton(
                  title: 'Login',
                  loading: loading,
                  onTap: () {
                    setState(() {
                      loading = true;
                    });
                    if (_formKey.currentState!.validate()) {
                      login();
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
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()));
                        },
                        child: Text('Sign Up'))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => BlocProvider(
                //                   create: (context) => AuthCubit(),
                //                   child: LogInWithPhoneNumber(),
                //                 ),),);
                //   },
                //   child: Container(
                //     width: double.infinity,
                //     padding: EdgeInsets.symmetric(vertical: 15),
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.all(Radius.circular(12)),
                //         border: Border.all(color: Colors.pink, width: 2)),
                //     child: Center(child: Text('Sign In with Phone Number')),
                //   ),
                // ),
                 InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginWithPhone(),),);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        border: Border.all(color: Colors.pink, width: 2)),
                    child: Center(child: Text('Sign In with Phone')),
                  ),
                ),
                
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
