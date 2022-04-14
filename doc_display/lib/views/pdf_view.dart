// ignore_for_file: avoid_print

import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

// import 'package:printing/printing.dart';

class PdfPage extends StatelessWidget {
  const PdfPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Center(
        child: PdfView(path: 'assets/testPdf.pdf')
      )
    );      
  }
}

     



// Future<Uint8List> _generatePdf(PdfPageFormat format) async {
//   // request the pdf path from the MediaModel and then return that as a Uint8List
//   const pdfPath =
//       '/mnt/public/CoilWinder_InstructionsDisplay/WindingPractices/Documents/Updated/testPdf.pdf';

//   return File(pdfPath).readAsBytes();
// }
