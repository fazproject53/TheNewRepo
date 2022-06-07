
import 'dart:io';
import 'package:flutter/material.dart' as mt;

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'dart:typed_data';


///create pdf document
class PdfClass {
  static Future<File> createPDF(
      String textT, String id, String date, String adType) async {
    final document = Document();
    String title = 'التفاصيل الخاصة بالطلب';
    var arabicFont = Font.ttf(await rootBundle.load("assets/font/Cairo-Regular.ttf"));
    var imageImage = MemoryImage((await rootBundle.load('assets/image/logo.png')).buffer.asUint8List());
    var pathToFile = await rootBundle.load('assets/font/MyFlutterApp.ttf');
    final ttf = Font.ttf(pathToFile);

    document.addPage(Page(
      theme: ThemeData.withFont(
        base: arabicFont,
        icons: ttf,

      ),
      pageFormat: PdfPageFormat.roll80,
      textDirection: TextDirection.rtl,
      build: (Context context) => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    width: 80.w,
                    height: 80.h,
                    child: Image(
                        imageImage
                    )
                )
              ]
            ),
            SizedBox(height: 15.h),
            Text(title, style: TextStyle(fontSize: 10.sp)),
            SizedBox(height: 10.h),
            Padding(
                padding: EdgeInsets.only(right: 20.w),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text( textT, style: TextStyle(fontSize: 10.sp,color: PdfColors.black)),
                        SizedBox(width: 5.w),
                        Icon(IconData(mt.Icons.person.codePoint),
                          color:
                          PdfColors.deepPurple,
                          size: 18,),
                      ]),
                  SizedBox(height: 10.h),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text( id, style: TextStyle(fontSize: 10.sp,color: PdfColors.black)),
                        SizedBox(width: 5.w),
                        // Icon(IconData(ttf.font.index),
                        //   color:
                        //   PdfColors.deepPurple,
                        //   size: 18,),
                      ]),
                  SizedBox(height: 10.h),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text( date, style: TextStyle(fontSize: 10.sp,color: PdfColors.black)),
                        SizedBox(width: 5.w),
                        Icon(IconData(mt.Icons.date_range_outlined.codePoint),
                          color:
                          PdfColors.deepPurple,
                          size: 18,),
                      ]),
                  SizedBox(height: 10.h),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text( adType, style: TextStyle(fontSize: 10.sp,color: PdfColors.black)),
                        SizedBox(width: 5.w),
                        Icon(IconData(mt.Icons.campaign.codePoint),
                          color:
                          PdfColors.deepPurple,
                          size: 18,),
                      ]),
                  SizedBox(height: 10.h),
                ]
              )
            ),
      ]),
    ));

    return saveDocument(name: 'CalenderInfo.pdf', pdf: document);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
