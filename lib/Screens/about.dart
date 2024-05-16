import 'package:flutter/material.dart';
import 'package:portfolio/config/colors.dart';
import 'responsive_widget.dart';


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
  const About({super.key});

  @override
  
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      desktopScreen: Padding(
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
                    const Text(
                      "About Me",
                      style: TextStyle(
                        fontFamily: 'Lemon',
                        color: Colors.amber,
                        fontSize: 40,
                      ),
                    ),
                    SizedBox(
                      width: 700,
                      child: Text(
                        "I'm a mobile and web developer based in Kathmandu, Nepal currently developing mobile apps and websites.",
                        style: TextStyle(
                            fontSize: 21,
                            fontFamily: 'Roboto',
                            color: Colors.grey.shade300),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    const Text(
                      "Skills",
                      style: TextStyle(
                        fontFamily: 'Lemon',
                        color: Colors.amber,
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(
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
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              side: BorderSide(color: AppColors.cyyan, width: 2)),
                            backgroundColor: const Color(0xFF37474F),
                            avatar: CircleAvatar(
                              child: Text(
                                name.substring(0, 1),
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            label: Text(
                              name,
                              style: const TextStyle(fontSize: 16, color: Colors.white),
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
      ),
      mobileScreen: Padding(
        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: ClipPath(
                child: Image.asset(
                  "assets/images/circle.png",
                  width: 200,
                ),
              ),
            ),
            const Text(
              "About Me",
              style: TextStyle(
                fontFamily: 'Lemon',
                color: Colors.amber,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Center(
                child: Text(
                  "I'm a mobile and web developer based in Kathmandu, Nepal currently developing mobile apps and websites.",
                  style: TextStyle(
                      fontSize: 20, fontFamily: 'Roboto', color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Skills",
              style: TextStyle(
                fontFamily: 'Lemon',
                color: Colors.amber,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              shrinkWrap: true,
              itemCount: skills.length,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      childAspectRatio: 1.2),
              itemBuilder: _itemBuilder),
          ],
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: AppColors.cyyan),
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueGrey[900]),
      child: Center(
        child: Text(
          skills[index],
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.normal,
            color: AppColors.greyLight
          ),
          overflow: TextOverflow.ellipsis,
        )
      ),
      // elevation: 8,
      // shadowColor: Colors.black,
      // shape: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(10),
      //     borderSide: BorderSide(color: Colors.black, width: 1)),
    );
  }
}
