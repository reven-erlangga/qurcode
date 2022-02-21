import 'package:hive/hive.dart';

import 'dart:async';

import 'package:qurcode/models/qrcode.dart';

class QrcodeBox {
  final String _boxName = "qrcodes";

  // open a box
  Future<Box> qrBox() async {
    var box = await Hive.openBox<Qrcode>(_boxName);

    return box;
  }

  // get full note
  Future<List> getFullQrCodes() async {
    final box = await qrBox();
    List qrCodes = box.values.toList();

    return qrCodes;
  }

  Future<List<Qrcode>> getAllQrcodes() async {
    final _box = await qrBox();

    return _box.values.toList().cast<Qrcode>();
  }

  Future store(String barcode) async {
    final _box = await qrBox();

    final qrcode = Qrcode()
      ..barcode = barcode
      ..createdAt = DateTime.now();

    _box.add(qrcode);
  }

  Future delete(Qrcode qrcode) async {
    final _box = await qrBox();

    _box.delete(qrcode.key);
  }
}
