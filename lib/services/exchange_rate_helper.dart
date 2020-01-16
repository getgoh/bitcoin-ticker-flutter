import 'package:bitcoin_ticker/services/networking.dart';

class ExchangeRateHelper {
  String url = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/';

  Future getBitcoinDataBySymbol(String symbol) async {
    var data = await NetworkHelper().getData('${url}BTC$symbol');
    return data;
  }

  Future getEthereumDataBySymbol(String symbol) async {
    var data = await NetworkHelper().getData('${url}ETH$symbol');
    return data;
  }

  Future getLitecoinDataBySymbol(String symbol) async {
    var data = await NetworkHelper().getData('${url}LTC$symbol');
    return data;
  }
}
