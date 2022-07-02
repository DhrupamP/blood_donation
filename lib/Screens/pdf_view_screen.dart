import 'package:flutter/material.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

import '../viewModels/download_viewmodel.dart';

class ViewerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Certificate'),
        ),
        body: PdfView(
          path: globalfilePath,
        ));
  }
}
