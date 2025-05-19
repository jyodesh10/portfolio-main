import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/Screens/responsive_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:timelines_plus/timelines_plus.dart';

import '../config/colors.dart';

class ExperienceView extends StatefulWidget {
  const ExperienceView({super.key});

  @override
  State<ExperienceView> createState() => _ExperienceViewState();
}

class _ExperienceViewState extends State<ExperienceView> {

  Future<QuerySnapshot<Map<String, dynamic>>> experiencedata =
  FirebaseFirestore.instance.collection('experience').orderBy("timestamp", descending: true).get();

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      desktopScreen: 
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 80, 0, 65),
        child: Column(
          children: [
            const Text(
              "Experience",
              style: TextStyle(
                fontFamily: 'Lemon',
                color: Colors.amber,
                fontSize: 40,
              ),
            ),
            const SizedBox(height: 20),
            FutureBuilder(
              future: experiencedata, 
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done) {
                  return Timeline.tileBuilder(  
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    theme: TimelineThemeData(
                      color:  AppColors.cyyan,
                      nodePosition: 0 ,
                      connectorTheme: ConnectorThemeData(
                        color: AppColors.cyyan.withValues(alpha: 0.7),
                        thickness: 3.0,
                        // space: 5.sp,
                      )
                    ),
                    padding: EdgeInsets.only(left: 30.w, right: 30.w),
                    builder: TimelineTileBuilder.fromStyle(
                      connectorStyle: ConnectorStyle.solidLine,
                      indicatorStyle: IndicatorStyle.outlined,
                      contentsAlign: ContentsAlign.basic,
                      itemExtent: 38.sp,
                      contentsBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(left: 20.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(snapshot.data!.docs[index]['company'],
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 15.sp,
                                    fontFamily: "Lemon",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(" | ", style: TextStyle(fontSize: 20.sp, color: AppColors.white), textAlign: TextAlign.justify,  ),
                                Text(snapshot.data!.docs[index]['job'],
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.white.withValues(alpha: 0.8)
                                  )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            Text("${snapshot.data!.docs[index]['time']} | ${snapshot.data!.docs[index]['location']}", style: TextStyle(color: Colors.white, fontSize: 12.sp ),),
                            SizedBox(
                              height: 10.sp,
                            ),
                            SizedBox(
                              height: 20.sp,
                            )
                          ],
                        ),
                      ),
                      itemCount: snapshot.data!.docs.length,
                    ),                    
                  );
                }
                return SizedBox(
                  height: 20.sp,
                );
              },
            )
          ],
        ),
      ),
      mobileScreen: Padding(
        padding: const EdgeInsets.fromLTRB(0, 80, 0, 65),
        child: Column(
          children: [
            Text(
              "Experience",
              style: TextStyle(
                fontFamily: 'Lemon',
                color: Colors.amber,
                fontSize: 22.sp,
              ),
            ),
            const SizedBox(height: 20),
            FutureBuilder(
              future: experiencedata, 
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done) {
                  return Timeline.tileBuilder(  
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    theme: TimelineThemeData(
                      color:  AppColors.cyyan,
                      nodePosition: 0 ,
                      connectorTheme: ConnectorThemeData(
                        color: AppColors.cyyan.withValues(alpha: 0.7),
                        thickness: 3.0,
                        // space: 5.sp,
                      )
                    ),
                    padding: EdgeInsets.only(left: 8.w, right: 1.w),
                    builder: TimelineTileBuilder.fromStyle(
                      connectorStyle: ConnectorStyle.solidLine,
                      indicatorStyle: IndicatorStyle.outlined,
                      contentsAlign: ContentsAlign.basic,
                      itemExtent: 38.sp,
                      contentsBuilder: (context, index) => Padding(
                        padding: EdgeInsets.only(left: 20.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(snapshot.data!.docs[index]['company'],
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 15.sp,
                                    fontFamily: "Lemon",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(" | ", style: TextStyle(fontSize: 20.sp, color: AppColors.white), textAlign: TextAlign.justify,  ),
                                Text(snapshot.data!.docs[index]['job'],
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.white.withValues(alpha: 0.8)
                                  )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            Text("${snapshot.data!.docs[index]['time']} | ${snapshot.data!.docs[index]['location']}", style: TextStyle(color: Colors.white, fontSize: 12.sp ),),
                            SizedBox(
                              height: 10.sp,
                            ),
                            SizedBox(
                              height: 20.sp,
                            )
                          ],
                        ),
                      ),
                      itemCount: snapshot.data!.docs.length,
                    ),                    
                  );
                }
                return SizedBox(
                  height: 20.sp,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}