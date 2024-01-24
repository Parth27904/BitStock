import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  var item;
  Item({this.item});

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            height: myHeight * 0.1,
            padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
            child: Image.network(item.image),
          ),
          SizedBox(
            width: myWidth * 0.04,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.id,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.orange),
              ),
              Text(
                '0.4' + item.symbol,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.orange
                ),
              )
            ],
          ),
          SizedBox(
            width: myWidth*0.04,
          ),
          Container(
            height: myHeight*0.05,
            width: myWidth*0.2,
            child: Sparkline(data: item.sparklineIn7D.price,
            lineWidth: 2.0,
            lineColor: item.marketCapChangePercentage24H >= 0 ? Colors.green : Colors.red,
            fillMode: FillMode.below,
            fillGradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0,0.7],
              colors:item.marketCapChangePercentage24H >= 0 ? [Colors.green,Colors.green.shade200] : [Colors.red,Colors.red.shade200]
            ),
            ),
          ),
          SizedBox(width: myWidth*0.04,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\$${item.currentPrice}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.orange),
              ),
              Row(
                children: [
                  Text(
                    item.priceChange24H.toString().contains('-')
                        ? "- \$" +
                        item.priceChange24H
                            .toStringAsFixed(2)
                            .toString()
                            .replaceAll('-', '')
                        : '\$' + item.priceChange24H.toStringAsFixed(2),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.orange
                    ),
                  ),
                  SizedBox(width: myWidth*0.03,),
                  Text(
                    item.marketCapChangePercentage24H.toStringAsFixed(2),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: item.marketCapChangePercentage24H >=0 ? Colors.green : Colors.red
                    ),
                  ),
                  SizedBox(width: myWidth*0.02,),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
