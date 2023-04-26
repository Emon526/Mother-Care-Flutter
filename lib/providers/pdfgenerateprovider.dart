import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
//Local imports
import '../const/consts.dart';
import '../utils/savepdf_filemobile.dart'
    if (dart.library.html) '../utils/savepdf_fileweb.dart';

class PdfGenerateProvider extends ChangeNotifier {
  Future<void> generateInvoice({
    required String predictionconfidence,
    required String predictionresult,
  }) async {
    final PdfColor pdfColor = PdfColor(255, 128, 171);
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(pdfColor));

    await drawHeader(
        page: page,
        pageSize: pageSize,
        pdfColor: pdfColor,
        headerTitle: Consts.APP_NAME,
        logoUrl: 'assets/logo.png');

    drawPatientInfo(
      page: page,
      pageSize: pageSize,
      reportId: '2058557939',
      patientDetails:
          '''Patient Name: Rima Khan\r\n\r\nAge: 18\r\n\r\nGender: Female
      \r\nAddress: 51/A/3,West Raza Bazar, Dhaka, Bangladesh
       \r\nPhone: 9365550136''',
    );

    drawresult(
      page: page,
      pageSize: pageSize,
      predictionconfidence: predictionconfidence,
      predictionresult: predictionresult,
    );

    drawFooter(
        page: page,
        pageSize: pageSize,
        pdfColor: pdfColor,
        footersize: 60,
        footerTitle: 'Note:',
        footerDescription:
            'Please note that our AI mammography analysis algorithm is designed to assist medical professionals in making diagnostic decisions and is not intended to replace clinical judgment or expertise. It is important for patients to follow up with their healthcare providers to discuss their mammography results and any necessary next steps.');
    //Save the PDF document
    final List<int> bytes = document.saveSync();
    //Dispose the document.
    document.dispose();
    //Save and launch the file.
    await saveAndLaunchFile(bytes, 'MammographyReport.pdf');
  }

  //Draws the invoice header
  Future<void> drawHeader({
    required PdfPage page,
    required Size pageSize,
    required PdfColor pdfColor,
    required String headerTitle,
    required String logoUrl,
  }) async {
    //Draw rectangle
    page.graphics.drawRectangle(
        brush: PdfSolidBrush(pdfColor),
        bounds: Rect.fromLTWH(0, 0, pageSize.width, 90));

    //Draw image
    page.graphics.drawImage(
      PdfBitmap(
        await getImageBytes(logoUrl),
      ),
      const Rect.fromLTWH(0, 0, 90, 90),
    );

    //Draw string
    page.graphics.drawString(
      headerTitle,
      PdfStandardFont(PdfFontFamily.helvetica, 30),
      brush: PdfBrushes.white,
      bounds: Rect.fromLTWH(90, 0, pageSize.width, 90),
      format: PdfStringFormat(
        lineAlignment: PdfVerticalAlignment.middle,
      ),
    );
  }

  Future<PdfLayoutResult> drawPatientInfo({
    required PdfPage page,
    required Size pageSize,
    required String reportId,
    required String patientDetails,
  }) async {
    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);
    //Create data foramt and convert it to text.
    final DateFormat format = DateFormat.yMMMMd('en_US');
    final String reportNumber =
        'Report ID: {$reportId}\r\n\r\nReport Date: ${format.format(DateTime.now())}';
    final Size contentSize = contentFont.measureString(reportNumber);
    // ignore: leading_newlines_in_multiline_strings

    PdfTextElement(text: reportNumber, font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(pageSize.width - (contentSize.width + 30), 120,
            contentSize.width + 30, pageSize.height - 120));

    return PdfTextElement(text: patientDetails, font: contentFont).draw(
      page: page,
      bounds: Rect.fromLTWH(30, 120, pageSize.width - (contentSize.width + 30),
          pageSize.height - 120),
    )!;
  }

  drawresult({
    required PdfPage page,
    required Size pageSize,
    required String predictionconfidence,
    required String predictionresult,
  }) {
    const String title = 'Mammography Analysis Results:';
    final String body =
        'Our AI mammography analysis algorithm has evaluated the mammogram images of the patient\'s breast and identified the following findings:\r\n\r\nFindings: $predictionresult\r\nConfidence Rate: $predictionconfidence\r\n\r\nBased on our analysis, we have identified $predictionresult findings in the patient\'s breast. The confidence rate for this analysis is $predictionconfidence, which indicates the level of certainty that our algorithm has in the accuracy of these findings.\r\n\r\n[If malignant]: It is highly recommended that the patient undergo further diagnostic testing and follow-up with a medical professional as soon as possible to determine the appropriate course of treatment.\r\n\r\n[If benign]: While there are no significant findings that indicate a malignancy at this time, it is still recommended that the patient continues to receive regular mammography screenings as per their healthcare provider\'s recommendations.';
    // page.graphics.drawString(
    //   title,
    //   PdfStandardFont(PdfFontFamily.helvetica, 9),
    //   format: PdfStringFormat(),
    //   bounds: Rect.fromLTWH(
    //     30,
    //     250,
    //     pageSize.width - 50,
    //     0,
    //   ),
    // );
    // page.graphics.drawString(
    //   title,
    //   PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold),
    //   bounds: Rect.fromLTWH(
    //     30,
    //     250,
    //     pageSize.width - 50,
    //     0,
    //   ),
    // );

    final PdfFont contentFont =
        PdfStandardFont(PdfFontFamily.helvetica, 9, style: PdfFontStyle.bold);
    final Size contentSize = contentFont.measureString(title);

    page.graphics.drawString(
      title,
      PdfStandardFont(
        PdfFontFamily.helvetica,
        9,
        // style: PdfFontStyle.bold,
      ),
      format: PdfStringFormat(),
      bounds: Rect.fromLTWH(
        30,
        250,
        pageSize.width - 50,
        0,
      ),
    );
    String footerContent = '$title\r\n\r\n$body';

    //Added 20 as a margin for the layout
    page.graphics.drawString(
      footerContent,
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      format: PdfStringFormat(),
      bounds: Rect.fromLTWH(
        30,
        250,
        pageSize.width - 50,
        0,
      ),
    );
  }

  //Draw the invoice footer data.
  void drawFooter({
    required PdfPage page,
    required Size pageSize,
    required PdfColor pdfColor,
    required int footersize,
    required String footerTitle,
    required String footerDescription,
  }) {
    final PdfPen linePen = PdfPen(pdfColor, dashStyle: PdfDashStyle.custom);
    linePen.dashPattern = <double>[3, 3];
    //Draw line
    page.graphics.drawLine(linePen, Offset(0, pageSize.height - footersize),
        Offset(pageSize.width, pageSize.height - footersize));

    page.graphics.drawString(
      footerTitle,
      PdfStandardFont(
        PdfFontFamily.helvetica,
        9,
        // style: PdfFontStyle.bold,
      ),
      format: PdfStringFormat(),
      bounds: Rect.fromLTWH(
        10,
        pageSize.height - footersize + 15,
        pageSize.width - 20,
        0,
      ),
    );
    String footerContent = '$footerTitle $footerDescription';

    //Added 20 as a margin for the layout
    page.graphics.drawString(
      footerContent,
      PdfStandardFont(PdfFontFamily.helvetica, 9),
      format: PdfStringFormat(),
      bounds: Rect.fromLTWH(
        10,
        pageSize.height - footersize + 15,
        pageSize.width - 20,
        0,
      ),
    );
  }

  Future<List<int>> getImageBytes(String imagePath) async {
    final ByteData imageData = await rootBundle.load(imagePath);
    final Uint8List imageBytes = imageData.buffer.asUint8List();
    return imageBytes.toList();
  }
}
