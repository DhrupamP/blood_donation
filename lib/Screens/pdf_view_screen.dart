import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import '../viewModels/download_viewmodel.dart';

class ViewerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Certificate'),
        ),
        body: PDFView(
          filePath: globalfilePath,
        ));
  }
}
