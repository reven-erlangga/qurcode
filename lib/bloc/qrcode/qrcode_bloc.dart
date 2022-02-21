// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qurcode/databases/qr/qr_database.dart';
import 'package:qurcode/models/qrcode.dart';

part 'qrcode_event.dart';
part 'qrcode_state.dart';

class QrcodeBloc extends Bloc<QrcodeEvent, QrcodeState> {
  List<Qrcode> _qrCodes = [];

  QrcodeBloc() : super(QrcodeInitial()) {
    on<GetBarcode>((event, emit) {
      _getBarcode();
    });
    on<StoreQrcode>((event, emit) {
      _storeQrcode(event.qrcode);
    });
    on<DeleteQrcode>((event, emit) {
      _deleteQrcode(event.qrcode);
    });
  }

  void _getBarcode() async {
    try {
      emit(Loading());

      _qrCodes = await QrcodeBox().getAllQrcodes();

      emit(QrcodeLoaded(qrCodes: _qrCodes));
    } catch (e) {
      emit(ShowMessage(e.toString()));
    }
  }

  void _storeQrcode(String? barcode) async {
    try {
      emit(Loading());

      if (barcode == null || barcode.isEmpty) {
        emit(ShowMessage('Something error, Barcode is empty'));

        return;
      }

      await QrcodeBox().store(barcode);

      _qrCodes = await QrcodeBox().getAllQrcodes();

      emit(QrcodeLoaded(qrCodes: _qrCodes));
    } catch (e) {
      emit(ShowMessage(e.toString()));
    }
  }

  void _deleteQrcode(Qrcode qrCode) async {
    try {
      emit(Loading());
      await QrcodeBox().delete(qrCode);

      _qrCodes = await QrcodeBox().getAllQrcodes();

      emit(QrcodeLoaded(qrCodes: _qrCodes));
    } catch (e) {
      emit(ShowMessage(e.toString()));
    }
  }
}
/**
 * 

      // final _boxs = await Hive.openBox('qrcodes');
      // var _qrCodes = Hive.box('qrcodes');
      // QRCode _qr = _qrCodes.getAt(0);
      // print(_qr.barcode);
      // print(_boxs.values.toList().cast<QRCode>().first.barcode);
      // Future<Box<QRCode>> _qrCodes = (Hive.openBox<QRCode>('qrcodes'));
      // List<QRCode> _qrCodes =
      //     await Hive.box('qrcodes').values.toList().cast<QRCode>();

      // final _boxs = Boxes.getQrCodesBox().listenable();
      // final _boxs = await Hive.openBox<QRCode>('qrcodes');
      // List<QRCode> _qrCodes = _boxs.values.toList();
 */