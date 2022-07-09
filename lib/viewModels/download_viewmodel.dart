import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
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
      final _assetImage =
          await flutterImageProvider(AssetImage("assets/certificate.jpg"));

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
      var storagePermission = await Permission.storage.status;
      if (!storagePermission.isGranted) {
        await Permission.storage.request();
      }
      storagePermission = await Permission.storage.status;
      if (storagePermission.isGranted) {
        final d = await getExternalStorageDirectory();
        final dir = d!.path;

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
    }
  }
}
