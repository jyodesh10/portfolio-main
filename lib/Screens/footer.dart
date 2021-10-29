import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/config/colors.dart';
import 'responsive_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home.dart';

const _url = 'https://github.com/jyodesh10';
const _url1 =
    'https://np.linkedin.com/in/jyodesh-shakya-ba6a50145?trk=public_profile_browsemap_profile-result-card_result-card_full-click';

const _url2 = 'https://facebook.com';

class Footer extends StatefulWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  _FooterState createState() => _FooterState();
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
                  height: 200,
                  width: 200,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 30,
                        onPressed: () => _launchURL(),
                        icon: FaIcon(
                          FontAwesomeIcons.github,
                          color: AppColors.greyLight,
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 30,
                        color: AppColors.greyLight,
                        onPressed: () => _launchURL1(),
                        icon: FaIcon(
                          FontAwesomeIcons.linkedin,
                          color: AppColors.greyLight,
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 30,
                        color: AppColors.greyLight,
                        onPressed: () => _launchURL2(),
                        icon: FaIcon(
                          FontAwesomeIcons.facebook,
                          color: AppColors.greyLight,
                        )),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Copyright © 2021 Jyodesh Shakya.',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade500),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _launchURL() async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
void _launchURL1() async => await canLaunch(_url1)
    ? await launch(_url1)
    : throw 'Could not launch $_url1';
void _launchURL2() async => await canLaunch(_url2)
    ? await launch(_url2)
    : throw 'Could not launch $_url2';
