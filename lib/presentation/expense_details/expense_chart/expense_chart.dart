
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class ExpenseTrackerResponse {
//   final String dateString;
//   final double value;

//   ExpenseTrackerResponse({required this.dateString, required this.value});
// }

// class ChartColors {
//   final Color primaryColor;
//   final Color markerColor;
//   final LinearGradient gradient;

//   ChartColors({
//     required this.primaryColor,
//     required this.markerColor,
//     required this.gradient,
//   });

//   static ChartColors defaultColors() {
//     return ChartColors(
//       primaryColor: Color(0xff74b9ff),
//       markerColor: Color(0xff0984e3),
//       gradient: LinearGradient(
//         colors: [Colors.blue.shade300, Colors.blue.shade700],
//         stops: [0.1, 0.9],
//       ),
//     );
//   }
// }

// // Chart widget that receives dynamic data
// class ExpenseChartView extends StatefulWidget {
//   final List<ExpenseTrackerResponse> data;
//   final ChartColors chartColors;

//   const ExpenseChartView({
//     Key? key,
//     required this.data,
//     required this.chartColors,
//   }) : super(key: key);

//   @override
//   _ExpenseChartViewState createState() => _ExpenseChartViewState();
// }

// class _ExpenseChartViewState extends State<ExpenseChartView> {
//   late TooltipBehavior _tooltipBehavior;

//   @override
//   void initState() {
//     super.initState();
//     _tooltipBehavior = TooltipBehavior(
//       enable: true,
//       borderWidth: 0,
//       builder: (data, b, c, d, e) => Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(
//           "₹${data.value.toStringAsFixed(2)}", // Display the value as ₹
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       color: widget.chartColors.primaryColor,
//     );
//   }

//   double get minValue => widget.data.map<double>((e) => e.value).reduce(min);
//   double get maxValue => widget.data.map<double>((e) => e.value).reduce(max);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Expense Tracker",
//                 style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 "Expenses Over Time",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           height: 200,
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: SfCartesianChart(
//             plotAreaBorderWidth: 0,
//             enableSideBySideSeriesPlacement: false,
//             zoomPanBehavior: ZoomPanBehavior(
//               enablePanning: true, // Enable horizontal panning
//               enablePinching: true,
//               zoomMode: ZoomMode.x, // Horizontal zoom (scaling)
//             ),
//             primaryYAxis: NumericAxis(
//               interval: 100, // Set interval for Y-axis to scale based on values
//               minimum: min(minValue, 0), // Ensure a safe minimum
//               maximum: max(maxValue, 0), // Ensure a safe maximum
//               axisLine: AxisLine(color: widget.chartColors.primaryColor, width: 2),
//               labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
//               majorGridLines: MajorGridLines(width: 0),
//               opposedPosition: true, // To show the axis on the right side
//               majorTickLines: MajorTickLines(width: 0),
//             ),
//             primaryXAxis: CategoryAxis(
//               axisLine: AxisLine(color: widget.chartColors.primaryColor, width: 2),
//               labelStyle: TextStyle(color: Colors.grey, fontSize: 10),
//               majorTickLines: MajorTickLines(width: 0),
//             ),
//             tooltipBehavior: _tooltipBehavior,
//             series: <CartesianSeries>[
//               ColumnSeries<ExpenseTrackerResponse, String>(
//                 dataSource: widget.data,
//                 width: 0.015,
//                 xValueMapper: (ExpenseTrackerResponse data, _) => data.dateString,
//                 yValueMapper: (ExpenseTrackerResponse data, _) => data.value,
//                 dashArray: <double>[5, 5],
//                 color: widget.chartColors.primaryColor,
//                 enableTooltip: false,
//               ),
//               SplineAreaSeries<ExpenseTrackerResponse, String>(
//                 animationDuration: 1000,
//                 splineType: SplineType.cardinal,
//                 gradient: widget.chartColors.gradient,
//                 dataSource: widget.data,
//                 markerSettings: MarkerSettings(
//                   isVisible: true,
//                   borderColor: widget.chartColors.markerColor,
//                 ),
//                 xValueMapper: (ExpenseTrackerResponse data, _) => data.dateString,
//                 yValueMapper: (ExpenseTrackerResponse data, _) => data.value,
//                 enableTooltip: true,
//                 borderWidth: 3,
//                 borderDrawMode: BorderDrawMode.top,
//                 borderColor: widget.chartColors.primaryColor,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// // Sample dynamic data
// List<ExpenseTrackerResponse> generateDynamicExpenseData() {
//   return [
//     ExpenseTrackerResponse(dateString: '2023-01', value: 40),
//     ExpenseTrackerResponse(dateString: '2023-02', value: 500),
//     ExpenseTrackerResponse(dateString: '2023-03', value: 100),
//     ExpenseTrackerResponse(dateString: '2023-04', value: 10),
//     ExpenseTrackerResponse(dateString: '2023-05', value: 80),
//     ExpenseTrackerResponse(dateString: '2023-06', value: 8),
//     ExpenseTrackerResponse(dateString: '2023-07', value: 90),
//     ExpenseTrackerResponse(dateString: '2023-08', value: 90),
//   ];
// }

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: Scaffold(
//       appBar: AppBar(
//         title: Text('Expense Tracker App'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ExpenseChartView(
//           data: generateDynamicExpenseData(), // Dynamic data passed to chart
//           chartColors: ChartColors.defaultColors(), // Customizable chart colors
//         ),
//       ),
//     ),
//   ));
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(MaterialApp(home: WeightTrackerScreen()));
}

class WeightTrackerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weight Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: WeightTrackerUI(),
      ),
    );
  }
}

