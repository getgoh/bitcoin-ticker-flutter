import 'package:bitcoin_ticker/utilities/constants.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String title;
  final dynamic data;
  final String currency;

  DetailScreen({this.title, this.data, this.currency});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
//  tmp () {
//    ListView(children: <Widget>[
//
//    ],)
//  }

  _buildHeader() {
    return Center(
      child: Text(
        widget.currency,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _buildAverages() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Averages',
            style: TextStyle(
              fontSize: 22.0,
            ),
          ),
          SizedBox(height: 5.0),
          Text('Day: ${widget.data['averages']['day']}'),
          Text('Week: ${widget.data['averages']['week']}'),
          Text('Month: ${widget.data['averages']['month']}'),
        ],
      ),
    );
  }

  _buildChanges() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Changes',
            style: TextStyle(
              fontSize: 22.0,
            ),
          ),
          Text('Hour: ${widget.data['changes']['price']['hour']}'),
          Text('Day: ${widget.data['changes']['price']['day']}'),
          Text('Week: ${widget.data['changes']['price']['week']}'),
          Text('Month: ${widget.data['changes']['price']['month']}'),
          Text('3 Months: ${widget.data['changes']['price']['month_3']}'),
          Text('6 Months: ${widget.data['changes']['price']['month_6']}'),
          Text('Year: ${widget.data['changes']['price']['year']}'),
        ],
      ),
    );
  }

  _buildMain() {
    return Container(
      padding: EdgeInsets.only(
        top: 12.0,
        bottom: 4.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Main',
            style: TextStyle(
              fontSize: 22.0,
            ),
          ),
          SizedBox(height: 5.0),
          Text('Last: ${widget.data['last']}'),
          Text('Ask: ${widget.data['ask']}'),
          Text('Bid: ${widget.data['bid']}'),
          Text('High: ${widget.data['high']}'),
          Text('Low: ${widget.data['low']}'),
          Text('Volume: ${widget.data['volume']}'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        decoration: kGradientBoxDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildHeader(),
            _buildMain(),
            Divider(color: Colors.white30),
            _buildAverages(),
            Divider(color: Colors.white30),
            _buildChanges(),
          ],
        ),
      ),
    );
  }
}
