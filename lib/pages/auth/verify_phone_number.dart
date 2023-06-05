import 'package:firebase_crud/pages/auth/cubit/auth_cubit.dart';
import 'package:firebase_crud/pages/auth/cubit/auth_state.dart';
import 'package:firebase_crud/pages/posts/posts_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyPhoneNumber extends StatelessWidget {
  VerifyPhoneNumber({super.key});
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Verify phone number'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        children: [
          TextField(
            keyboardType: TextInputType.number,
            controller: otpController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: '6-digit code'),
          ),
          SizedBox(
            height: 20,
          ),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {

              if(state is AuthLoggedInState){
                Navigator.popUntil(context, (route) => route.isFirst);
                 Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostsPage()));
              }
               else if(state is AuthErrorState){
                ScaffoldMessenger.of(context).showSnackBar(
                  
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(state.errorMessage))
                );
              }
            },
            builder: (context, state) {
              if(state is AuthLoadingState){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
             
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: CupertinoButton(
                      color: Colors.pink,
                      child: Text('Verify'),
                      onPressed: () {
                        BlocProvider.of<AuthCubit>(context).verifyOTP(otpController.text);
                      },
                    ),
                  ), 
                  SizedBox(height: 10,),
                  Text('verify')
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
