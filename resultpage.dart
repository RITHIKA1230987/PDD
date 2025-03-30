import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ResultPage extends StatelessWidget {
  final double bufferCapacity;
  final double accuracy;
  final double additionalAcid;
  final double additionalBase;

  const ResultPage({
    Key? key,
    required this.bufferCapacity,
    required this.accuracy,
    required this.additionalAcid,
    required this.additionalBase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculation Result"),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background3.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                color: Colors.white70,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        "Buffer Calculation Result",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Your buffer has the capacity of $bufferCapacity M",
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Summary: The calculated buffer solution demonstrates excellent resistance to pH changes. The system remains stable within the desired range, indicating optimal buffer capacity.",
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Accuracy Comparison: $accuracy%",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Additional Adjustments: To achieve the desired pH, add $additionalAcid M more acid or $additionalBase M more base.",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Text("pH vs. Concentration Graph", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Container(
                        height: 200,
                        child: LineChart(
                          LineChartData(
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  FlSpot(4.0, 0.1),
                                  FlSpot(5.0, 0.2),
                                  FlSpot(6.0, 0.4),
                                  FlSpot(7.0, 0.6),
                                  FlSpot(8.0, 0.8),
                                  FlSpot(9.0, 1.0),
                                ],
                                isCurved: true,
                                barWidth: 3,
                                color: Colors.red,
                                dotData: FlDotData(show: true),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
             ),
            ),
          ),
        ],
      ),
    );
  }
}
