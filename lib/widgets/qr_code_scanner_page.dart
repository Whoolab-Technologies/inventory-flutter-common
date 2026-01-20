import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QRCodeScannerPage extends StatefulWidget {
  const QRCodeScannerPage({super.key, required this.onDecode});
  final Function(String decodedString) onDecode;
  @override
  State<StatefulWidget> createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String qrText = 'Scan a QR Code';
  bool _showReloadButton = false;
  bool _isProcessingScan = false;
  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
  }

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Create an animation controller for scanning effect
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    double width = 250;

    return Scaffold(
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            // overlay: QrScannerOverlayShape(),
          ),

          //  Overlay with a transparent square at the center
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.black.withOpacity(0.6),
                    // color: _showReloadButton
                    //     ? Colors.white
                    //     : Colors.black.withOpacity(0.6),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: width,
                        color: Colors.black.withOpacity(0.6),
                        // color: _showReloadButton
                        //     ? Colors.white
                        //     : Colors.black.withOpacity(0.6),
                      ),
                    ),
                    (_showReloadButton)
                        ? Container(
                            width: width,
                            height: width,
                            color: Colors.grey.withOpacity(0.6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  style: ButtonStyle(
                                    minimumSize: WidgetStateProperty.all(
                                        Size(75.w, 75.w)),
                                    backgroundColor: WidgetStateProperty.all(
                                        Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.3)),
                                  ),
                                  onPressed: _restartScanner,
                                  icon: Icon(
                                    Icons.replay_outlined,
                                    color: Colors.white,
                                    size: 45.sp,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ScannerSection(width: width, animation: _animation),
                    Expanded(
                      child: Container(
                        height: width,
                        color: Colors.black.withOpacity(0.6),
                        // color: _showReloadButton
                        //     ? Colors.white
                        //     : Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.black.withOpacity(0.6),
                    // color: _showReloadButton
                    //     ? Colors.white
                    //     : Colors.black.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),

          // // Text showing scanned QR code
          // Positioned(
          //   bottom: 50,
          //   left: 0,
          //   right: 0,
          //   child: Center(
          //     child: Container(
          //       padding: EdgeInsets.all(10.w),
          //       color: Colors.black54,
          //       child: Text(
          //         qrText,
          //         style: TextStyle(color: Colors.white, fontSize: 18.sp),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) async {
      if (_isProcessingScan) return;
      _isProcessingScan = true;

      await controller.pauseCamera();
      _animationController.stop();

      if (!mounted) return;

      setState(() {
        _showReloadButton = true;
        qrText = scanData.code ?? 'No Data';
      });

      widget.onDecode(scanData.code ?? "-1");
    });
  }

  void _restartScanner() {
    _isProcessingScan = false; // 👈 allow scanning again

    _animationController.reset();
    _animationController.forward();

    setState(() {
      _showReloadButton = false;
      qrText = 'Scan a QR Code';
    });

    controller?.resumeCamera();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class ScannerSection extends StatelessWidget {
  const ScannerSection({
    super.key,
    required this.width,
    required Animation<double> animation,
  }) : _animation = animation;

  final double width;
  final Animation<double> _animation;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: width,
          height: width,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            color: Colors.transparent,
          ),
        ),

        // Animated scanning line
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Align(
                alignment: Alignment(
                    0, _animation.value * 2 - 1), // Moves from top to bottom
                child: Container(
                  width: width,
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green, Colors.green.withOpacity(0)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
