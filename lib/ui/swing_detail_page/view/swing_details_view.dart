import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hackmotion_mobile_developer_homework/models/swing.dart';
import 'package:hackmotion_mobile_developer_homework/ui/swing_list_page/bloc/events/swing_list_bloc_events.dart';
import 'package:hackmotion_mobile_developer_homework/ui/swing_list_page/bloc/swing_list_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SwingDetailsView extends StatelessWidget {
  final List<CapturedSwing> swingsList;
  final CapturedSwing swing;
  final VoidCallback onDelete;

  const SwingDetailsView(
      {super.key,
      required this.swingsList,
      required this.swing,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Swing ${swing.name}',
                  style: const TextStyle(
                      fontSize: 24.0, fontWeight: FontWeight.bold)),
              IconButton(
                onPressed: () {
                  //Delete from swingslist
                  onDelete();
                  context.read<SwingListBloc>().add(DeleteSwing(swing));
                },
                icon: const Icon(Icons.delete),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 7),
            child: Text("Swing graph",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ),
          SfCartesianChart(
            //Trackball
            plotAreaBorderWidth: 0,
            trackballBehavior: TrackballBehavior(
                enable: true,
                activationMode: ActivationMode.singleTap,
                lineType: TrackballLineType.vertical,
                tooltipSettings: const InteractiveTooltip(
                  enable: true,
                )),

            primaryXAxis: const NumericAxis(
              //Hide the x-axis labels (Data point count)
              isVisible: false,
            ),
            primaryYAxis: const NumericAxis(
                //Set the y-axis range (static)
                minimum: -60,
                maximum: 60,
                //Make the y-axis lines dotted and grey and make the 0 line bold
                majorGridLines: MajorGridLines(
                    width: 0.5, color: Colors.grey, dashArray: [2, 2]),
                majorTickLines: MajorTickLines(width: 0),
                axisLine: AxisLine(width: 0)),
            borderWidth: 1,
            borderColor: Colors.grey.shade400,

            legend:
                const Legend(isVisible: true, position: LegendPosition.bottom),
            series: [
              FastLineSeries<double, int>(
                animationDuration: 3000,
                dataSource: swing.parameters.flexEx.values,
                xValueMapper: (double value, int index) => index,
                yValueMapper: (double value, _) => value,
                name: 'Felxion Extension',
                color: const Color(0xFFff9300),
              ),
              FastLineSeries<double, int>(
                  animationDuration: 3000,
                  dataSource: swing.parameters.radUln.values,
                  xValueMapper: (double value, int index) => index,
                  yValueMapper: (double value, _) => value,
                  name: 'Ulnar Radial Deviation',
                  color: const Color(0xFF00c0ba)),
            ],
          )
        ],
      ),
    );
  }
}
