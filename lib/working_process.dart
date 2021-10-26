import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/responsive_widget.dart';

import 'config/colors.dart';

class WorkingProcess extends StatefulWidget {
  const WorkingProcess({Key? key}) : super(key: key);

  @override
  _WorkingProcessState createState() => _WorkingProcessState();
}

class _WorkingProcessState extends State<WorkingProcess> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobileScreen: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              // Color(0xFF546E7A),
              // Color(0xFF455A64),
              Color(0xFF37474F),

              Color(0xFF263238),
              Colors.black.withOpacity(0.9),

              // Colors.transparent,
              // Colors.transparent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0, 0.5, 1],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
          child: Column(
            children: [
              Text(
                "Working Process",
                style: TextStyle(
                  fontFamily: 'Lemon',
                  color: Colors.amber,
                  fontSize: 30,
                ),
              ),
              buildCard(context, "1.", "PLAN",
                  Icon(Icons.fact_check_outlined, color: AppColors.greyLight)),

              SizedBox(height: 10),
              buildCard(
                  context,
                  "2.",
                  "DESIGN",
                  Icon(Icons.design_services_outlined,
                      color: AppColors.greyLight)),

              SizedBox(height: 10),
              buildCard(context, "3.", "CODE",
                  Icon(Icons.code_rounded, color: AppColors.greyLight)),
              SizedBox(height: 10),
              // card('Design',
              //     IconButton(onPressed: null, icon: Icon(Icons.design_services)))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context, String index, String text, Icon) {
    return Card(
      elevation: 3,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.cyyan, width: 3),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(20.0),
      child: Container(
        height: 200,
        width: 200,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  index,
                  style: TextStyle(
                    color: AppColors.greyLight,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Center(
                child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 70,
                    color: Colors.white,
                    onPressed: null,
                    icon: Icon),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: AppColors.greyLight),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
