import 'package:hive/hive.dart';

part 'qrcode.g.dart';

@HiveType(typeId: 0)
class Qrcode extends HiveObject {
  @HiveField(0)
  late String barcode;

  @HiveField(1)
  late DateTime createdAt;
}
