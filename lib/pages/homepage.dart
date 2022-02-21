import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qurcode/bloc/qrcode/qrcode_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:qurcode/pages/empty_page.dart';
import 'package:qurcode/theme/theme.dart';
import 'package:qurcode/widgets/widgets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final QrcodeBloc _qrcodeBloc = QrcodeBloc();
  late String result = "-";

  @override
  void initState() {
    _qrcodeBloc.add(GetBarcode());
    super.initState();
  }

  @override
  void dispose() {
    _qrcodeBloc.close();
    Hive.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              primary: true,
              child: ListView(
                primary: false,
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: size.height / edge,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: edge),
                    child: Text(
                      'Qurcode',
                      style: blackTextStyle.copyWith(fontSize: 24.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: edge),
                    child: Text(
                      'Scan QR code to get the result!',
                      style: grayTextStyle.copyWith(fontSize: 16.0),
                    ),
                  ),
                  // !SECTION

                  SizedBox(
                    height: size.height / edge,
                  ),
                  BlocBuilder<QrcodeBloc, QrcodeState>(
                    bloc: _qrcodeBloc,
                    builder: (context, state) {
                      if (state is Loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is QrcodeLoaded) {
                        if (state.qrCodes.isEmpty) {
                          return const EmptyPage();
                        }

                        return ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: state.qrCodes.length,
                            itemBuilder: (_, index) {
                              return QrcodeCard(
                                qrcode: state.qrCodes[index],
                                onTap: () {
                                  _qrcodeBloc
                                      .add(DeleteQrcode(state.qrCodes[index]));
                                },
                              );
                            });
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            )),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _scan();
        },
        label: Row(
          children: [
            const Icon(Icons.qr_code),
            const SizedBox(width: 10),
            Text(
              'Scan',
              style: whiteTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  Future _scan() async {
    await Permission.camera.request();
    String? barcode = await scanner.scan();

    _qrcodeBloc.add(StoreQrcode(barcode!));
  }
}
