import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'dart:typed_data';
import 'package:printing/printing.dart';
import 'package:flutter/material.dart' as mat;

class PdfPage extends StatelessWidget {
  const PdfPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      // header: const PageHeader(title: Text('pdfview.dart')),
      content:
          // use a future builder to load the pdf file from _generatePdf
          // while waiting return a spinner
          FutureBuilder<Uint8List>(
        future: _generatePdf(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PdfPreview(
                allowPrinting: false,
                allowSharing: false,
                canChangeOrientation: false,
                canChangePageFormat: false,
                maxPageWidth: MediaQuery.of(context).size.width * 0.8,
                build: (format) => _generatePdf()); // this is the pdf file
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(child: mat.CircularProgressIndicator());
          }
        },
      ),
      // PdfPreview(
      //   allowPrinting: false,
      //   allowSharing: false,
      //   canChangeOrientation: false,
      //   canChangePageFormat: false,
      //   maxPageWidth: MediaQuery.of(context).size.width * 0.8,
      //   build: (format) => _generatePdf(format),
      // ),
    );
  }

  // create the _generatePdf function for the future builder

  Future<Uint8List> _generatePdf() async {
    // request the pdf path from the MediaModel and then return that as a Uint8List
    const pdfPath =
        '/mnt/public/CoilWinder_InstructionsDisplay/WindingPractices/Documents/Updated/testPdf.pdf';

    return File(pdfPath).readAsBytes();
  }
}
