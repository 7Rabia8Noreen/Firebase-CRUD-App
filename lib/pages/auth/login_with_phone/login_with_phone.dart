import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/pages/auth/login_with_phone/verify_phone.dart';
import 'package:firebase_crud/utils/constants.dart';
import 'package:firebase_crud/widgets/round_button.dart';
import 'package:flutter/material.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  bool loading= false;
  final phoneContoller= TextEditingController();
  final auth= FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with phone'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            TextFormField(
              controller: phoneContoller,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: '+92 326 1601629',
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(
              height: 80,
            ),
            RoundButton(title: 'Login',loading: loading, onTap: (){
               setState(() {
                     loading= true;
                   });
               auth.verifyPhoneNumber(
                phoneNumber: phoneContoller.text,
                verificationCompleted: (_){
                   setState(() {
                     loading= false;
                   });
                },
                 verificationFailed: (error) {
                   setState(() {
                     loading= false;
                   });
                   Constants().showToastMessage(error.toString());
                 }, 
                 codeSent: (verificationId, forceResendingToken) {
                   setState(() {
                     loading= false;
                   });
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => VerifyPhone(verificationId: verificationId))
                    );
                 }, 
                 codeAutoRetrievalTimeout: (error) {
                   setState(() {
                     loading= false;
                   });
                    Constants().showToastMessage(error.toString());
                 },);
            })
          ],
        ),
      ),
    );
  }
}