import 'package:covid_tracker/screen/home_screen.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  String name;
  String image;
  int? totalCases, totalDeaths, totalRecovered, active, critical, todayRecovered, tests;

  DetailsScreen({ 

    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical, 
    required this.todayRecovered,
    required this.tests,
    

  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15,),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height *.06,),
                        Reuseable(title: 'Cases', value: widget.totalCases.toString()),
                         Reuseable(title: 'Total Deaths', value: widget.totalDeaths.toString()),
                          Reuseable(title: 'Total Recovered', value: widget.totalRecovered.toString()),
                           Reuseable(title: 'Active', value: widget.active.toString()),
                            Reuseable(title: 'Critical', value: widget.critical.toString()),
                             Reuseable(title: 'Todays Recoverd', value: widget.todayRecovered.toString()),
                              Reuseable(title: 'Tests', value: widget.tests.toString()),
      
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}