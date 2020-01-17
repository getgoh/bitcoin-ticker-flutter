import 'package:bitcoin_ticker/components/coin_card.dart';
import 'package:bitcoin_ticker/screens/detail_screen.dart';
import 'package:bitcoin_ticker/services/exchange_rate_helper.dart';
import 'package:bitcoin_ticker/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utilities/coin_data.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'dart:io' show Platform;
import 'package:flutter_spinkit/flutter_spinkit.dart';

NumberFormat currencyFormatter = NumberFormat('#,##0.0000', 'en_US');

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = currenciesList.first;
  String previousCurrency = currenciesList.first;

  String bitcoinVal = '0';
  String ethereumVal = '0';
  String litecoinVal = '0';

  var bitcoinData;
  var ethereumData;
  var litecoinData;

  bool isLoading = true;
  bool isError = false;

  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });

    bitcoinData =
        await ExchangeRateHelper().getBitcoinDataBySymbol(selectedCurrency);
    ethereumData =
        await ExchangeRateHelper().getEthereumDataBySymbol(selectedCurrency);
    litecoinData =
        await ExchangeRateHelper().getLitecoinDataBySymbol(selectedCurrency);

    updateUI();
  }

  void updateUI() {
    setState(() {
      if (bitcoinData != null) {
        isError = false;
        bitcoinVal = currencyFormatter
            .format(double.parse('${bitcoinData['last']}'))
            .toString();
        ethereumVal = currencyFormatter
            .format(double.parse('${ethereumData['last']}'))
            .toString();
        litecoinVal = currencyFormatter
            .format(double.parse('${litecoinData['last']}'))
            .toString();
      } else {
        isError = true;
      }

      isLoading = false;
    });
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Container(
          alignment: Alignment.center,
          child: Text(currency),
          width: 80.0,
        ),
        value: (currency),
      );
      dropDownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      style: TextStyle(
        fontSize: 20.0,
      ),
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          if (value != selectedCurrency) {
            previousCurrency = selectedCurrency;
            selectedCurrency = value;
            getData();
          }
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Widget> pickerItems = [];
    for (String currency in currenciesList) {
      var newItem = Text(currency);
      pickerItems.add(newItem);
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = currenciesList[selectedIndex];
        getData();
      },
      children: pickerItems,
    );
  }

  final loadingCircle = SpinKitFadingCircle(
    color: Colors.white,
    size: 50.0,
  );

  @override
  Widget build(BuildContext context) {
    _buildBodyStack() {
      List<Widget> stack = [
        Container(
          decoration: kGradientBoxDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RefreshIndicator(
                onRefresh: () {
                  return Future<void>(() {
                    getData();
                  });
                },
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                  top: 12.0,
                                  bottom: 4.0,
                                ),
                                child: Text(
                                  'Exchange Rate for\n${currencyMap[selectedCurrency]}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 28.0,
                                  ),
                                ),
                              ),
                              CoinCard(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return DetailScreen(
                                          title: 'Bitcoin',
                                          data: bitcoinData,
                                          currency:
                                              currencyMap[selectedCurrency],
                                        );
                                      },
                                    ),
                                  );
                                },
                                cryptoStr: 'Bitcoin',
                                cryptoValue: bitcoinVal,
                                image: Image(
                                  image: AssetImage(
                                    'images/bitcoin.png',
                                  ),
                                  width: 40.0,
                                  height: 40.0,
                                ),
                              ),
                              CoinCard(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return DetailScreen(
                                          title: 'Ethereum',
                                          data: ethereumData,
                                          currency:
                                              currencyMap[selectedCurrency],
                                        );
                                      },
                                    ),
                                  );
                                },
                                cryptoStr: 'Ethereum',
                                cryptoValue: ethereumVal,
                                image: Image(
                                  image: AssetImage(
                                    'images/ethereum.png',
                                  ),
                                  width: 38.0,
                                  height: 38.0,
                                ),
                              ),
                              CoinCard(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return DetailScreen(
                                          title: 'Litecoin',
                                          data: litecoinData,
                                          currency:
                                              currencyMap[selectedCurrency],
                                        );
                                      },
                                    ),
                                  );
                                },
                                cryptoStr: 'Litecoin',
                                cryptoValue: litecoinVal,
                                image: Image(
                                  image: AssetImage(
                                    'images/litecoin.png',
                                  ),
                                  width: 45.0,
                                  height: 45.0,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 120.0,
                alignment: Alignment.center,
                color: Colors.grey[900].withOpacity(0.7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Select currency: ',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    Platform.isIOS ? iOSPicker() : androidDropdown()
                  ],
                ),
              ),
            ],
          ),
        ),
      ];

      if (isLoading) {
        stack.add(
          Container(
            color: Colors.grey[800].withOpacity(0.8),
            child: loadingCircle,
          ),
        );
      }

      return Stack(
        children: stack,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Coin Ticker'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              right: 12.0,
            ),
            child: IconButton(
              icon: Icon(Icons.help),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'Help',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        content: Container(
                          child: Wrap(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                      'Select a currency from the dropdown list near the bottom of the screen to get conversion rates.'),
                                  Divider(color: Colors.white30),
                                  Text(
                                      'Click on a cryptocurrency card for more details.'),
                                  Divider(color: Colors.white30),
                                  Text(
                                      'Pull down on the screen to refresh the current selected currency.'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Close',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      );
                    });
              },
            ),
          )
        ],
      ),
      body: !isError
          ? _buildBodyStack()
          : Container(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Cannot connect to the BitcoinAverage API. Please make sure you have an internet connection, or that your network allows connection to the API.',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
    );
  }
}
