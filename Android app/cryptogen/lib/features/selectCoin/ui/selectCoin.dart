import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../Models/chartModel.dart';

class SelectCoin extends StatefulWidget {
  var selectItem;
  SelectCoin({this.selectItem});

  @override
  State<SelectCoin> createState() => _SelectCoinState();
}

class _SelectCoinState extends State<SelectCoin> {
  late TrackballBehavior trackballBehavior;

  @override
  void initState() {
    getChart();
    trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            body: Container(
      height: myHeight,
      width: myWidth,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.black87,
            Colors.black,
          ],
        ),
      ),
      child: Column(children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: myWidth * 0.05, vertical: myHeight * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                      height: myHeight * 0.08,
                      child: Image.network(
                        widget.selectItem.image,
                      )),
                  SizedBox(
                    width: myWidth * 0.03,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.selectItem.id,
                        style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: myHeight * 0.01,
                      ),
                      Text(
                        widget.selectItem.symbol,
                        style: const TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${widget.selectItem.currentPrice}',
                    style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: myHeight * 0.01,
                  ),
                  Text(
                    widget.selectItem.marketCapChangePercentage24H.toString() +
                        '%',
                    style: TextStyle(
                        color:
                            widget.selectItem.marketCapChangePercentage24H >= 0
                                ? Colors.green
                                : Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: myWidth * 0.05, vertical: myHeight * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Low',
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        height: myHeight * 0.02,
                      ),
                      Text(
                        '\$${widget.selectItem.low24H}',
                        style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'High',
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        height: myHeight * 0.02,
                      ),
                      Text(
                        '\$${widget.selectItem.high24H}',
                        style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Vol',
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 20,
                            fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        height: myHeight * 0.02,
                      ),
                      Text(
                        '\$${widget.selectItem.totalVolume}',
                        style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: myHeight * 0.02,
            ),
            Container(
              height: myHeight * 0.4,
              width: myWidth,
              // color: Colors.orange,
              child: isRefresh == true
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : SfCartesianChart(
                trackballBehavior: trackballBehavior,
                zoomPanBehavior: ZoomPanBehavior(
                    enablePanning: true, zoomMode: ZoomMode.x),
                series: <CandleSeries>[
                  CandleSeries<ChartModel, int>(
                    enableSolidCandles: true,
                    enableTooltip: true,
                    bullColor: Colors.green,
                    bearColor: Colors.red,
                    dataSource: itemChart,
                    xValueMapper: (ChartModel sales, _) => sales.time,
                    lowValueMapper: (ChartModel sales, _) => sales.low,
                    highValueMapper: (ChartModel sales, _) => sales.high,
                    openValueMapper: (ChartModel sales, _) => sales.open,
                    closeValueMapper: (ChartModel sales, _) => sales.close,
                    animationDuration: 55,
                  )
                ],
              ),
            ),
            SizedBox(
              height: myHeight * 0.01,
            ),
            Container(
              height: myHeight * 0.04,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: text.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: myWidth * 0.02),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          // Update textBool directly
                          textBool = List.generate(6, (i) => i == index);
                        });
                        setDays(text[index]);
                        getChart();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: myWidth * 0.03, vertical: myHeight * 0.005),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: textBool[index]
                              ? Colors.orange.withOpacity(0.6)
                              : Colors.transparent,
                        ),
                        child: Text(
                          text[index],
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        )),
        Container(
          height: myHeight*0.1,
          width: myWidth,
          color: Colors.orange,
          child: Column(
            children: [
              Divider(),
            ],
          ),
        )
      ]),
    )));
  }

  List<String> text = ['D', 'W', 'M', '3M', '6M', 'Y'];
  List<bool> textBool = [false, false, true, false, false, false];

  int days = 30;

  setDays(String txt) {
    if (txt == 'D') {
      setState(() {
        days = 1;
      });
    } else if (txt == 'W') {
      setState(() {
        days = 7;
      });
    } else if (txt == 'M') {
      setState(() {
        days = 30;
      });
    } else if (txt == '3M') {
      setState(() {
        days = 90;
      });
    } else if (txt == '6M') {
      setState(() {
        days = 180;
      });
    } else if (txt == 'Y') {
      setState(() {
        days = 365;
      });
    }
  }

  List<ChartModel>? itemChart;

  bool isRefresh = true;

  Future<void> getChart() async {
    String url = '${'https://api.coingecko.com/api/v3/coins/' +
        widget.selectItem.id}/ohlc?vs_currency=usd&days=$days';

    setState(() {
      isRefresh = true;
    });

    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });

    setState(() {
      isRefresh = false;
    });
    if (response.statusCode == 200) {
      Iterable x = json.decode(response.body);
      List<ChartModel> modelList =
      x.map((e) => ChartModel.fromJson(e)).toList();
      setState(() {
        itemChart = modelList;
      });
    } else {
      print(response.statusCode);
    }
  }
}