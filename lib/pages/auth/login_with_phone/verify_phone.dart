import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/pages/posts/posts_page.dart';
import 'package:firebase_crud/utils/constants.dart';
import 'package:firebase_crud/widgets/round_button.dart';
import 'package:flutter/material.dart';

class VerifyPhone extends StatefulWidget {
  final String verificationId;
  const VerifyPhone({super.key, required this.verificationId });

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  bool loading= false;
  final verifyCodeContoller= TextEditingController();
  final auth= FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify phone'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            TextFormField(
              controller: verifyCodeContoller,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: '6 digit code',
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(
              height: 80,
            ),
            RoundButton(title: 'Verify',loading: loading, onTap: () async{
               setState(() {
                 loading= true;
               });
               final credential= PhoneAuthProvider.credential(
                verificationId: widget.verificationId,
                 smsCode: verifyCodeContoller.text.toString());
                
                try{
                    await auth.signInWithCredential(credential);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PostsPage()));
                }
                catch(e){
                  setState(() {
                 loading= false;
                 Constants().showToastMessage(e.toString());
               });
                }

                 })
          ],
        ),
      ),
    );
  }
}