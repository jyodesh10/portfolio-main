import 'dart:convert';
import 'dart:developer';
import 'dart:html' as html;

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:client_information/client_information.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio/config/colors.dart';
import 'package:public_ip_address/public_ip_address.dart';
import 'package:url_launcher/url_launcher.dart';

import 'about.dart';
import 'contact.dart';
import 'footer.dart';
import 'projects.dart';
import 'responsive_widget.dart';
import 'working_process.dart';

const github = 'https://github.com/jyodesh10';
const linkedin =
    'https://np.linkedin.com/in/jyodesh-shakya-ba6a50145?trk=public_profile_browsemap_profile-result-card_result-card_full-click';

const facebook = 'https://facebook.com/zyodes10';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final aboutKey = GlobalKey();
  final wpKey = GlobalKey();
  final projectKey = GlobalKey();
  final contactKey = GlobalKey();
  int count = 0;
  // final _fabStream = StreamController<bool>();
  // Future scrollToAbout() async {
  //   final context = aboutKey.currentContext!;
  //   await Scrollable.ensureVisible(context, duration: Duration(seconds: 2));
  // }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> collectionStream =
      FirebaseFirestore.instance.collection('visits').snapshots();

  String deviceID = "";
  String visitFrom = "";

  @override
  void initState() {
    super.initState(); 
    updateCounter();
  }

  void scrollToAbout() {
    final context = aboutKey.currentContext!;
    Scrollable.ensureVisible(context, duration: const Duration(seconds: 2));
  }

  void scrollToContact() {
    final context = contactKey.currentContext!;
    Scrollable.ensureVisible(context, duration: const Duration(seconds: 2));
  }

  void scrollToWp() {
    final context = wpKey.currentContext!;
    Scrollable.ensureVisible(context, duration: const Duration(seconds: 2));
  }

  void scrollToProjects() {
    final context = projectKey.currentContext!;
    Scrollable.ensureVisible(context, duration: const Duration(seconds: 2));
  }

  updateCounter() async {
    final iplocationInfo = await getIpInfo();
    final deviceInfo = await getdeviceInfo();
    final deviceIds = await FirebaseFirestore.instance.collection('deviceId').get();
    deviceID = deviceInfo.deviceId.toString();
    if(!deviceIds.docs.map((element) => element["deviceId"]).toList().contains( deviceInfo.deviceId.toString())) {
       Map<String, dynamic> body = {
        "deviceId" : deviceInfo.deviceId.toString(),
        "deviceName" : deviceInfo.deviceName.toString(),
        "OsName" : deviceInfo.osName.toString(),
        "created_date" : DateTime.now(),
        "visit_from" : visitFrom
      };
      body.addAll(iplocationInfo);
      FirebaseFirestore.instance.collection('deviceId').doc( deviceInfo.deviceId.toString()).set(
        body
      );
      final initialval = await FirebaseFirestore.instance.collection('visits').get();
      count = initialval.docs[0]. data()['count'];
      FirebaseFirestore.instance.collection('visits').doc(initialval.docs[0].id).update({
        "count" : count + 1
      });
    }
  }

  Future<Map<String, dynamic>> getIpInfo() async {
    final currentUrl = Uri.parse(html.window.location.href);
    final queryParameters = currentUrl.queryParameters;
    if(queryParameters.isNotEmpty) {
        visitFrom = queryParameters['from']!;
    }
    final allData = await IpAddress().getAllData();
    
    log(allData.toString());
    final location = await getLocationInfo(allData['latitude'], allData['longitude']);
    return {
      "ip-info" : allData,
      "location-info" : location
    };
  }

  Future<Map<String, dynamic>>getLocationInfo(lat, lon) async {
    final res = await http.get(Uri.parse("https://geocode.maps.co/reverse?lat=$lat&lon=$lon&api_key=6646f7f82cc77861061776cng77c4df"));
    if(res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data['address'];
    } else {
      return {
        "location" : "error fetching location data"
      };
    }
  }

  Future<ClientInformation> getdeviceInfo() async {
    ClientInformation info = await ClientInformation.fetch();
    return info;
  }

    Future<QuerySnapshot<Map<String, dynamic>>> homedata =
      FirebaseFirestore.instance.collection('home').get();

  @override
  Widget build(BuildContext context) {
    return body();
  }

  body() {
    return ResponsiveWidget(
      desktopScreen: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  // Color(0xFF546E7A),
                  // Color(0xFF455A64),
                  const Color(0xFF37474F),
                  const Color(0xFF263238),
                  Colors.black.withOpacity(0.9),
                  const Color(0xFF263238),
                  const Color(0xFF37474F),
                  const Color(0xFF263238),
                  Colors.black.withOpacity(0.9),
                  const Color(0xFF263238),
                  const Color(0xFF37474F),
                  Colors.black.withOpacity(0.9),
                  Colors.black,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1],
              ),
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    Container(
                      color: Colors.transparent,
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Image.asset(
                              'assets/images/android-icon-192x192.png',
                              height: 60,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 60, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                textBut("About", Colors.transparent, scrollToAbout),
                                textBut('Working Process', Colors.transparent, scrollToWp),
                                textBut('Projects', Colors.transparent, scrollToProjects),
                                MaterialButton(
                                  onPressed: scrollToContact,
                                  minWidth: 200.0,
                                  height: 60,
                                  color: Colors.amber,
                                  child: Text(
                                    'Contact',
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        fontFamily: 'Lemon',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueGrey[900],
                                        fontSize: 15),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height / 5,
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height - 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: FutureBuilder(
                                  future: homedata, 
                                  builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                                    if(snapshot.connectionState == ConnectionState.waiting) {
                                      return const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 50),
                                        child: LinearProgressIndicator(
                                          color: AppColors.cyyan,
                                        ),
                                      );
                                    }
                                    if(snapshot.connectionState == ConnectionState.done) {
                                      if(snapshot.data!.docs.isNotEmpty) {
                                        return CircleAvatar(
                                          radius: 230,
                                          backgroundColor: const Color(0xFF263238),
                                          child: CircleAvatar(
                                            radius: 200,
                                            backgroundImage: NetworkImage(snapshot.data!.docs.first['image']),
                                            backgroundColor: const Color(0xFF263238),
                                          ),
                                        );
                                      } else {
                                        return const SizedBox();
                                      }
                                    }
                                    return const SizedBox();
                                  },
                                ),
                                
                                // Image(
                                //   image:
                                //       AssetImage('assets/images/jyo3.png'),
                                //   height: 500,
                                //   width: 500,
                                // ),
                              )
                            ),
                            Expanded(
                              flex: 6,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      // width: 350.0,
                                      child: DefaultTextStyle(
                                        style: const TextStyle(
                                          fontSize: 80.0,
                                          fontFamily: 'Lemon',
                                          color: Color(0xFF84FFFF),
                                        ),
                                        child: AnimatedTextKit(
                                          animatedTexts: [
                                            TypewriterAnimatedText('HELLO,',
                                                speed: const Duration(
                                                    milliseconds: 250)),
                                            TypewriterAnimatedText(
                                                'I\'m\nJyodesh',
                                                speed: const Duration(
                                                    milliseconds: 250)),
                                          ],
                                          onTap: () {
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Mobile Developer",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w100,
                                          fontFamily: 'Lemon',
                                          fontSize: 25.0,
                                          color: Colors.grey.shade400),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    socialBut(context),
                                    const SizedBox(
                                      height: 100,
                                    ),
                                    StreamBuilder(
                                      stream: collectionStream,
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.data == null) {
                                          return const SizedBox(height: 20,);
                                        }
                                        return Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Column(
                                            children: [
                                              Text(
                                                "Visitors",
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.grey.shade400,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                snapshot.data!.docs[0]
                                                        ['count'].toString(),
                                                style: const TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                About(key: aboutKey),
                WorkingProcess(
                  key: wpKey,
                ),
                ProjectsView(key: projectKey),
                Contact(
                  key: contactKey,
                ),
                Footer(
                  deviceId: deviceID,
                )
              ],
            ),
          ),
        ),
      ),
      mobileScreen: Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          backgroundColor: Colors.blueGrey[900],
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.black54,
                    image: DecorationImage(
                        image: AssetImage("assets/images/logo.png"),
                        fit: BoxFit.fitHeight)),
                child: Center(
                  child: Text(''),
                ),
              ),
              ListTile(
                title: Text(
                  'About',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 16,
                    fontFamily: 'Lemon',
                  ),
                ),
                leading: Icon(
                  Icons.account_box_rounded,
                  color: Colors.grey.shade400,
                ),
                onTap: () {
                  scrollToAbout();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  'Working Process',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 16,
                    fontFamily: 'Lemon',
                  ),
                ),
                leading: Icon(
                  Icons.work_rounded,
                  color: Colors.grey.shade400,
                ),
                onTap: () {
                  scrollToWp();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  'Projects',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 16,
                    fontFamily: 'Lemon',
                  ),
                ),
                leading: Icon(
                  Icons.copy_rounded,
                  color: Colors.grey.shade400,
                ),
                onTap: () {
                  scrollToProjects();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  'Contact',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 16,
                    fontFamily: 'Lemon',
                  ),
                ),
                leading: Icon(
                  Icons.contact_page_rounded,
                  color: Colors.grey.shade400,
                ),
                onTap: () {
                  scrollToContact();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  // Color(0xFF546E7A),
                  // Color(0xFF455A64),
                  const Color(0xFF37474F),
                  const Color(0xFF263238),
                  Colors.black.withOpacity(0.9),
                  const Color(0xFF263238),
                  const Color(0xFF37474F),
                  const Color(0xFF263238),
                  Colors.black.withOpacity(0.9),
                  const Color(0xFF263238),
                  const Color(0xFF37474F),
                  Colors.black.withOpacity(0.9),
                  Colors.black,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1],
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FutureBuilder(
                        future: homedata, 
                        builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator(
                              color: Colors.cyan,
                            );
                          }
                          if(snapshot.connectionState == ConnectionState.done) {
                            if(snapshot.data!.docs.isNotEmpty) {
                              return CircleAvatar(
                                radius: 125,
                                backgroundColor: const Color(0xFF263238),
                                child: CircleAvatar(
                                  radius: 100,
                                  backgroundImage: NetworkImage(snapshot.data!.docs.first['image']),
                                  backgroundColor: const Color(0xFF263238),
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          }
                          return const SizedBox();
                        },
                      ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText('HELLO,',
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Lemon',
                                  fontSize: 60.0,
                                  color: Color(0xFF84FFFF)),
                              speed: const Duration(milliseconds: 250)),
                          TypewriterAnimatedText('I\'m\nJyodesh',
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Lemon',
                                  fontSize: 60.0,
                                  color: Color(0xFF84FFFF)),
                              speed: const Duration(milliseconds: 250)),
                        ],
                        onTap: () {
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Mobile Developer",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Lemon',
                            fontSize: 25.0,
                            color: Colors.grey.shade400),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(5)),
                            child: IconButton(
                                padding: EdgeInsets.zero,
                                iconSize: 30,
                                color: const Color(0xFF5D4037),
                                onPressed: () => _launchURL(github),
                                icon: const FaIcon(FontAwesomeIcons.github)),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(5)),
                            //color: Colors.amber,
                            //alignment: Alignment.center,
                            child: IconButton(
                                padding: EdgeInsets.zero,
                                iconSize: 30,
                                color: const Color(0xFF5D4037),
                                onPressed: () => _launchURL(linkedin),
                                icon: const FaIcon(FontAwesomeIcons.linkedin)),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: IconButton(
                                  padding: EdgeInsets.zero,
                                  iconSize: 30,
                                  color: const Color(0xFF5D4037),
                                  onPressed: () => _launchURL(facebook),
                                  icon: const FaIcon(FontAwesomeIcons.facebook)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      AnimatedButton(
                        onPress: () {},
                        height: 50,
                        width: 150,
                        text: 'View My CV',
                        isReverse: true,
                        selectedTextColor: Colors.black,
                        transitionType: TransitionType.CENTER_ROUNDER,
                        textStyle: const TextStyle(
                            fontSize: 15,
                            fontFamily: 'Roboto',
                            color: AppColors.greyLight),
                        backgroundColor: Colors.transparent,
                        selectedBackgroundColor: AppColors.cyyan,
                        borderColor: AppColors.cyyan,
                        borderWidth: 1.6,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
                About(
                  key: aboutKey,
                ),
                WorkingProcess(
                  key: wpKey,
                ),
                ProjectsView(
                  key: projectKey,
                ),
                Contact(
                  key: contactKey,
                ),
            
                Footer(
                  deviceId: deviceID,
                )
              ],
            ),
          ),
        ),
        floatingActionButton: IconButton(
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: AppColors.greyLight,
              size: 30,
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      ),
    );
  }


  Widget socialBut(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
              padding: EdgeInsets.zero,
              iconSize: 30,
              color: const Color(0xFF5D4037),
              onPressed: () {
                sendEmail(name: deviceID, email: deviceID, body: "github");
                _launchURL(github);
              },
              icon: const FaIcon(FontAwesomeIcons.github)),
        ),
        const SizedBox(width: 20),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(5)),
          //color: Colors.amber,
          //alignment: Alignment.center,
          child: IconButton(
            padding: EdgeInsets.zero,
            iconSize: 30,
            color: const Color(0xFF5D4037),
            onPressed: () {
              sendEmail(name: deviceID, email: deviceID, body: "linkedin");
              _launchURL(linkedin);
            },
            icon: const FaIcon(FontAwesomeIcons.linkedin)
          ),
        ),
        const SizedBox(width: 20),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: IconButton(
            padding: EdgeInsets.zero,
            iconSize: 30,
            color: const Color(0xFF5D4037),
            onPressed: () {
              sendEmail(name: deviceID, email: deviceID, body: "facebook");
              _launchURL(facebook);
            },
            icon: const FaIcon(FontAwesomeIcons.facebook)),
          ),
        ),
      ],
    );
  }

  Widget textBut(textButname, Color col, VoidCallback action) {
    return Row(
      children: [
        TextButton(
            onPressed: action,
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(col)),
            child: Text(
              textButname,
              style: const TextStyle(
                  fontFamily: 'Lemon',
                  fontWeight: FontWeight.bold,
                  color: AppColors.greyLight,
                  fontSize: 15),
            )),
        const SizedBox(width: 15)
      ],
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
