part of 'widgets.dart';

class QrcodeCard extends StatelessWidget {
  final Qrcode qrcode;
  final VoidCallback onTap;

  const QrcodeCard({Key? key, required this.qrcode, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd-MM-yyyy kk:mm');
    String _createdAt = dateFormat.format(qrcode.createdAt);

    return SwipeableTile(
      color: const Color.fromARGB(255, 255, 255, 255),
      direction: SwipeDirection.horizontal,
      onSwiped: (direction) {
        onTap();
      },
      backgroundBuilder: (context, direction, progress) {
        // You can animate background using the progress
        return AnimatedBuilder(
          animation: progress,
          builder: (context, child) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              color: progress.value > 0.4 ? redColor : blueColor,
            );
          },
        );
      },
      key: UniqueKey(),
      child: InkWell(
        onTap: () {
          Clipboard.setData(ClipboardData(text: qrcode.barcode));

          _showToast(context);
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      child: Stack(
                        children: const [
                          Icon(
                            Icons.qr_code,
                            size: 30,
                            color: Colors.blueAccent,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        qrcode.barcode,
                        style: blackTextStyle.copyWith(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: edge,
                      ),
                      Text(
                        (_createdAt),
                        style: grayTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);

    scaffold.showSnackBar(
      SnackBar(
        content: Text("Copy ${qrcode.barcode}"),
      ),
    );
  }
}
/**
 * 
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: SizedBox(
            height: 100,
            child: Stack(
              children: const [
                Icon(
                  Icons.qr_code,
                  size: 30,
                  color: Colors.blueAccent,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: edge,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              qrcode.barcode,
              style: blackTextStyle.copyWith(
                  fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: edge,
            ),
            Text(
              (_createdAt),
              style: grayTextStyle,
            ),
          ],
        ),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
                onTap: () {},
                child: Container(
                  height: edge / .6,
                  color: Colors.red,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.delete,
                        size: edge / 1.2,
                        color: Colors.white,
                      ),
                      Text(
                        "Delete",
                        style: whiteTextStyle.copyWith(fontSize: 18),
                      )
                    ],
                  ),
                )),
          ],
        ))
      ],
    );
 */