import 'package:cryptogen/features/components/item2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../Models/coinModel.dart';

class Buy extends StatefulWidget {
  const Buy({super.key});

  @override
  State<Buy> createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  @override
  void initState() {
    getCoinMarket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Image(
                  image: AssetImage('assets/logo.png'), height: 80, width: 80),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text(
                    '\$' '7839',
                    style: TextStyle(color: Colors.orange, fontSize: 30),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.wallet,
                    color: Colors.orange,
                    size: 35,
                  ),
                ],
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(25, 0, 0, 10),
          child: Text(
            'Recommended To Buy',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.orange),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(25, 0, 25, 25),
          padding: EdgeInsets.only(left: myWidth*0.03),
          width: myWidth,
          height: 215,
          decoration: BoxDecoration(
              color: Colors.grey.shade900,
              border: Border.all(color: Colors.orange),
              borderRadius: BorderRadius.circular(25)),
          child: ListView.builder(
              itemCount: coinMarket!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Item2(
                  item: coinMarket![index],
                );
              }),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(25, 0, 0, 10),
          child: Text(
            'Recommended To Buy',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.orange),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(25, 0, 25, 25),
          width: 360,
          height: 215,
          decoration: BoxDecoration(
              color: Colors.grey.shade900,
              border: Border.all(color: Colors.orange),
              borderRadius: BorderRadius.circular(25)),
        ),
      ]),
    ));
  }

  bool isRefreshing = true;
  List? coinMarket = [];
  var coinMarketList;
  Future<List<CoinModel>?> getCoinMarket() async {
    const url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true';
    setState(() {
      isRefreshing = true;
    });
    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    });
    setState(() {
      isRefreshing = false;
    });
    if (response.statusCode == 200) {
      var x = response.body;
      coinMarketList = coinModelFromJson(x);
      setState(() {
        coinMarket = coinMarketList;
      });
    } else {
      print(response.statusCode);
    }
    return null;
  }
}
