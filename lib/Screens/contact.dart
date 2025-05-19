import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio/config/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'responsive_widget.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController bodyController = TextEditingController();

  Future<QuerySnapshot<Map<String, dynamic>>> contactdata =
  FirebaseFirestore.instance.collection('contact').get();

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
        desktopScreen: Padding(
          padding: const EdgeInsets.fromLTRB(0, 80, 0, 80),
          child: Column(
            children: [
              const Text(
                "Get In Touch",
                style: TextStyle(
                  fontFamily: 'Lemon',
                  color: Colors.amber,
                  fontSize: 40,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder(
                    future: contactdata, 
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.done) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            personalInfo(
                                context,
                                const Icon(
                                  Icons.email,
                                  color: AppColors.greyLight,
                                ),
                                'Email',
                                snapshot.data!.docs.first['email']),
                            const SizedBox(height: 10),
                            personalInfo(
                                context,
                                const Icon(
                                  Icons.phone,
                                  color: AppColors.greyLight,
                                ),
                                'Phone',
                                snapshot.data!.docs.first['phone']),
                            const SizedBox(height: 10),
                            personalInfo(
                                context,
                                const Icon(
                                  Icons.location_on,
                                  color: AppColors.greyLight,
                                ),
                                'Location',
                                snapshot.data!.docs.first['location']),
                          ],
                        );
                      }
                      return const SizedBox(
                        width: 400,
                      );
                    },
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  SizedBox(width: 400, child: contactForm(context))
                ],
              ),
            ],
          ),
        ),
        mobileScreen: Padding(
          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: Column(
            children: [
              Text(
                "Get In Touch",
                style: TextStyle(
                  fontFamily: 'Lemon',
                  color: Colors.amber,
                  fontSize:  22.sp,
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                future: contactdata, 
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        personalInfo(
                            context,
                            const Icon(
                              Icons.email,
                              color: AppColors.greyLight,
                            ),
                            'Email',
                            snapshot.data!.docs.first['email']),
                        const SizedBox(height: 10),
                        personalInfo(
                            context,
                            const Icon(
                              Icons.phone,
                              color: AppColors.greyLight,
                            ),
                            'Phone',
                            snapshot.data!.docs.first['phone']),
                        const SizedBox(height: 10),
                        personalInfo(
                            context,
                            const Icon(
                              Icons.location_on,
                              color: AppColors.greyLight,
                            ),
                            'Location',
                            snapshot.data!.docs.first['location']),
                      ],
                    );
                  }
                  return const SizedBox(
                    height: 20,
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 500,
                width: 400,
                decoration: const BoxDecoration(
                    // border: Border.all(width: 2, color: AppColors.black),
                    // borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent),
                child: contactForm(context),
              )
            ],
          ),
        ));
  }

  Widget personalInfo(BuildContext context, icon, String label, String text, {bool isMobile = false}) {
    return FittedBox(
      // height: 300,
      //width: 300,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              padding: EdgeInsets.zero,
              iconSize: isMobile? 20.sp : 18.sp,
              color: Colors.white,
              onPressed: null,
              icon: icon),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 5,
              ),
              Text(label,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                      color: AppColors.greyLight)),
              const SizedBox(height: 5),
              Text(text,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13.sp,
                      color: AppColors.greyLight))
            ],
          ),
        ],
      ),
    );
  }

  Widget contactForm(BuildContext context) {
    const maxLines = 5;
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
                } else if (value.isValidName()) {
                  return null;
                } else {
                  return 'name is Invalid ';
                }
              },
              style: const TextStyle(color: AppColors.greyLight),
              decoration: const InputDecoration(
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
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Email';
                } else if (value.isValidEmail) {
                  return null;
                } else {
                  return 'Email is Invalid ';
                }
              },
              style: const TextStyle(color: AppColors.greyLight),
              decoration: const InputDecoration(
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
            const SizedBox(
              height: 15,
            ),
            SizedBox(
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
                style: const TextStyle(color: AppColors.greyLight),
                decoration: const InputDecoration(
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
            const SizedBox(
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
                  } else {
                  }
                },
                height: 40,
                width: 120,
                text: 'Send',
                isReverse: true,
                selectedTextColor: Colors.black,
                transitionType: TransitionType.CENTER_ROUNDER,
                textStyle: TextStyle(
                    fontSize: 14.sp,
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
    const serviceId = 'service_y3okpfe';
    const templateId = 'template_a0t9r6b';
    const userId = 'user_CIq0M4Njb997ZHmzEOW89';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_name': name,
            'user_email': email,
            'user_message': body,
          }
        }));
    if(response.statusCode == 200 ) {
      if(mounted) {
        emailController.clear();
        nameController.clear();
        bodyController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Mail Successfully Submitted')),
          );
      } 
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
          "^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
      .hasMatch(trim());

  bool isValidName({minLength = 3}) =>
      trim().isNotEmpty && (trim().length >= minLength);
}