class WeightTrackerUI extends StatelessWidget {
  // Sample static data for the weight tracker
  final List<Map<String, dynamic>> weightData = [
    {"date": "01/01/2025", "weight": 70.5},
    {"date": "01/02/2025", "weight": 69.0},
    {"date": "01/03/2025", "weight": 68.5},
    {"date": "01/04/2025", "weight": 67.0},
    {"date": "01/05/2025", "weight": 66.5},
     {"date": "01/6/2025", "weight": 16.5},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Weight summary section
        Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.only(top: 12, bottom: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xfffffbf6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WeightWidget(title: "Starting weight", weight: "70.5 kg"),
              VerticalDivider(),
              WeightWidget(title: "Current weight", weight: "66.5 kg"),
              VerticalDivider(),
              WeightWidget(title: "Weight Goal", weight: "65.0 kg"),
            ],
          ),
        ),
        SizedBox(height: 8),
        // Week labels section
        Container(
          color: Color.fromARGB(255, 191, 60, 0).withOpacity(0.1),
          padding: EdgeInsets.all(2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ["Week 1", "Week 2", "Week 3", "Week 4", "Week 5"]
                .map((range) => TrackerText(title: range))
                .toList(),
          ),
        ),
        SizedBox(height: 16),
        // Chart section
        ChartView(data: weightData),
        SizedBox(height: 16),
        // History section
        Text(
          "History",
          style: TextStyle(
            color: Color(0xff002d18),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: weightData.length,
            itemBuilder: (context, index) {
              final data = weightData[index];
              return WeightHistory(data: data);
            },
          ),
        ),
      ],
    );
  }
}

class WeightWidget extends StatelessWidget {
  final String title;
  final String weight;

  const WeightWidget({Key? key, required this.title, required this.weight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Color(0xff838383),
            fontSize: 12,
          ),
        ),
        SizedBox(height: 8),
        Text(
          weight,
          style: TextStyle(
            color: Color(0xff002d18),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 50,
      color: Color(0xff838383),
    );
  }
}

class TrackerText extends StatelessWidget {
  final String title;

  const TrackerText({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(left: 8, right: 8),
        padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Color.fromARGB(255, 196, 105, 0),
            width: 1,
          ),
          color: Color(0x19ffba69),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xff002d18),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class WeightHistory extends StatelessWidget {
  final Map<String, dynamic> data;

  WeightHistory({Key? key, required this.data}) : super(key: key);

  DateFormat _dateFormat = DateFormat('dd MMMM yyyy');

  DateTime getDateTimeInFormat(String date) {
    var dateList = date.split('/');
    String dateString = "${dateList[2]}-${dateList[1]}-${dateList[0]}";
    return DateTime.parse(dateString);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "${data['weight']} kg",
              style: TextStyle(
                color: Color(0xff002d18),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              _dateFormat.format(getDateTimeInFormat(data['date'])),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff838383),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartView extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const ChartView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PhysicalTrackerResponse> chartData = data
        .map((e) => PhysicalTrackerResponse(
              date: e['date'],
              value: e['weight'],
              dateString: e['date'],
            ))
        .toList();

    return SfCartesianChart(
      tooltipBehavior: TooltipBehavior(enable: true),
      primaryXAxis: CategoryAxis(), // Use CategoryAxis for String type x values
      series: <ChartSeries>[
        SplineAreaSeries<PhysicalTrackerResponse, String>(
          dataSource: chartData,
          xValueMapper: (PhysicalTrackerResponse data, _) => data.dateString,
          yValueMapper: (PhysicalTrackerResponse data, _) => data.value,
          gradient: LinearGradient(
            colors: [Color.fromARGB(56, 255, 136, 0), Color.fromARGB(255, 132, 70, 0)],
          ),
        ),
      ],
    );
  }
}

class PhysicalTrackerResponse {
  final String date;
  final double value;
  final String dateString;

  PhysicalTrackerResponse(
      {required this.date, required this.value, required this.dateString});
}
