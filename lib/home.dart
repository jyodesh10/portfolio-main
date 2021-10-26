import 'package:flutter/material.dart';
import 'package:portfolio/responsive_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:portfolio/about.dart';
import 'package:portfolio/config/colors.dart';
import 'package:portfolio/contact.dart';
import 'package:portfolio/footer.dart';
import 'package:portfolio/working_process.dart';
import 'package:avatar_glow/avatar_glow.dart';

const _url = 'https://github.com/jyodesh10';
const _url1 =
    'https://np.linkedin.com/in/jyodesh-shakya-ba6a50145?trk=public_profile_browsemap_profile-result-card_result-card_full-click';

const _url2 = 'https://facebook.com';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final aboutKey = new GlobalKey();
  final contactKey = new GlobalKey();

  // Future scrollToAbout() async {
  //   final context = aboutKey.currentContext!;
  //   await Scrollable.ensureVisible(context, duration: Duration(seconds: 2));
  // }

  void scrollToAbout() {
    final context = aboutKey.currentContext!;
    Scrollable.ensureVisible(context, duration: const Duration(seconds: 2));
  }

  void scrollToContact() {
    final context = contactKey.currentContext!;
    Scrollable.ensureVisible(context, duration: const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      desktopScreen: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            color: Colors.black,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            color: Colors.black,
                            child: ClipRect(
                              child: Image.asset(
                                "assets/images/jyo.png",
                                width: 400,
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Container(
                          color: Colors.black,
                          child: ClipRect(
                            child: Image.asset(
                              "assets/images/jyo.png",
                              width: 400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    color: Colors.black,
                  ),
                ),
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
                title: const Text(
                  'About',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: 'Lemon',
                  ),
                ),
                leading: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.grey,
                ),
                onTap: () {
                  scrollToAbout();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(
                  'Contact',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: 'Lemon',
                  ),
                ),
                leading: Icon(
                  Icons.contact_phone_outlined,
                  color: Colors.grey,
                ),
                onTap: () {
                  scrollToContact();
                },
              ),
            ],
          ),
        ),
        body: ListView(
          shrinkWrap: true,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Expanded(
            //   flex: 3,
            //   child: Container(
            //     decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //         colors: [
            //           Color(0xFF212121),
            //           // Colors.transparent,
            //           // Colors.transparent,
            //           Color(0xFF263238)
            //         ],
            //         begin: Alignment.topCenter,
            //         end: Alignment.bottomCenter,
            //         stops: [0, 1],
            //       ),
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Center(
            //         child: ClipRect(
            //           child: Image.asset(
            //             "assets/images/circle.png",
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    // Color(0xFF546E7A),
                    // Color(0xFF455A64),
                    Color(0xFF37474F),
                    Color(0xFF263238),
                    // Colors.transparent,
                    // Colors.transparent,
                    Colors.black.withOpacity(0.9)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0, 0.5, 1],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Column(
                  children: [
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   height: 30,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 10),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       children: [
                    //         IconButton(
                    //             onPressed: () {
                    //               scaffoldKey.currentState?.openDrawer();
                    //             },
                    //             icon: Icon(
                    //               Icons.menu,
                    //               color: AppColors.greyLight,
                    //             ))
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: ClipRect(
                          child: Image.asset(
                            "assets/images/circle.png",
                            width: 250,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RichText(
                      text: TextSpan(
                        children: const <TextSpan>[
                          TextSpan(
                            text: 'Hello, ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Lemon',
                                fontSize: 60.0,
                                color: Color(0xFF84FFFF)),
                          ),
                          TextSpan(
                              text: 'I\'m',
                              style: TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Roboto",
                                  color: Colors.blueGrey)),
                        ],
                      ),
                    ),
                    Text(
                      "Jyodesh",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          fontSize: 50.0,
                          color: Colors.blueGrey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Mobile Developer",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Roboto',
                          fontSize: 30.0,
                          color: Colors.grey),
                    ),
                    SizedBox(
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
                              color: Color(0xFF5D4037),
                              onPressed: _launchURL,
                              icon: FaIcon(FontAwesomeIcons.github)),
                        ),
                        SizedBox(width: 20),
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
                              color: Color(0xFF5D4037),
                              onPressed: _launchURL,
                              icon: FaIcon(FontAwesomeIcons.linkedin)),
                        ),
                        SizedBox(width: 20),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Container(
                              child: IconButton(
                                  padding: EdgeInsets.zero,
                                  iconSize: 30,
                                  color: Color(0xFF5D4037),
                                  onPressed: _launchURL,
                                  icon: FaIcon(FontAwesomeIcons.facebook)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    AnimatedButton(
                      onPress: () {},
                      height: 50,
                      width: 150,
                      text: 'View My CV',
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
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),

            Container(key: aboutKey, child: About()),

            Container(child: WorkingProcess()),

            Container(child: Contact()),

            Container(key: contactKey, child: Footer())
          ],
        ),
        floatingActionButton: IconButton(
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
            icon: Icon(
              Icons.menu,
              color: AppColors.greyLight,
              size: 30,
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
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
