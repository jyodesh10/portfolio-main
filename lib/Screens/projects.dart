import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:responsive_sizer/responsive_sizer.dart";
import "package:url_launcher/url_launcher.dart";

import "../config/colors.dart";
import "responsive_widget.dart";

class ProjectsView extends StatefulWidget {
  const ProjectsView({super.key});

  @override
  State<ProjectsView> createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView> {

  Future<QuerySnapshot<Map<String, dynamic>>> projectsdata =
    FirebaseFirestore.instance.collection('projects').orderBy('title').get();
  int projectlength = 0;
  bool showmore = false;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      desktopScreen: buildProjectsGrid(true),
      mobileScreen: buildProjectsGrid(false),
    );
  }
  
  buildProjectsGrid(bool isDesktop) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          Text("Projects", 
            style: TextStyle(
              fontFamily: 'Lemon',
              color: Colors.amber,
              fontSize: isDesktop ? 20.sp : 22.sp,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          FutureBuilder(
            future: projectsdata, 
            builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if(snapshot.connectionState == ConnectionState.done) {
                if(snapshot.hasData) {
                  if(snapshot.data!.docs.isNotEmpty) {
                    Future.delayed(const Duration(seconds: 1), () {
                      setState(() {
                        projectlength = snapshot.data!.docs.length;
                      });
                    });
                    return GridView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 40).copyWith(bottom: 40),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isDesktop ? 3 : 1,
                        childAspectRatio: isDesktop 
                          ? MediaQuery.of(context).size.aspectRatio * 2 / 4.4
                          :  .8,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 30
                      ),
                      children: List.generate(showmore
                        ? snapshot.data!.docs.length
                        : isDesktop 
                          ? 6
                          : 4,
                        (index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: AppColors.cyyan, width: 2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: isDesktop ? 3 : 5,
                                child: Image.network(
                                  snapshot.data!.docs[index]['image'],
                                  fit: isDesktop ? BoxFit.cover : BoxFit.fitWidth,
                                  loadingBuilder: (context, child, loadingProgress) => loadingProgress?.expectedTotalBytes == loadingProgress?.cumulativeBytesLoaded
                                    ? child
                                    : Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 60),
                                      height: 50,
                                      alignment: Alignment.center,
                                      child: const CircularProgressIndicator(
                                      ),
                                    ),
                                )
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(snapshot.data!.docs[index]['title'],
                                            style: TextStyle(
                                              color: AppColors.greyLight,
                                              fontSize: 14  .sp,
                                              fontFamily: "Lemon",
                                              fontWeight: FontWeight.w700,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(snapshot.data!.docs[index]['body'],
                                            style: TextStyle(
                                              color: AppColors.greyLight.withOpacity(0.8),
                                              fontSize: 12.sp,
                                              fontFamily: "Roboto",
                                              fontWeight: FontWeight.w100,
                                              overflow: TextOverflow.ellipsis
                                            ),
                                            maxLines:isDesktop ? 4 : 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: MaterialButton(
                                          onPressed: () => _launchURL(snapshot.data!.docs[index]['link']),
                                          minWidth: 200.0,
                                          height: 50,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            side: const BorderSide(color: AppColors.cyyan, width: 2)
                                          ),
                                          elevation: 5,
                                          hoverColor: AppColors.cyyan.withOpacity(0.5),
                                          child:  Text("VIEW", 
                                            style: TextStyle(
                                              color: AppColors.greyLight,
                                              fontSize: 12.sp,
                                              fontFamily: "Lemon",
                                              fontWeight: FontWeight.w300,
                                            )
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ),
                            ],
                          ),
                        );
                      }),
                    );
                  }
                } else {
                  return const Text("error");
                }
              } 
              return Container();
            }, 
          ),
          projectlength > 6 
            ? TextButton(
              onPressed: () {
                setState(() {
                  showmore =! showmore;
                });
              }, 
              child:  Text(
                showmore
                  ? "Show less"
                  : "Show more", 
                style: TextStyle(
                  fontFamily: 'Lemon',
                  color: Colors.white,
                  fontSize: isDesktop ? 15.sp : 16.sp,
                ),
              )
            )
            : const SizedBox()
        ],
      ),
    );
  }
}

void _launchURL(String url) async =>
    await canLaunchUrl(Uri.parse(url)) ? await launchUrl(Uri.parse(url)) : throw 'Could not launch $url';
