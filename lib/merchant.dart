import 'package:flutter/material.dart';
import 'package:some_client/barcodescanner.dart';

class MerchantWidget extends StatefulWidget {
  final String merchantId;
  const MerchantWidget({super.key, required this.merchantId});

  @override
  State<MerchantWidget> createState() => _MerchantWidgetState();
}

class _MerchantWidgetState extends State<MerchantWidget> {
  static const colors = <Color>[
    Color(0xFFEAAB7E),
    Color(0xFFA25E58),
    Color(0xFF7F946C),
    Color(0xFFCFC4AC),
    Color(0xFF9EA779),
    Color(0xFF7B9091),
    Color(0xFFAA9664),
    Color(0xFFBBA6BE),
    Color(0xFFCA9C97),
  ];
  bool _isCameraOpen = false;
  void _openCamera() {
    setState(() {
      _isCameraOpen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50.0, left: 10.0),
            child: IconButton(
                onPressed: () => {},
                icon: const Icon(
                  Icons.house_rounded,
                  color: Colors.grey,
                  size: 55,
                )),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50.0, right: 35.0),
            child: IconButton(
                onPressed: () => {},
                icon: const Icon(
                  Icons.my_library_books_rounded,
                  color: Colors.grey,
                  size: 50,
                )),
          ),
        ),
        const Positioned(
            child: Padding(
          padding: EdgeInsets.only(top: 100.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Image(
                width: 300,
                fit: BoxFit.contain,
                image: AssetImage('assets/images/nahatLogo.png')),
          ),
        )),
        // CardWidget(onMarkTap: _openCamera),
        if (_isCameraOpen)
          const Positioned(child: Center(child: BarcodeScannerWidget(onBarcodeScan: ,))),
      ],
    );
  }
}
