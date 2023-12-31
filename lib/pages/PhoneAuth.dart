import "dart:async";

import "package:flutter/material.dart";
import "package:otp_text_field/otp_field.dart";
import "package:otp_text_field/otp_field_style.dart";
import "package:otp_text_field/style.dart";
import "package:todo_appp_project/Service/Auth_Service.dart";

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({Key? key}) : super(key: key);

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  int start = 30;
  bool wait = false;
  String buttonName = "Send";
  TextEditingController phoneController = TextEditingController();
  AuthClass authClass = AuthClass();
  String verificationIdFinal = "";
  String smsCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 120,
            ),
            textField(),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                  const Text(
                    "Enter 6 digit OTP",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            otpField(),
            const SizedBox(
              height: 40,
            ),
            RichText(
                text: TextSpan(children: [
              const TextSpan(
                text: " Send OTP again in ",
                style: TextStyle(fontSize: 16, color: Colors.yellowAccent),
              ),
              TextSpan(
                text: "00:$start",
                style: const TextStyle(fontSize: 16, color: Colors.pinkAccent),
              ),
              const TextSpan(
                text: " sec ",
                style: TextStyle(fontSize: 16, color: Colors.yellowAccent),
              )
            ])),
            const SizedBox(
              height: 150.0,
            ),
            InkWell(
              onTap: () {
                authClass.signInwithPhoneNumber(
                    verificationIdFinal, smsCode, context);
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width - 60,
                decoration: BoxDecoration(
                  color: const Color(0xffff9601),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                    child: Text(
                  "Let's Go",
                  style: TextStyle(
                      fontSize: 17,
                      color: Color(0xfffbe2ae),
                      fontWeight: FontWeight.w700),
                )),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  Widget otpField() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width - 34,
      fieldWidth: 58,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: const Color(0xff1d1d1d),
        borderColor: Colors.white,
      ),
      style: const TextStyle(fontSize: 17, color: Colors.white),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print(" Completed: $pin");

        setState(() {
          smsCode = pin;
        });
      },
    );
  }

  Widget textField() {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xff1d1d1d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: phoneController,
        style: const TextStyle(color: Colors.white, fontSize: 17),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter your phone Number",
          hintStyle: const TextStyle(color: Colors.white54, fontSize: 17),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
            child: Text(
              " (+91) ",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          suffixIcon: InkWell(
            onTap: wait
                ? null
                : () async {
                    setState(() {
                      start = 30;
                      wait = true;
                      buttonName = " Resend ";
                    });
                    await authClass.verifyPhoneNumber(
                        "+91 ${phoneController.text}", context, setData);
                  },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Text(
                buttonName,
                style: TextStyle(
                  color: wait ? Colors.grey : Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setData(verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });
    startTimer();
  }

//     return Container(
//       width: MediaQuery.of(context).size.width - 40,
//       height: 60,
//         decoration: BoxDecoration(
//           color: Color(0xff1d1d1d), borderRadius: BorderRadius.circular(15)),
//       child: TextFormField(
//         decoration: InputDecoration(
//           border: InputBorder.none,
//           hintText: "Enter your phone number",
//           hintStyle: TextStyle(color: Colors.white54, fontSize: 17),
//           prefixIcon: Paddin Text("(+91)",          style: TextStyle(color: Colors.white54, fontSize: 17),

// )
//         ),
//       ),
//     );
//   }
}
