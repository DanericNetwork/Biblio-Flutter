import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';


class BarcodeScanner {
  String _scanBarcode = '';
  
  Future<void> scanBarcodeNormal() async {
    try {
      _scanBarcode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print('Barcode of book: ${_scanBarcode}');
    } on PlatformException {
      _scanBarcode = 'Failed to get platform version.';
    }
  }

  String getBarcode() {
    return _scanBarcode;
  }
}