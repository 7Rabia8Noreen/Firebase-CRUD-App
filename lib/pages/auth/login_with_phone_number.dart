import 'package:firebase_crud/pages/auth/cubit/auth_cubit.dart';
import 'package:firebase_crud/pages/auth/verify_phone_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/auth_state.dart';

class LogInWithPhoneNumber extends StatelessWidget {
  LogInWithPhoneNumber({super.key});

  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with phone number'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        children: [
          TextField(
            keyboardType: TextInputType.number,
            controller: phoneController,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: 'Enter phone number'),
          ),
          SizedBox(
            height: 20,
          ),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthCodeSentState) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider(
                              create: (context) => AuthCubit(),
                              child: VerifyPhoneNumber(),
                            )));
              } else if (state is AuthErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 5),
                    content: Text(state.errorMessage)));
              }
            },
            builder: (context, state) {
              if (state is AuthLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(
                child: CupertinoButton(
                  color: Colors.pink,
                  child: Text('Sign In'),
                  onPressed: () {
                    String phoneNumber = "+92" + phoneController.text;
                    BlocProvider.of<AuthCubit>(context).sendOTP(phoneNumber);
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
