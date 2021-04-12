import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GuruPage extends StatefulWidget {
  final Widget child;

  GuruPage({Key key, this.child}) : super(key: key);

  _GuruPageState createState() => _GuruPageState();
}

class _GuruPageState extends State<GuruPage> {
  List<charts.Series<StafStatus, String>> _seriesData;
  List<charts.Series<Task, String>> _seriesPieData;

  int iTetap, iTetapIkhwan = 131, iTetapAkhwat = 19,
      iKontrak, iKontrakIkhwan = 116, iKontrakAkhwat = 123,
      iHarianTetap, iHarianTetapIkhwan = 46, iHarianTetapAkhwat = 39,
      iHarianLepas, iHarianLepasIkhwan = 37, iHarianLepasAkhwat = 165,
      iPusat = 117, iCabang = 183;

  _generateData() {

    iTetap = iTetapIkhwan + iTetapAkhwat;
    iKontrak = iKontrakIkhwan + iKontrakAkhwat;
    iHarianTetap = iHarianTetapIkhwan + iHarianTetapAkhwat;
    iHarianLepas = iHarianLepasIkhwan + iHarianLepasAkhwat;

    var ikhwan = [
      new StafStatus('Tetap', iTetapIkhwan),
      new StafStatus('Kontrak', iKontrakIkhwan),
      new StafStatus('Harian Tetap', iHarianTetapIkhwan),
      new StafStatus('Harian Lepas', iHarianLepasIkhwan),
    ];
    var akhwat = [
      new StafStatus('Tetap', iTetapAkhwat),
      new StafStatus('Kontrak', iKontrakAkhwat),
      new StafStatus('Harian Tetap', iHarianTetapAkhwat),
      new StafStatus('Harian Lepas', iHarianLepasAkhwat),
    ];

    var piedata = [
      new Task('Pusat 117 Pegawai', 39.00, Color(0xff15277B)),
      new Task('Cabang 183 Pegawai', 61.00, Color(0xff7B156E)),
    ];

    _seriesData.add(
      charts.Series(
        domainFn: (StafStatus stafStatus, _) => stafStatus.place,
        measureFn: (StafStatus stafStatus, _) => stafStatus.quantity,
        id: '2017',
        data: ikhwan,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (StafStatus stafStatus, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff15277B)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (StafStatus stafStatus, _) => stafStatus.place,
        measureFn: (StafStatus stafStatus, _) => stafStatus.quantity,
        id: '2018',
        data: akhwat,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (StafStatus stafStatus, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff7B156E)),
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
            backgroundColor: Color(0xff1976d2),
            //backgroundColor: Color(0xff308e1c),
            bottom: TabBar(
              indicatorColor: Color(0xff9962D0),
              tabs: [
                Tab(
                  icon: Icon(FontAwesomeIcons.solidChartBar),
                ),
                Tab(icon: Icon(FontAwesomeIcons.chartPie)),
              ],
            ),
            title: Text('Pegawai Guru'),
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
                            barGroupingType: charts.BarGroupingType.grouped,
                            //behaviors: [new charts.SeriesLegend()],
                            animationDuration: Duration(seconds: 1),
                          ),
                        ),
                        Text(
                          '\n$iTetap Tetap = $iTetapIkhwan Ikhwan & '
                              '$iTetapAkhwat Akhwat \n$iKontrak '
                              'Kontrak = $iKontrakIkhwan Ikhwan & '
                              '$iKontrakAkhwat Akhwat \n$iHarianTetap '
                              'Harian Tetap = $iHarianTetapIkhwan Ikhwan & '
                              '$iHarianTetapAkhwat Akhwat\n'
                              '$iHarianLepas Harian Lepas = $iHarianLepasIkhwan '
                              'Ikhwan + $iHarianLepasAkhwat '
                              'Akhwat\n ',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold),
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
                                      color: charts.MaterialPalette.purple.shadeDefault,
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
  String place;
  int quantity;

  StafStatus(this.place, this.quantity);
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}