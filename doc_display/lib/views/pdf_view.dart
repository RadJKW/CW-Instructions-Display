import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PdfPage extends StatelessWidget {
  const PdfPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      // header: const PageHeader(title: Text('pdfview.dart')),
      content: PdfPreview(
        allowPrinting: false,
        allowSharing: false,
        canChangeOrientation: false,
        canChangePageFormat: false,
        maxPageWidth: MediaQuery.of(context).size.width * 0.8,
        build: (format) => _generatePdf(format),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    // request the pdf path from the MediaModel and then return that as a Uint8List
    const pdfPath =
        '/mnt/public/CoilWinder_InstructionsDisplay/WindingPractices/Documents/Updated/testPdf.pdf';

    return File(pdfPath).readAsBytes();
  }
}
