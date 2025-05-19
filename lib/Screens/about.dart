import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/config/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'responsive_widget.dart';


final List<String> skills = <String>[
  'Dart',
  'Flutter',
  'Java',
  'Python',
  'Javascript',
  'Html',
  'Css',
  'C#',
  'Illustrator',
  'Figma'
];

class About extends StatefulWidget {
  const About({super.key});

  @override
  
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {


  Future<QuerySnapshot<Map<String, dynamic>>> skillsdata =
  FirebaseFirestore.instance.collection('skills').orderBy('image').get();
  Future<QuerySnapshot<Map<String, dynamic>>> profiledata =
  FirebaseFirestore.instance.collection('profile').get();

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
                      height: 10.sp,
                    ),
                    FutureBuilder(
                      future: profiledata, 
                      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                        if(snapshot.connectionState == ConnectionState.done) {
                          return SizedBox(
                            width: 700,
                            child: Text(
                              snapshot.data!.docs.first['description'],
                              style: TextStyle(
                                  fontSize: 12.5.sp,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w200,
                                  color: Colors.grey.shade300),
                              // textAlign: TextAlign.justify,
                            ),
                          );
                        }
                        return const SizedBox(
                          height: 700,
                        );
                      }
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
                    FutureBuilder(
                      future: skillsdata, 
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
                          if(snapshot.hasData) {
                            if(snapshot.data!.docs.isNotEmpty) {
                              return Wrap(
                                spacing: 10,
                                runSpacing: 15,
                                children: List.generate(snapshot.data!.docs.length, (index) {
                                    return Chip(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        side: BorderSide(color: AppColors.cyyan, width: 1.5)),
                                      backgroundColor: const Color(0xFF37474F),
                                      avatar: Image.network( snapshot.data!.docs[index]['image']),
                                      label: Text(
                                        snapshot.data!.docs[index]['name'],
                                        style: const TextStyle(fontSize: 16, color: Colors.white),
                                      ),
                                    );
                                },)
                              );
                            }
                          } else {
                            return const Text("error");
                          }
                        } 
                        return Container();
                      }, 
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: FutureBuilder(
                  future: profiledata, 
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
                          radius: 165,
                          backgroundColor: const Color(0xFF263238),
                          child: CircleAvatar(
                            radius: 140,
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
                
                // ClipPath(
                //   child: Image.asset(
                //     "assets/images/circle.png",
                //     width: 10,
                //   ),
                // ),
              )
            ]),
          ],
        ),
      ),
      mobileScreen: Padding(
        padding: EdgeInsets.fromLTRB(0, 25.sp, 0, 0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 25.sp),
              child: FutureBuilder(
                future: profiledata, 
                builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                      color: Colors.cyan,
                    );
                  }
                  if(snapshot.connectionState == ConnectionState.done) {
                    if(snapshot.data!.docs.isNotEmpty) {
                      return CircleAvatar(
                        radius: 44.sp,
                        backgroundColor: const Color(0xFF263238),
                        child: CircleAvatar(
                          radius: 41.sp,
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
            Text(
              "About Me",
              style: TextStyle(
                fontFamily: 'Lemon',
                color: Colors.amber,
                fontSize: 22.sp,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
                    FutureBuilder(
                      future: profiledata, 
                      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                        if(snapshot.connectionState == ConnectionState.done) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                              child: Center(
                                child: Text(
                                  snapshot.data!.docs.first['description'],
                                  style: TextStyle(
                                      fontSize: 16.sp, fontFamily: 'Roboto', color: Colors.grey.shade300),
                                  // textAlign: TextAlign.justify,
                                ),
                              ),
                            );
                        }
                        return const SizedBox(
                          height: 700,
                        );
                      }
                    ),
            SizedBox(
              height: 30.sp,
            ),
            Text(
              "Skills",
              style: TextStyle(
                fontFamily: 'Lemon',
                color: Colors.amber,
                fontSize: 22.sp,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: skillsdata, 
              builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: Colors.cyan,
                  );
                }
                if(snapshot.connectionState == ConnectionState.done) {
                  if(snapshot.hasData) {
                    if(snapshot.data!.docs.isNotEmpty) {
                      return Wrap(
                        children: List.generate(
                          snapshot.data!.docs.length,
                          (index) => SizedBox(
                            width: 110,
                            // height: 50,
                            child: _itemBuilder(context, snapshot.data!.docs[index]['name'], snapshot.data!.docs[index]['image'])),
                        ),
                      );
                    }
                  } else {
                    return const Text("error");
                  }
                } 
                return Container();
              }, 
            ),
            // GridView.builder(
            //   padding: const EdgeInsets.symmetric(horizontal: 15),
            //   shrinkWrap: true,
            //   itemCount: skills.length,
            //   physics: const NeverScrollableScrollPhysics(),
            //   gridDelegate:
            //       const SliverGridDelegateWithFixedCrossAxisCount(
            //           crossAxisCount: 4,
            //           crossAxisSpacing: 2,
            //           mainAxisSpacing: 2,
            //           childAspectRatio: 1.2),
            //   itemBuilder: _itemBuilder),
          ],
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, String skillname, String image) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: AppColors.cyyan),
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueGrey[900]),
      child: Center(
        child: Column(
          children: [
            Image.network(image, height: 25.sp, width:  25.sp,),
            const SizedBox(
              height: 5,
            ),
            Text(
              skillname,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.normal,
                fontSize: 14.sp,
                color: AppColors.greyLight
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
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
