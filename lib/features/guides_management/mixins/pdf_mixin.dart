import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:http/http.dart' as http;

mixin PdfMixin {
  Future<void> downloadPdfAndPrint(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    var pdfData = response.bodyBytes;
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdfData);
  }

}
