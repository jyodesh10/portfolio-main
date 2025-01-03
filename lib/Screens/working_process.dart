import 'package:flutter/material.dart';
import 'package:portfolio/config/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'responsive_widget.dart';

class WorkingProcess extends StatefulWidget {
  const WorkingProcess({super.key});

  @override
  State<WorkingProcess> createState() => _WorkingProcessState();
}

class _WorkingProcessState extends State<WorkingProcess> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      desktopScreen: Padding(
        padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
        child: Column(
          children: [
            const Text(
              "Working Process",
              style: TextStyle(
                fontFamily: 'Lemon',
                color: Colors.amber,
                fontSize: 40,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 1500,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildCard(
                      context,
                      "1.",
                      "PLAN",
                      const Icon(Icons.fact_check_outlined,
                          color: AppColors.greyLight)),
                  const SizedBox(width: 20),
                  buildCard(
                      context,
                      "2.",
                      "DESIGN",
                      const Icon(Icons.design_services_outlined,
                          color: AppColors.greyLight)),
                  const SizedBox(width: 20),
                  buildCard(context, "3.", "CODE",
                      const Icon(Icons.code_rounded, color: AppColors.greyLight)),
                  const SizedBox(width: 20),
                ],
              ),
            )
      
            // card('Design',
            //     IconButton(onPressed: null, icon: Icon(Icons.design_services)))
          ],
        ),
      ),
      mobileScreen: Padding(
        padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
        child: Column(
          children: [
            Text(
              "Working Process",
              style: TextStyle(
                fontFamily: 'Lemon',
                color: Colors.amber,
                fontSize: 22.sp,
              ),
            ),
            SizedBox(height: 10.sp),

            buildCard(context, "1.", "PLAN",
                const Icon(Icons.fact_check_outlined, color: AppColors.greyLight)),
      
            // SizedBox(height: 8.sp),
            buildCard(
                context,
                "2.",
                "DESIGN",
                const Icon(Icons.design_services_outlined,
                    color: AppColors.greyLight)),
      
            // SizedBox(height: 8.sp),
            buildCard(context, "3.", "CODE",
                const Icon(Icons.code_rounded, color: AppColors.greyLight)),
            // SizedBox(height: 8.sp),
            // card('Design',
            //     IconButton(onPressed: null, icon: Icon(Icons.design_services)))
          ],
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context, String index, String text, icon) {
    return Card(
      elevation: 3,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.cyyan, width: 3),
        borderRadius: BorderRadius.circular(10),
      ),
      margin:  EdgeInsets.all(15.sp),
      child: SizedBox(
        height: 50.sp,
        width: 50.sp,
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
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Center(
                child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 27.sp,
                    color: Colors.white,
                    onPressed: null,
                    icon: icon),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 16.sp,
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
