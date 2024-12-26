import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio/config/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import 'responsive_widget.dart';

const github = 'https://github.com/jyodesh10';
const linkedin =
    'https://np.linkedin.com/in/jyodesh-shakya-ba6a50145?trk=public_profile_browsemap_profile-result-card_result-card_full-click';

const facebook = 'https://facebook.com';
const whatsapp = 'https://wa.me/9813504214';

class Footer extends StatefulWidget {
  const Footer({super.key, required this.deviceId});
  final String deviceId;

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
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
                  height: 180,
                  width: 180,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 30,
                      onPressed: () {
                        _launchURL(github);
                        sendEmail(name: widget.deviceId, email: widget.deviceId, body: "github");
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.github,
                        color: AppColors.greyLight,
                      )),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 30,
                      color: AppColors.greyLight,
                      onPressed: () {
                        _launchURL(linkedin);
                        sendEmail(name: widget.deviceId, email: widget.deviceId, body: "linkedin");
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.linkedin,
                        color: AppColors.greyLight,
                      )),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 30,
                      color: AppColors.greyLight,
                      onPressed: () {
                        _launchURL(facebook);
                        sendEmail(name: widget.deviceId, email: widget.deviceId, body: "facebook");
                      },                        
                      icon: const FaIcon(
                        FontAwesomeIcons.facebook,
                        color: AppColors.greyLight,
                      )),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 30,
                      color: AppColors.greyLight,
                      onPressed: () {
                        _launchURL(whatsapp);
                        sendEmail(name: widget.deviceId, email: widget.deviceId, body: "whatsapp");
                      },                            
                      icon: const FaIcon(
                        FontAwesomeIcons.whatsapp,
                        color: AppColors.greyLight,
                      )),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Copyright © 2024 Jyodesh Shakya | All rights reserved',
                  style: TextStyle(
                      fontSize: 12,
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
