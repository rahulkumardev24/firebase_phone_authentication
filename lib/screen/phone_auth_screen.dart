import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_authentication/screen/otp_screen.dart';
import 'package:pinput/pinput.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  TextEditingController numberController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// here we create function to send OTP
  void sendOTP() async {
    /// add +91
    String phoneNumber = "+91${numberController.text.trim()}";
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        /// enter opt under 2min
        timeout: const Duration(minutes: 2),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        /// if any error found
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.message ?? "Verification failed")));
        },
        codeSent: (String verificationId, int? resendToken) {
          /// use here push
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => OtpScreen(verificationId: verificationId,)));
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Phone Authentication",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent.shade100,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
        shadowColor: Colors.black,
        elevation: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter Your Number",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 26),
            ),
            Pinput(
              length: 10,
              controller: numberController,
              showCursor: true,
              keyboardType: TextInputType.number,

              /// style
              defaultPinTheme: PinTheme(
                  width: 50,
                  textStyle: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade400))),

              /// focused Box
              focusedPinTheme: PinTheme(
                  width: 50,
                  textStyle: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.blue, width: 2))),

              /// submitted
              submittedPinTheme: PinTheme(
                  width: 50,
                  textStyle: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue, width: 2))),
            ),
            const SizedBox(
              height: 12,
            ),

            /// Send otp Button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  /// here we call otp send function
                    onPressed: () {
                      sendOTP();
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor: Colors.orange.shade100,
                        side: const BorderSide(width: 2, color: Colors.orange)),
                    child: const Text(
                      "Send OTP",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                          color: Colors.black,
                          shadows: [
                            Shadow(color: Colors.white, blurRadius: 3)
                          ]),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}

/// Auth screen Complete
/// Otp Screen => Done
