import 'package:flutter/material.dart';
import '../header.dart';
import 'responsive_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'about.dart';
import 'package:portfolio/config/colors.dart';
import 'contact.dart';
import 'footer.dart';
import 'working_process.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
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
  final wpKey = new GlobalKey();
  final contactKey = new GlobalKey();
  final _scrollController = ScrollController();
  // final _fabStream = StreamController<bool>();
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

  void scrollToWp() {
    final context = wpKey.currentContext!;
    Scrollable.ensureVisible(context, duration: const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      desktopScreen: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: ListView(
            shrinkWrap: true,
            children: [
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
                child: Column(
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
                                TextBut(
                                    "About", Colors.transparent, scrollToAbout),
                                TextBut('Working Process', Colors.transparent,
                                    scrollToWp),
                                TextBut('Portfolio', Colors.transparent,
                                    _launchURL),
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
                      child: Container(
                        height: MediaQuery.of(context).size.height - 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 40),
                                  child: Container(
                                    child: Image(
                                      image:
                                          AssetImage('assets/images/jyo3.png'),
                                      height: 500,
                                      width: 500,
                                    ),
                                  ),
                                )),
                            Expanded(
                              flex: 6,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 350.0,
                                      child: DefaultTextStyle(
                                        style: const TextStyle(
                                          fontSize: 80.0,
                                          fontFamily: 'Lemon',
                                          color: Color(0xFF84FFFF),
                                        ),
                                        child: AnimatedTextKit(
                                          animatedTexts: [
                                            TypewriterAnimatedText('HELLO,',
                                                speed: Duration(
                                                    milliseconds: 250)),
                                            TypewriterAnimatedText(
                                                'I\'m Jyodesh',
                                                speed: Duration(
                                                    milliseconds: 250)),
                                          ],
                                          onTap: () {
                                            print("Tap Event");
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
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
                                      height: 20,
                                    ),
                                    SocialBut(context)
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
              ),
              About(key: aboutKey),
              WorkingProcess(
                key: wpKey,
              ),
              Contact(
                key: contactKey,
              ),
              Footer()
            ],
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
                  Icons.account_box_rounded,
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
                  Icons.message_rounded,
                  color: Colors.grey,
                ),
                onTap: () {
                  scrollToContact();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(
                  'Portfolio',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: 'Lemon',
                  ),
                ),
                leading: Icon(
                  Icons.web_stories,
                  color: Colors.grey,
                ),
                onTap: () {
                  _launchURL();
                  Navigator.pop(context);
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

  List<Widget> _slivers() => [
        SliverToBoxAdapter(
          key: aboutKey,
          //child: About(),
        ),
        SliverToBoxAdapter(
          key: wpKey,
          //child: WorkingProcess(),
        ),
        SliverToBoxAdapter(
          key: contactKey,
          //child: Contact(),
        ),
        SliverToBoxAdapter(
            // child: Footer(),
            ),
      ];

  Widget SocialBut(BuildContext context) {
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
              color: Color(0xFF5D4037),
              onPressed: _launchURL,
              icon: FaIcon(FontAwesomeIcons.github)),
        ),
        SizedBox(width: 20),
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
              color: Color(0xFF5D4037),
              onPressed: _launchURL,
              icon: FaIcon(FontAwesomeIcons.linkedin)),
        ),
        SizedBox(width: 20),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(5)),
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
    );
  }

  Widget TextBut(textButname, Color col, VoidCallback action) {
    return Row(
      children: [
        TextButton(
            onPressed: action,
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(col)),
            child: Text(
              textButname,
              style: TextStyle(
                  fontFamily: 'Lemon',
                  fontWeight: FontWeight.bold,
                  color: AppColors.greyLight,
                  fontSize: 15),
            )),
        SizedBox(width: 15)
      ],
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
