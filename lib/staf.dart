import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StafPage extends StatefulWidget {
  final Widget child;

  StafPage({Key key, this.child}) : super(key: key);

  _StafPageState createState() => _StafPageState();
}

class _StafPageState extends State<StafPage> {
  List<charts.Series<StafStatus, String>> _seriesData;
  List<charts.Series<Task, String>> _seriesPieData;

  int iTetap, iTetapIkhwan = 131, iTetapAkhwat = 3,
      iKontrak, iKontrakIkhwan = 134, iKontrakAkhwat = 29,
      iHarian, iHarianIkhwan = 0, iHarianAkhwat = 0,
      iTenagaAhli, iTenagaAhliIkhwan = 3, iTenagaAhliAkhwat = 0,
      iPusat = 117, iCabang = 183;

  _generateData() {
    iTetap = iTetapIkhwan + iTetapAkhwat;
    iKontrak = iKontrakIkhwan + iKontrakAkhwat;
    iHarian = iHarianIkhwan + iHarianAkhwat;
    iTenagaAhli = iTenagaAhliIkhwan + iTenagaAhliAkhwat;
    var ikhwan = [
      new StafStatus('Tetap', iTetapIkhwan),
      new StafStatus('Kontrak', iKontrakIkhwan),
      new StafStatus('Harian Lepas', iHarianIkhwan),
      new StafStatus('Tenaga Ahli', iTenagaAhliIkhwan),
    ];
    var akhwat = [
      new StafStatus('Tetap', iTetapAkhwat),
      new StafStatus('Kontrak', iKontrakAkhwat),
      new StafStatus('Harian Lepas', iHarianAkhwat),
      new StafStatus('Tenaga Ahli', iTenagaAhliAkhwat),
    ];

    double dPusat = (iPusat/(iPusat + iCabang))*100.toDouble();
    double dCabang = (iCabang/(iCabang + iPusat))*100.toDouble();

    var piedata = [
      new Task('Pusat $iPusat  Pegawai', dPusat, Color(0xff15277B)),
      new Task('Cabang $iCabang Pegawai', dCabang, Color(0xff7B156E)),
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
                            barGroupingType: charts.BarGroupingType.grouped,
                            //behaviors: [new charts.SeriesLegend()],
                            animationDuration: Duration(seconds: 1),
                          ),
                        ),
                        Text(
                          '\n134 Tetap = 131 Ikhwan & 3 Akhwat \n163 Kontrak = 134 Ikhwan & 29 Akhwat \n0 Harian Lepas \n3 Tenaga Ahli Ikhwan \n ',
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