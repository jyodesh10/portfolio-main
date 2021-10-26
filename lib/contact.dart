import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:mailto/mailto.dart';
import 'package:portfolio/config/colors.dart';
import 'package:portfolio/responsive_widget.dart';
import 'package:http/http.dart' as http;

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  TextEditingController bodyController = new TextEditingController();

  //  void _setText() {
  //   setState(() {
  //     name = nameController.text;
  //     email = emailController.text;
  //     body = bodyController.text;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        mobileScreen: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            // Color(0xFF546E7A),
            // Color(0xFF455A64),
            Colors.black.withOpacity(0.9),

            Color(0xFF263238),
            Color(0xFF37474F),
            // Colors.transparent,
            // Colors.transparent,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, 0.5, 1],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
        child: Column(
          children: [
            Text(
              "Contact Me",
              style: TextStyle(
                fontFamily: 'Lemon',
                color: Colors.amber,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PersonalInfo(
                    context,
                    Icon(
                      Icons.email,
                      color: AppColors.greyLight,
                    ),
                    'Email',
                    'jyodeshshakya@gmail.com'),
                SizedBox(height: 10),
                PersonalInfo(
                    context,
                    Icon(
                      Icons.phone,
                      color: AppColors.greyLight,
                    ),
                    'Phone',
                    '+977 9813504214'),
                SizedBox(height: 10),
                PersonalInfo(
                    context,
                    Icon(
                      Icons.location_on,
                      color: AppColors.greyLight,
                    ),
                    'Location',
                    'Kathmandu, Nepal'),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 500,
              width: 400,
              decoration: BoxDecoration(
                  // border: Border.all(width: 2, color: AppColors.black),
                  // borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent),
              child: ContactForm(context),
            )
          ],
        ),
      ),
    ));
  }

  Widget PersonalInfo(BuildContext context, Icon, String label, String text) {
    return FittedBox(
      // height: 300,
      //width: 300,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              padding: EdgeInsets.zero,
              iconSize: 25,
              color: Colors.white,
              onPressed: null,
              icon: Icon),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 5,
              ),
              Text(label,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColors.greyLight)),
              const SizedBox(height: 5),
              Text(text,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: AppColors.greyLight))
            ],
          ),
        ],
      ),
    );
  }

  Widget ContactForm(BuildContext context) {
    final maxLines = 5;
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Name';
                } else if (value!.isValidName()) {
                  return null;
                } else {
                  return 'name is Invalid ';
                }
              },
              style: TextStyle(color: AppColors.greyLight),
              decoration: InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(),
                hintStyle: TextStyle(color: Colors.blueGrey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.cyyan,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Email';
                } else if (value!.isValidEmail) {
                  return null;
                } else {
                  return 'Email is Invalid ';
                }
              },
              style: TextStyle(color: AppColors.greyLight),
              decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
                hintStyle: TextStyle(color: Colors.blueGrey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.cyyan,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: maxLines * 24.0,
              child: TextFormField(
                controller: bodyController,
                validator: (value) {
                  if (value == null) {
                    return 'Please insert a Message';
                  }
                  return null;
                },
                maxLines: maxLines,
                style: TextStyle(color: AppColors.greyLight),
                decoration: InputDecoration(
                  hintText: 'Message',
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.cyyan,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: AnimatedButton(
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    // postData();
                    // _setText();
                    sendEmail(
                        name: nameController.text,
                        email: emailController.text,
                        body: bodyController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Successfully Submitted')),
                    );
                  } else {
                    print("error submission");
                  }
                },
                height: 40,
                width: 120,
                text: 'Send',
                isReverse: true,
                selectedTextColor: Colors.black,
                transitionType: TransitionType.CENTER_ROUNDER,
                textStyle: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Roboto',
                    color: AppColors.greyLight),
                backgroundColor: Colors.transparent,
                selectedBackgroundColor: AppColors.cyyan,
                borderColor: AppColors.cyyan,
                borderWidth: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future sendEmail({
    required String name,
    required String email,
    required String body,
  }) async {
    final serviceId = 'service_a9hwh16';
    final template_id = 'template_a0t9r6b';
    final user_id = 'user_CIq0M4Njb997ZHmzEOW89';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'service_id': serviceId,
          'template_id': template_id,
          'user_id': user_id,
          'template_params': {
            'user_name': name,
            'user_email': email,
            'user_message': body,
          }
        }));
  }

  Future<void> _sendMail() async {
    final mailto = Mailto(
      to: ['jyodeshshakya@gmai.com'],
      subject: nameController.text.trim(),
      body: bodyController.text.trim(),
    );

    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 3000);
    String renderHtml(Mailto mailto) =>
        '''<html><head><title>mailto example</title></head><body><a href="$mailto">Open mail client</a></body></html>''';
    await for (HttpRequest request in server) {
      request.response
        ..statusCode = HttpStatus.ok
        ..headers.contentType = ContentType.html
        ..write(renderHtml(mailto));
      await request.response.close();
    }
  }

  // @override
  // void dispose() {
  //   nameController.dispose();
  //   emailController.dispose();
  //   bodyController.dispose();
  //   super.dispose();
  // }
}

extension StringExtensions on String {
  bool get isValidEmail => RegExp(
          "^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this.trim());

  bool isValidName({minLength = 3}) =>
      this.trim().isNotEmpty && (this.trim().length >= minLength);
}
