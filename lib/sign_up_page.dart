import 'package:app/base_class.dart';
import 'package:app/otp_page.dart';
import 'package:app/utils/app_theme.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Controller for text inputs
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Selected country code
  String _selectedCountryCode = '+994';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                // Top container with curved border
                Container(
                  height: 280,
                  decoration: BoxDecoration(
                    color: AppTheme.colorPrimary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(150),
                      bottomRight: Radius.circular(150),
                    ),
                  ),
                ),
                Container(
                  color: AppTheme.white,
                ),
              ],
            ),
            // Centered car image
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 80),
                child: Image.asset(
                  "assets/images/carPng.png",
                  width: 180,
                ),
              ),
            ),
            // Form fields below the car
            Container(
              margin: const EdgeInsets.only(top: 500),
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name Input Field
                  TextField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: "Enter your name",
                      hintStyle: styleLightColor(color: AppTheme.colorGrey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            width: 1,
                          )),
                    ),
                  ),
                  getVerticalGap(),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "Enter your Mobile number",
                      hintStyle: styleLightColor(color: AppTheme.colorGrey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            width: 1,
                          )),
                    ),
                  ),

                  getVerticalGap(height: 60),
                  Container(
                    width: double.infinity,
                    child: TextButton(
                        style: buttonStyle(
                            backgroundColor: AppTheme.colorPrimary,
                            paddingVertical: 15,
                            paddingHorizontal: 20,
                            foregroundColor: AppTheme.white,
                            borderRadius: 50),
                        onPressed: () {
                          gotoNext(context, const OtpPage());
                        },
                        child: Text(
                          "GET STARTED",
                          style: styleBoldColor(color: AppTheme.white),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
