import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeInlinePage extends StatefulWidget {
  const NativeInlinePage({Key key}) : super(key: key);

  @override
  _NativeInlinePageState createState() => _NativeInlinePageState();
}

class _NativeInlinePageState extends State<NativeInlinePage> {
  static final _kAdIndex = 4;
  NativeAd _ad;
  bool _isAdLoaded = false;
  List<Object> itemList = [];

  int _getDestinationItemIndex(int rawIndex) {
    if (rawIndex >= _kAdIndex && _isAdLoaded) {
      return rawIndex - 1;
    }
    return rawIndex;
  }

  @override
  void initState() {
    super.initState();

    _ad = NativeAd(
      adUnitId: NativeAd.testAdUnitId,
      factoryId: 'listTile',
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    _ad.load();

    for (int i = 1; i <= 20; i++) {
      itemList.add("Row $i");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: itemList.length + (_isAdLoaded ? 1 : 0),
        itemBuilder: (context, index) {
          if (_isAdLoaded && index == _kAdIndex) {
            return Container(
              child: AdWidget(ad: _ad),
              height: 72.0,
              alignment: Alignment.center,
            );
          } else {
            final item = itemList[_getDestinationItemIndex(index)] as String;

            return ListTile(
              leading: Image.network(
                "https://yt3.ggpht.com/ytc/AAUvwngCFWXwDeTNeaK90xUg0XsfyngQncGt0ehsAc6yCQ",
              ),
              title: Text(
                item,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text("Test Description"),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _ad.dispose();

    super.dispose();
  }
}
