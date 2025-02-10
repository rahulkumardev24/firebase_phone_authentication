import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_authentication/screen/home_screen.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  String verificationId;
  OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otpCode = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// here we create function for verify OTP
  void verifyOTP() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId, smsCode: otpCode);

      await _auth.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("OTP Verified Successfully"),
        backgroundColor: Colors.green,
      ));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Invalid OTP!"),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Enter OTP",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 26),
              ),
              const SizedBox(
                height: 12,
              ),
              Pinput(
                length: 6,
                onCompleted: (pin) => otpCode = pin,
                showCursor: true,
                keyboardType: TextInputType.number,

                /// style
                defaultPinTheme: PinTheme(
                    width: 50,
                    height: 50,
                    textStyle: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade400))),

                /// focused Box
                focusedPinTheme: PinTheme(
                    width: 50,
                    height: 50,
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
                    height: 50,
                    textStyle: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.blue, width: 2))),
              ),
              const SizedBox(
                height: 12,
              ),

              /// Send otp Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(

                        /// here we call function verify otp
                        onPressed: () {
                          verifyOTP();
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            backgroundColor: Colors.greenAccent.shade100,
                            side: const BorderSide(
                                width: 2, color: Colors.greenAccent)),
                        child: const Text(
                          "Verify",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 21,
                              color: Colors.black,
                              shadows: [
                                Shadow(color: Colors.white, blurRadius: 3)
                              ]),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// Otp screen complete
/// apply function on otp screen => Done
///
/// every thing fine
///
