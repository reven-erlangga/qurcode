part of 'qrcode_bloc.dart';

abstract class QrcodeState extends Equatable {
  const QrcodeState();

  @override
  List<Object> get props => [];
}

class QrcodeInitial extends QrcodeState {}

class Loading implements QrcodeState {
  @override
  List<Object> get props => [];

  @override
  bool? get stringify => false;
}

class BarcodeLoaded implements QrcodeState {
  final List barcode;

  BarcodeLoaded(this.barcode);

  @override
  List<Object> get props => [barcode];

  @override
  bool? get stringify => false;
}

class QrcodeLoaded implements QrcodeState {
  final List<Qrcode> qrCodes;

  QrcodeLoaded({required this.qrCodes});

  @override
  List<Object> get props => [qrCodes];

  @override
  bool? get stringify => false;
}

class ShowMessage implements QrcodeState {
  final String message;

  ShowMessage(this.message);

  @override
  List<Object> get props => [message];

  @override
  bool? get stringify => false;
}
