import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio/config/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'responsive_widget.dart';

// const github = 'https://github.com/jyodesh10';
// const linkedin =
//     'https://np.linkedin.com/in/jyodesh-shakya-ba6a50145?trk=public_profile_browsemap_profile-result-card_result-card_full-click';

// const facebook = 'https://facebook.com';
// const whatsapp = 'https://wa.me/9813504214';
// const instagram = 'https://www.instagram.com/zyodes_10/';

class Footer extends StatefulWidget {
  const Footer({super.key, required this.deviceId});
  final String deviceId;

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {

  Future<QuerySnapshot<Map<String, dynamic>>> linksdata =
      FirebaseFirestore.instance.collection('links').get();
  
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      desktopScreen: Container(
        height: 300,
        color: Colors.black87,
        //alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 180,
                  width: 180,
                ),
                FutureBuilder(
                  future: linksdata, 
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.done) {                      
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 15.5.sp,
                            onPressed: () {
                              _launchURL(snapshot.data!.docs.first['github']);
                              sendEmail(name: widget.deviceId, email: widget.deviceId, body: "github");
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.github,
                              color: AppColors.greyLight,
                            )),
                          SizedBox(
                            width: 12.sp,
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 15.5.sp,
                            color: AppColors.greyLight,
                            onPressed: () {
                              _launchURL(snapshot.data!.docs.first['linkedin']);
                              sendEmail(name: widget.deviceId, email: widget.deviceId, body: "linkedin");
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.linkedin,
                              color: AppColors.greyLight,
                            )),
                          SizedBox(
                            width: 12.sp,
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 15.5.sp,
                            color: AppColors.greyLight,
                            onPressed: () {
                              _launchURL(snapshot.data!.docs.first['whatsapp']);
                              sendEmail(name: widget.deviceId, email: widget.deviceId, body: "whatsapp");
                            },                            
                            icon: const FaIcon(
                              FontAwesomeIcons.whatsapp,
                              color: AppColors.greyLight,
                            )
                          ),
                          SizedBox(
                            width: 12.sp,
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 15.5.sp,
                            color: AppColors.greyLight,
                            onPressed: () {
                              _launchURL(snapshot.data!.docs.first['facebook']);
                              sendEmail(name: widget.deviceId, email: widget.deviceId, body: "facebook");
                            },                        
                            icon: const FaIcon(
                              FontAwesomeIcons.facebook,
                              color: AppColors.greyLight,
                            )),
                          SizedBox(
                            width: 12.sp,
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 15.5.sp,
                            color: AppColors.greyLight,
                            onPressed: () {
                              _launchURL(snapshot.data!.docs.first['instagram']);
                              sendEmail(name: widget.deviceId, email: widget.deviceId, body: "instagram");
                            },                        
                            icon: const FaIcon(
                              FontAwesomeIcons.instagram,
                              color: AppColors.greyLight,
                            )
                          ),
                          SizedBox(
                            width: 12.sp,
                          ),
                        ],
                      );
                    }
                    return SizedBox(
                      height: 20.sp,
                    );
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Copyright © 2025 Jyodesh Shakya | All rights reserved',
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade500),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
      mobileScreen: Container(
        height: 300,
        color: Colors.black87,
        //alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 50.sp,
                  width: 50.sp,
                ),
                FutureBuilder(
                  future: linksdata, 
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.done) {                      
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 18.sp,
                            onPressed: () {
                              _launchURL(snapshot.data!.docs.first['github']);
                              sendEmail(name: widget.deviceId, email: widget.deviceId, body: "github");
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.github,
                              color: AppColors.greyLight,
                            )),
                          SizedBox(
                            width: 12.sp,
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 18.sp,
                            color: AppColors.greyLight,
                            onPressed: () {
                              _launchURL(snapshot.data!.docs.first['linkedin']);
                              sendEmail(name: widget.deviceId, email: widget.deviceId, body: "linkedin");
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.linkedin,
                              color: AppColors.greyLight,
                            )),
                          SizedBox(
                            width: 12.sp,
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 18.sp,
                            color: AppColors.greyLight,
                            onPressed: () {
                              _launchURL(snapshot.data!.docs.first['whatsapp']);
                              sendEmail(name: widget.deviceId, email: widget.deviceId, body: "whatsapp");
                            },                            
                            icon: const FaIcon(
                              FontAwesomeIcons.whatsapp,
                              color: AppColors.greyLight,
                            )
                          ),
                          SizedBox(
                            width: 12.sp,
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 18.sp,
                            color: AppColors.greyLight,
                            onPressed: () {
                              _launchURL(snapshot.data!.docs.first['facebook']);
                              sendEmail(name: widget.deviceId, email: widget.deviceId, body: "facebook");
                            },                        
                            icon: const FaIcon(
                              FontAwesomeIcons.facebook,
                              color: AppColors.greyLight,
                            )),
                          SizedBox(
                            width: 12.sp,
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 18.sp,
                            color: AppColors.greyLight,
                            onPressed: () {
                              _launchURL(snapshot.data!.docs.first['instagram']);
                              sendEmail(name: widget.deviceId, email: widget.deviceId, body: "instagram");
                            },                        
                            icon: const FaIcon(
                              FontAwesomeIcons.instagram,
                              color: AppColors.greyLight,
                            )
                          ),
                          SizedBox(
                            width: 12.sp,
                          ),
                        ],
                      );
                    }
                    return SizedBox(
                      height: 20.sp,
                    );
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Copyright © 2025 Jyodesh Shakya | All rights reserved',
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade500),
                ),
                const SizedBox(height: 20),
              ],
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
    await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_name': name,
            'user_email': email,
            'user_message': "$name viewed your $body",
          }
        }));
  }
}


void _launchURL(String url) async =>
    await canLaunchUrl(Uri.parse(url)) ? await launchUrl(Uri.parse(url)) : throw 'Could not launch $url';
