import 'dart:io';
import 'dart:typed_data';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:printing/printing.dart';
import '../Screens/pdf_view_screen.dart';
import '../Size Config/size_config.dart';
import 'package:flutter/painting.dart';

String globalfilePath = '';

class DownloadVM {
  static DownloadVM instance = DownloadVM._();
  DownloadVM._();

  Future<void> pdfGenerator(
      String name, int donationCount, BuildContext context) async {
    SizeConfig().init(context);
    try {
      final _pdf = pdf.Document();
      //String url = "https://media.istockphoto.com/vectors/elegant-blue-and-gold-diploma-certificate-template-vector-id1128426035?k=20&m=1128426035&s=612x612&w=0&h=IRbCMn_Ueo36GgkQJxxsvsmMdp4JII73KZabuvhJY64=";
      //final _assetImage = await flutterImageProvider(NetworkImage(url));
      final _assetImage =
          await flutterImageProvider(AssetImage("assets/certificate.jpg"));
      // final _assetImage = await pdfImageFromImageProvider(
      //   pdf: _pdf.document,
      //   image: AssetImage(
      //     'assets/images/account.png',
      //   ),
      // );
      _pdf.addPage(
        pdf.Page(
          pageFormat: PdfPageFormat.a4,
          build: (context) => pdf.Center(
            child: pdf.Container(
              margin: pdf.EdgeInsets.all(8),
              width: SizeConfig.blockSizeHorizontal! * 125,
              height: SizeConfig.blockSizeVertical! * 41,
              color: PdfColors.grey,
              child: pdf.Stack(
                children: [
                  pdf.Align(
                      alignment: pdf.Alignment.center,
                      child: pdf.Image(_assetImage)),
                  pdf.Positioned(
                    bottom: SizeConfig.blockSizeVertical! * 16,
                    left: SizeConfig.blockSizeHorizontal! * 6,
                    child: pdf.Text(
                      "$name",
                      style: pdf.TextStyle(
                        fontSize: 12,
                        fontWeight: pdf.FontWeight.bold,
                        color: PdfColors.grey800,
                      ),
                    ),
                  ),
                  pdf.Positioned(
                    bottom: SizeConfig.blockSizeVertical! * 2,
                    right: SizeConfig.blockSizeHorizontal! * 5,
                    child: pdf.Text(
                      "$donationCount",
                      style: pdf.TextStyle(
                        fontSize: 12,
                        fontWeight: pdf.FontWeight.bold,
                        color: PdfColors.grey800,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
      // _pdf.addPage(
      //   pdf.Page(
      //     pageFormat: PdfPageFormat.a4,
      //     build: (context) => pdf.Center(
      //       child: pdf.Container(
      //         margin: pdf.EdgeInsets.all(16),
      //         width: double.maxFinite,
      //         color: PdfColors.deepPurple50,
      //         child: pdf.Column(
      //           mainAxisAlignment: pdf.MainAxisAlignment.center,
      //           crossAxisAlignment: pdf.CrossAxisAlignment.center,
      //           children: [
      //             pdf.SizedBox(
      //               height: 50,
      //             ),
      //             pdf.Container(
      //               width: 360,
      //               height: 360,
      //               decoration: pdf.BoxDecoration(
      //                 shape: pdf.BoxShape.circle,
      //                 color: PdfColors.deepPurple200,
      //               ),
      //               child: pdf.Image(_assetImage),
      //             ),
      //             pdf.SizedBox(
      //               height: 50,
      //             ),
      //             pdf.Text(
      //               'certificate of completion',
      //               style: pdf.TextStyle(
      //                 fontSize: 22,
      //                 color: PdfColors.grey700,
      //               ),
      //             ),
      //             pdf.SizedBox(
      //               height: 20,
      //             ),
      //             pdf.Text(
      //               'presented to:',
      //               style: pdf.TextStyle(
      //                 color: PdfColors.grey600,
      //               ),
      //             ),
      //             pdf.SizedBox(
      //               height: 30,
      //             ),
      //             pdf.Text(
      //               name,
      //               style: pdf.TextStyle(
      //                 fontSize: 24,
      //                 fontWeight: pdf.FontWeight.bold,
      //                 color: PdfColors.grey800,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // );
      //var path = await getApplicationDocumentsDirectory();
      var storagePermission = await Permission.storage.status;

      if (!storagePermission.isGranted) {
        await Permission.storage.request();
      }

      storagePermission = await Permission.storage.status;
      if (storagePermission.isGranted) {
        final String dir = await ExternalPath.getExternalStoragePublicDirectory(
            External.DIRECTORY_DOWNLOADS);
        List<int> list = await _pdf.save();
        final file = File('$dir/$name$donationCount.pdf');
        file.writeAsBytesSync(list.toList());
        globalfilePath = file.path;
        print("global file path------$globalfilePath");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Certificate downloaded"),
          action: SnackBarAction(
            label: 'Show',
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ViewerScreen()));
            },
          ),
        ));
      }
    } catch (e) {
      print(e);
      //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ErrorScreen(error: e.toString(),)));
    }
  }
}
