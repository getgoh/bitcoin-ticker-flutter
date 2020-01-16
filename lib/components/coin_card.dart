import 'package:flutter/material.dart';

class CoinCard extends StatelessWidget {
  const CoinCard({
    @required this.image,
    @required this.cryptoValue,
    @required this.cryptoStr,
    @required this.selectedCurrency,
    this.onTap,
  });

  final String cryptoValue;
  final String cryptoStr;
  final String selectedCurrency;
  final Image image;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
        decoration: BoxDecoration(
          color: Colors.grey[500].withOpacity(0.3),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(12.0, 12, 18.0, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: this.image,
                    width: 50.0,
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        this.cryptoStr,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                cryptoValue,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
