part of 'qrcode_bloc.dart';

abstract class QrcodeEvent extends Equatable {
  const QrcodeEvent();

  List<Object> get propos => [];
}

// SECTION Scan barcode
class GetBarcode implements QrcodeEvent {
  @override
  List<Object> get propos => [];

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}
// !SECTION

class StoreQrcode implements QrcodeEvent {
  final String qrcode;

  StoreQrcode(this.qrcode);

  @override
  List<Object> get propos => [qrcode];

  @override
  List<Object?> get props => [qrcode];

  @override
  bool? get stringify => false;
}

class DeleteQrcode implements QrcodeEvent {
  final Qrcode qrcode;

  DeleteQrcode(this.qrcode);

  @override
  List<Object> get propos => [qrcode];

  @override
  List<Object?> get props => [qrcode];

  @override
  bool? get stringify => false;
}
