import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
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
    FirebaseFirestore.instance.collection('projects').get();

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      desktopScreen: buildProjectsGrid(true),
      mobileScreen: buildProjectsGrid(false),
    );
  }
  
  buildProjectsGrid(bool isDesktop) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0, color: Colors.transparent),
        gradient: LinearGradient(
          colors: [
            // Color(0xFF546E7A),
            // Color(0xFF455A64),
            Colors.black.withOpacity(0.9),
            const Color(0xFF263238),
            const Color(0xFF37474F),
            const Color(0xFF263238),
            Colors.black.withOpacity(0.9)
    
            // Colors.transparent,
            // Colors.transparent,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0, 0.3, 0.5, 0.7, 1],
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          const Text("Projects", 
            style: TextStyle(
              fontFamily: 'Lemon',
              color: Colors.amber,
              fontSize: 40,
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
                    return GridView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 40).copyWith(bottom: 40),
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isDesktop ? 3 : 1,
                        childAspectRatio: isDesktop 
                          ? MediaQuery.of(context).size.aspectRatio * 2 / 4.5
                          : MediaQuery.of(context).size.aspectRatio * 1 / 1,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 30
                      ),
                      children: List.generate(snapshot.data!.docs.length, (index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: AppColors.cyyan, width: 3),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Image.network(
                                  snapshot.data!.docs[index]['image'],
                                  fit: BoxFit.cover,
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
                                            style: const TextStyle(
                                              color: AppColors.greyLight,
                                              fontSize: 16,
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
                                              fontSize: 12,
                                              fontFamily: "Roboto",
                                              fontWeight: FontWeight.w100,
                                            ),
                                            maxLines: 4,
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
                                            side: const BorderSide(color: AppColors.cyyan, width: 3)
                                          ),
                                          elevation: 5,
                                          hoverColor: AppColors.cyyan.withOpacity(0.5),
                                          child: const Text("VIEW", 
                                            style: TextStyle(
                                              color: AppColors.greyLight,
                                              fontSize: 12,
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
          )
        ],
      ),
    );
  }
}

void _launchURL(String url) async =>
    await canLaunchUrl(Uri.parse(url)) ? await launchUrl(Uri.parse(url)) : throw 'Could not launch $url';
