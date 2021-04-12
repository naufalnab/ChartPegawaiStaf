import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TrendPage extends StatefulWidget {
  final Widget child;

  TrendPage({Key key, this.child}) : super(key: key);

  _TrendPageState createState() => _TrendPageState();
}

class _TrendPageState extends State<TrendPage> {
  List<charts.Series<StafStatus, String>> _seriesData;
  List<charts.Series<Task, String>> _seriesPieData;

  _generateData() {
    var ikhwan = [
      new StafStatus('ikhwan', 'Tetap', 131),
      new StafStatus('ikhwan', 'Kontrak', 134),
      new StafStatus('ikhwan', 'Harian Lepas', 0),
      new StafStatus('ikhwan', 'Tenaga Ahli', 3),
    ];
    var akhwat = [
      new StafStatus('akhwat', 'Tetap', 3),
      new StafStatus('akhwat', 'Kontrak', 29),
      new StafStatus('akhwat', 'Harian Lepas', 0),
      new StafStatus('akhwat', 'Tenaga Ahli', 0),
    ];

    var piedata = [
      new Task('Pusat 117 Pegawai', 39.00, Colors.teal[700]),
      new Task('Cabang 183 Pegawai', 61.00, Color(0xff6CDDE3)),
    ];

    _seriesData.add(
      charts.Series(
        domainFn: (StafStatus stafStatus, _) => stafStatus.status,
        measureFn: (StafStatus stafStatus, _) => stafStatus.jumlah,
        id: '2017',
        data: ikhwan,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (StafStatus stafStatus, _) =>
            charts.ColorUtil.fromDartColor(Colors.teal[700]),

        labelAccessorFn: (StafStatus stafStatus,_)=> '${stafStatus.jk} : ${stafStatus.jumlah.toString()}',
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (StafStatus stafStatus, _) => stafStatus.status,
        measureFn: (StafStatus stafStatus, _) => stafStatus.jumlah,
        id: '2018',
        data: akhwat,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (StafStatus stafStatus, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff6CDDE3)),

        labelAccessorFn: (StafStatus stafStatus,_)=> '${stafStatus.jk} : ${stafStatus.jumlah.toString()}',
      ),
    );

    _seriesPieData.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air PollutSion',
        data: piedata,
        labelAccessorFn: (Task row, _) => '${row.taskvalue}',
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesData = List<charts.Series<StafStatus, String>>();
    _seriesPieData = List<charts.Series<Task, String>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            //backgroundColor: Color(0xff308e1c),
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(FontAwesomeIcons.solidChartBar),
                ),
                Tab(icon: Icon(FontAwesomeIcons.chartPie)),
              ],
            ),
            title: Text('Pegawai Staf'),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Berdasarkan Status',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: charts.BarChart(
                            _seriesData,
                            animate: true,
                            vertical: false,
                            barGroupingType: charts.BarGroupingType.grouped,
                            barRendererDecorator: charts.BarLabelDecorator<String>(),
                            //behaviors: [new charts.SeriesLegend()],
                            animationDuration: Duration(seconds: 1),
                          ),
                        ),
                        SizedBox(
                          height: 150,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Berdasarkan Homebase',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.0,),
                        Expanded(
                          child: charts.PieChart(
                              _seriesPieData,
                              animate: true,
                              animationDuration: Duration(seconds: 1),
                              behaviors: [
                                new charts.DatumLegend(
                                  outsideJustification: charts.OutsideJustification.endDrawArea,
                                  horizontalFirst: false,
                                  desiredMaxRows: 2,
                                  cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                                  entryTextStyle: charts.TextStyleSpec(
                                      color: charts.MaterialPalette.black,
                                      fontFamily: 'Georgia',
                                      fontSize: 11),
                                )
                              ],
                              defaultRenderer: new charts.ArcRendererConfig(
                                  arcWidth: 100,
                                  arcRendererDecorators: [
                                    new charts.ArcLabelDecorator(
                                        labelPosition: charts.ArcLabelPosition.inside)
                                  ]
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StafStatus {
  String status;
  int jumlah;
  String jk;
  

  StafStatus(this.jk, this.status, this.jumlah);
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}