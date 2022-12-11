import 'package:covid_tracker/Model/world_state_model.dart';
import 'package:covid_tracker/Services/Utilites/states_services.dart';
import 'package:covid_tracker/screen/courtries_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:pie_chart/pie_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff1aa260),
    const Color(0xffde5246),
    const Color(0xff4285F4),
  ];
  @override
  Widget build(BuildContext context) {
    StatedServices statedServices = StatedServices();
   
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .01,),
            FutureBuilder(
              future: statedServices.fetchWorldRecords(),
              builder: (context,AsyncSnapshot<WorldStatesModel>snapshot){
                if(!snapshot.hasData){
                  return Expanded(
                    flex: 1,
                    child: SpinKitFadingCircle(
                      color: Colors.white,
                      controller: _controller,
                      size: 50,
                      ));
                }
                else{
                  return Column(
                    children: [
                        PieChart(
              dataMap: {
                'Total' : double.parse(snapshot.data!.cases!.toString()),
                'Recover' : double.parse(snapshot.data!.recovered.toString()),
                'Death' : double.parse(snapshot.data!.deaths.toString()),
            },
            chartType: ChartType.ring,
            chartValuesOptions: const ChartValuesOptions(
              showChartValuesInPercentage: true,
            ),
            animationDuration: const Duration(milliseconds: 1200),
            colorList: colorList,
            chartRadius: MediaQuery.of(context).size.width / 3.0,
            legendOptions: const LegendOptions(
              legendPosition: LegendPosition.left,
            ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
              child: Card(
                child: Column(
                  children: [
                  Reuseable(title: 'Total', value: snapshot.data!.cases.toString()),
                  Reuseable(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                  Reuseable(title: 'Recoverd', value: snapshot.data!.recovered.toString()),
                  Reuseable(title: 'Active', value: snapshot.data!.active.toString()),
                  Reuseable(title: 'Critical', value: snapshot.data!.critical.toString()),
                  Reuseable(title: 'Today death', value: snapshot.data!.todayDeaths.toString()),
                  Reuseable(title: 'Today Recoverd', value: snapshot.data!.todayRecovered.toString()),
                  ],
                ),
              )
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CountryListScreen()));
                },
                child: Container(
                  height: 50,
                  decoration:  BoxDecoration(
                    color: Color(0xff1aa260),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  
                  child: const Center(child: Text('Track Countires')),
                ),
              )
                    ],
                  );
                }
              } 
              ),
          
            
          ],
        ),
      ))
    );
  }
}
class Reuseable extends StatelessWidget {
  final String title, value;
  const Reuseable({super.key , required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(height: 5,),
          Divider(),
        ],
      ),
    );
  }
}
