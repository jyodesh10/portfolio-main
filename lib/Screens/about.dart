import 'package:flutter/material.dart';
import 'package:portfolio/config/colors.dart';
import 'responsive_widget.dart';

import 'animation.dart';

final List<String> skills = <String>[
  'Dart',
  'Java',
  'Python',
  'Javascript',
  'Html',
  'Css',
  'C#',
  'Illustrator'
];

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      desktopScreen: Container(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            border: Border.all(width: 0, color: Colors.transparent),
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
              stops: [0, 0.6, 1],
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, top: 20, bottom: 20),
                child: Column(
                  children: [
                    Row(children: [
                      Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "About Me",
                              style: TextStyle(
                                fontFamily: 'Lemon',
                                color: Colors.amber,
                                fontSize: 40,
                              ),
                            ),
                            Container(
                              width: 700,
                              child: Text(
                                "I\'m a mobile and web developer based in Kathmandu, Nepal currently developing mobile apps and websites.",
                                style: TextStyle(
                                    fontSize: 21,
                                    fontFamily: 'Roboto',
                                    color: Colors.grey),
                              ),
                            ),
                            SizedBox(
                              height: 80,
                            ),
                            Text(
                              "Skills",
                              style: TextStyle(
                                fontFamily: 'Lemon',
                                color: Colors.amber,
                                fontSize: 40,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                'Dart',
                                'Java',
                                'Python',
                                'Javascript',
                                'Html',
                                'Css',
                                'C#',
                                'Illustrator'
                              ]
                                  .map((String name) => Chip(
                                        avatar: CircleAvatar(
                                          child: Text(
                                            name.substring(0, 1),
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        label: Text(
                                          name,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: ClipPath(
                          child: Image.asset(
                            "assets/images/circle.png",
                            width: 10,
                          ),
                        ),
                      )
                    ]),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
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
          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: Column(
            children: [
              // BackgroundAnimation(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: ClipPath(
                  child: Image.asset(
                    "assets/images/jyo1.png",
                    width: 200,
                  ),
                ),
              ),
              Text(
                "About Me",
                style: TextStyle(
                  fontFamily: 'Lemon',
                  color: Colors.amber,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Center(
                  child: Text(
                    "I\'m a mobile and web developer based in Kathmandu, Nepal currently developing mobile apps and websites.",
                    style: TextStyle(
                        fontSize: 20, fontFamily: 'Roboto', color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Skills",
                style: TextStyle(
                  fontFamily: 'Lemon',
                  color: Colors.amber,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      height: 200,
                      child: GridView.builder(
                          // padding: const EdgeInsets.all(5.5),
                          itemCount: skills.length,
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 2,
                                  childAspectRatio: 1.2),
                          itemBuilder: _itemBuilder),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 30,
      width: 40,
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: AppColors.cyyan),
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueGrey[900]),
      child: ListTile(
        title: Center(
            child: Text(
          "${skills[index]}",
          style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.normal,
              color: AppColors.greyLight),
        )),
      ),
      // elevation: 8,
      // shadowColor: Colors.black,
      // shape: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(10),
      //     borderSide: BorderSide(color: Colors.black, width: 1)),
    );
  }
}
