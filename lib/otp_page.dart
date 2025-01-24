import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  // OTP code inputs
  List<String> otp = ["", "", "", ""];
  int currentIndex = 0;

  // Timer for countdown
  int timerSeconds = 110; // 1:50 -> 110 seconds
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  // Timer countdown logic
  void startTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (timerSeconds > 0) {
        setState(() {
          timerSeconds--;
        });
        startTimer();
      }
    });
  }

  String formatTimer(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  // Handles keypad press
  void onKeyTap(String value) {
    setState(() {
      if (value == "⌫") {
        // Handle backspace
        if (currentIndex > 0) {
          currentIndex--;
          otp[currentIndex] = "";
        }
      } else {
        // Handle digit press
        if (currentIndex < 4) {
          otp[currentIndex] = value;
          currentIndex++;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 50),
          // Top Icon
          Center(
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 60,
              child: Icon(
                Icons.mail_outline,
                size: 60,
                color: Colors.greenAccent,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Title and instructions
          const Text(
            "Verification Code",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Please type the verification code\nsent to +944 555 66 77",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          // OTP Fields
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              4,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.shade400,
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    otp[index],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Timer
          Text(
            formatTimer(timerSeconds),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          // Custom Keypad
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildKeypadRow(["1", "2", "3"]),
                  buildKeypadRow(["4", "5", "6"]),
                  buildKeypadRow(["7", "8", "9"]),
                  buildKeypadRow([
                    "",
                    "0",
                    "⌫",
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildKeypadRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: keys.map((key) {
        return GestureDetector(
          onTap: key.isNotEmpty ? () => onKeyTap(key) : null,
          child: Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Center(
              child: key == "⌫"
                  ? const Icon(Icons.backspace, size: 28)
                  : Text(
                      key,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
