import 'package:flutter/material.dart';
import 'package:portfolio/config/colors.dart';
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
      desktopScreen: Container(
        // height: MediaQuery.of(context).size.height / 2,
        decoration: BoxDecoration(
          border: Border.all(width: 0, color: Colors.transparent),
          gradient: LinearGradient(
            colors: [
              // Color(0xFF546E7A),
              // Color(0xFF455A64),
              const Color(0xFF37474F),

              const Color(0xFF263238),
              Colors.black.withOpacity(0.9)

              // Colors.transparent,
              // Colors.transparent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0, 0.5, 1],
          ),
        ),
        child: Padding(
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
      ),
      mobileScreen: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              // Color(0xFF546E7A),
              // Color(0xFF455A64),
              const Color(0xFF37474F),

              const Color(0xFF263238),
              Colors.black.withOpacity(0.9),

              // Colors.transparent,
              // Colors.transparent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0, 0.5, 1],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
          child: Column(
            children: [
              const Text(
                "Working Process",
                style: TextStyle(
                  fontFamily: 'Lemon',
                  color: Colors.amber,
                  fontSize: 30,
                ),
              ),
              buildCard(context, "1.", "PLAN",
                  const Icon(Icons.fact_check_outlined, color: AppColors.greyLight)),

              const SizedBox(height: 10),
              buildCard(
                  context,
                  "2.",
                  "DESIGN",
                  const Icon(Icons.design_services_outlined,
                      color: AppColors.greyLight)),

              const SizedBox(height: 10),
              buildCard(context, "3.", "CODE",
                  const Icon(Icons.code_rounded, color: AppColors.greyLight)),
              const SizedBox(height: 10),
              // card('Design',
              //     IconButton(onPressed: null, icon: Icon(Icons.design_services)))
            ],
          ),
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
      margin: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 220,
        width: 220,
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
                  style: const TextStyle(
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
                    icon: icon),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  text,
                  style: const TextStyle(
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
