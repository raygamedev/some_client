import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerWidget extends StatefulWidget {
  final Function(Barcode, int) onBarcodeScan;
  const BarcodeScannerWidget({super.key, required this.onBarcodeScan});

  @override
  State<BarcodeScannerWidget> createState() => _BarcodeScannerWidgetState();
}

class _BarcodeScannerWidgetState extends State<BarcodeScannerWidget> {
  double _getScreenHeight() => MediaQuery.of(context).size.height;
  double _getScreenWidth() => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20)),
      child: SizedBox(
          height: _getScreenHeight() * 0.4,
          width: _getScreenWidth() * 0.8,
          child: MobileScanner(
              allowDuplicates: false,
              onDetect: (barcode, args) => widget.onBarcodeScan(barcode, 1))),
    );
  }
}
