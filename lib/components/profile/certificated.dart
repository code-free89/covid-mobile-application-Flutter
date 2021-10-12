import 'dart:io';

import 'package:covid/components/profile/certificate.dart';
import 'package:covid/components/textbox.dart';
import 'package:covid/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CertificatedWidget extends StatefulWidget {
  final Map<String, dynamic> userData;
  final Map<String, dynamic> dose1Data;
  final Map<String, dynamic> dose2Data;
  final Function onTap;
  const CertificatedWidget(
      {required this.userData,
      required this.dose1Data,
      required this.dose2Data,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  _CertificatedWidgetState createState() => _CertificatedWidgetState();
}

class _CertificatedWidgetState extends State<CertificatedWidget> {
  UserData uData = new UserData();
  @override
  Widget build(BuildContext context) {
    uData.fromJson(widget.userData);
    return Column(
      key: ValueKey(true),
      children: [
        TextBox(
          value: uData.name,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          padding: 10,
        ),
        TextBox(
          value: uData.passportNo,
          fontSize: 20,
          padding: 10,
        ),
        uData.dob != ""
            ? TextBox(
                value: "D.O.B: ${uData.dob}",
                fontSize: 20,
                padding: 10,
              )
            : TextBox(
                value: "D.O.B: ${generateDOB(uData.passportNo)}",
                fontSize: 20,
                padding: 10,
              ),
        CertificatCard(
          title: "Dose 1: ",
          date: uData.dose1_date,
          manufacturer: widget.dose1Data["manufacturer"] ?? "",
          facility: widget.dose1Data["facility"] ?? "",
          batch: widget.dose1Data["batch"] ?? "",
        ),
        SizedBox(height: 15),
        CertificatCard(
          title: "Dose 2: ",
          date: uData.dose2_date,
          manufacturer: widget.dose2Data["manufacturer"] ?? "",
          batch: widget.dose2Data["batch"] ?? "",
          facility: widget.dose2Data["facility"] ?? "",
          isBorder: true,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(
                top: 2,
                left: 8,
                bottom: 2,
                right: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: GestureDetector(
                child: Container(
                  padding: EdgeInsets.only(top: 5, bottom: 2),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage(
                          "assets/images/big-qr.png",
                        ),
                        height: 30,
                      ),
                      SizedBox(height: 5),
                      TextBox(
                        value: "Show QR",
                        fontColor: Colors.black54,
                      )
                    ],
                  ),
                ),
                onTap: () {
                  widget.onTap();
                },
              ),
            ),
            SizedBox(width: 20),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(
                top: 2,
                left: 8,
                bottom: 2,
                right: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: GestureDetector(
                child: Container(
                  padding: EdgeInsets.only(top: 5, bottom: 2),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage(
                          "assets/images/pdf.png",
                        ),
                        height: 30,
                      ),
                      SizedBox(height: 5),
                      TextBox(
                        value: "Generate",
                        fontColor: Colors.black54,
                      )
                    ],
                  ),
                ),
                onTap: generatePDF,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void generatePDF() async {
    try {
      final pdf = pw.Document();

      final logoImage = pw.MemoryImage(
          (await rootBundle.load("assets/images/mosti.png"))
              .buffer
              .asUint8List());
      // final logoImage = pw.(
      //   File('assets/images/images/mosti.png').readAsBytesSync(),
      // );

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4.copyWith(
            marginBottom: 30,
            marginLeft: 30,
            marginRight: 30,
            marginTop: 30,
          ),
          build: (pw.Context context) {
            return pw.Container(
              decoration: const pw.BoxDecoration(
                border: pw.Border(
                  bottom: pw.BorderSide(width: 2, color: PdfColors.black),
                  left: pw.BorderSide(width: 2, color: PdfColors.black),
                  top: pw.BorderSide(width: 2, color: PdfColors.black),
                  right: pw.BorderSide(width: 2, color: PdfColors.black),
                ),
              ),
              padding: pw.EdgeInsets.all(10),
              child: pw.Column(children: [
                pw.Container(
                  decoration: pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(
                        style: pw.BorderStyle.dotted,
                        width: 1,
                      ),
                    ),
                  ),
                  padding: pw.EdgeInsets.only(bottom: 10),
                  child: pw.Row(children: [
                    pw.Container(
                      padding: pw.EdgeInsets.only(right: 10),
                      width: 150,
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Image(logoImage, width: 100),
                            pw.Text("MALAYSIA",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 10)),
                            pw.SizedBox(height: 20),
                            pw.Text("SIJIL DIGITAL",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 10)),
                            pw.Text("VAKSINASI COVID-19",
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 10)),
                            pw.Text(
                                "DIGITAL CERTIFICATE for COVID-19 VACCINATION",
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontStyle: pw.FontStyle.italic,
                                    fontSize: 10)),
                          ]),
                    ),
                    pw.Expanded(
                      child: pw.Container(
                        padding: pw.EdgeInsets.only(left: 10),
                        decoration: pw.BoxDecoration(
                          border: pw.Border(
                            left: pw.BorderSide(
                              style: pw.BorderStyle.dotted,
                              width: 1,
                            ),
                          ),
                        ),
                        child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Container(
                                width: double.infinity,
                                padding: pw.EdgeInsets.all(5),
                                decoration: pw.BoxDecoration(
                                    color: PdfColor.fromHex('#000066')),
                                child: pw.Text(
                                    "MAKLUMAT PENERIMA VAKSIN / VACCINEE DETAILS",
                                    style: pw.TextStyle(
                                      color: PdfColor.fromHex('#FFFFFF'),
                                      fontWeight: pw.FontWeight.bold,
                                      fontSize: 10,
                                    )),
                              ),
                              pw.Container(
                                padding: pw.EdgeInsets.all(5),
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text("Nama / Name",
                                        style: pw.TextStyle(
                                            fontStyle: pw.FontStyle.italic,
                                            fontSize: 10)),
                                    pw.Text(uData.name,
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            fontWeight: pw.FontWeight.bold)),
                                    pw.SizedBox(height: 5),
                                    pw.Text("Warganegara / Nationality",
                                        style: pw.TextStyle(
                                            fontStyle: pw.FontStyle.italic,
                                            fontSize: 10)),
                                    pw.Text(uData.ethnity,
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            fontWeight: pw.FontWeight.bold)),
                                    pw.SizedBox(height: 5),
                                    pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Column(
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.Text(
                                                    "No. Kad Pengenalan / Identity No.",
                                                    style: pw.TextStyle(
                                                        fontStyle:
                                                            pw.FontStyle.italic,
                                                        fontSize: 10)),
                                                pw.Text(
                                                    uData.dob == ""
                                                        ? uData.passportNo
                                                        : "-",
                                                    style: pw.TextStyle(
                                                        fontSize: 10,
                                                        fontWeight: pw
                                                            .FontWeight.bold)),
                                              ]),
                                          pw.Column(
                                              crossAxisAlignment:
                                                  pw.CrossAxisAlignment.start,
                                              children: [
                                                pw.Text(
                                                    "No. Pasport / Passport No.",
                                                    style: pw.TextStyle(
                                                        fontStyle:
                                                            pw.FontStyle.italic,
                                                        fontSize: 10)),
                                                pw.Text(
                                                    uData.dob == ""
                                                        ? "-"
                                                        : uData.passportNo,
                                                    style: pw.TextStyle(
                                                        fontSize: 10,
                                                        fontWeight: pw
                                                            .FontWeight.bold)),
                                              ]),
                                        ]),
                                    pw.SizedBox(height: 5),
                                    pw.Text("Tarikh Lahir / Date of Birth",
                                        style: pw.TextStyle(
                                            fontStyle: pw.FontStyle.italic,
                                            fontSize: 10)),
                                    pw.Text(
                                        uData.dob != ""
                                            ? uData.dob
                                            : generateDOB(uData.passportNo),
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            fontWeight: pw.FontWeight.bold)),
                                    pw.SizedBox(height: 5),
                                    pw.Text(
                                        "Kementerian Berkuasa / Authority Ministry",
                                        style: pw.TextStyle(
                                            fontStyle: pw.FontStyle.italic,
                                            fontSize: 10)),
                                    pw.Text(
                                        "KEMENTERIAN KESIHATAN (MINISTRY OF HEALTH)",
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            fontWeight: pw.FontWeight.bold)),
                                    pw.SizedBox(height: 5),
                                    pw.Text(
                                        "Negara Pengeluar / Issuing Country",
                                        style: pw.TextStyle(
                                            fontStyle: pw.FontStyle.italic,
                                            fontSize: 10)),
                                    pw.Text("MALAYSIA",
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            fontWeight: pw.FontWeight.bold)),
                                    pw.SizedBox(height: 5),
                                    pw.Text("Tarikh Dikeluarkan / Date Issued",
                                        style: pw.TextStyle(
                                            fontStyle: pw.FontStyle.italic,
                                            fontSize: 10)),
                                    pw.Text(generateCurrentDate(),
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            fontWeight: pw.FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ]),
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  children: [
                    pw.Text(
                      "MAKLUMAT VAKSINASI / ",
                      style: pw.TextStyle(
                        color: PdfColor.fromHex('#000066'),
                        fontSize: 15,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      "VACCINATION DETAILS",
                      style: pw.TextStyle(
                        color: PdfColor.fromHex('#006600'),
                        fontSize: 15,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                pdfVaccineWidget(
                    1,
                    uData,
                    widget.dose1Data["facility"],
                    widget.userData["dose1"],
                    widget.dose1Data["manufacturer"],
                    widget.dose1Data["batch"]),
                pdfVaccineWidget(
                    2,
                    uData,
                    widget.dose2Data["facility"],
                    widget.userData["dose2"],
                    widget.dose2Data["manufacturer"],
                    widget.dose2Data["batch"]),
              ]),
            );
          },
        ),
      );

      Directory? directory = await getExternalStorageDirectory();
      print(directory!.path);
      final file = File(
          "/storage/emulated/0/Download/vaccination_${uData.passportNo}.pdf");
      await file.create();
      print(await pdf.save());
      file.writeAsBytesSync(await pdf.save());
      print("pdf saved");
    } catch (e) {
      print("error => $e");
    }
  }

  String generateDOB(String date) {
    int year = int.parse(date.substring(0, 2));
    int month = int.parse(date.substring(2, 4));
    int day = int.parse(date.substring(4, 6));
    DateTime now = DateTime(year < 30 ? year + 2000 : year + 1900, month, day);
    var formatter = new DateFormat("dd MMMM yyyy");
    date = formatter.format(now);
    return date;
  }

  String generateCurrentDate() {
    DateTime now = DateTime.now();
    var formatter = new DateFormat("dd MMMM yyyy");
    String date = formatter.format(now);
    return date;
  }

  pw.Widget pdfVaccineWidget(int doseNum, UserData uData, String facility,
      String vaccineName, String manufacturer, String batchNo) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return pw.Container(
        margin: pw.EdgeInsets.only(top: 15),
        child: pw.Row(
          children: [
            pw.Column(children: [
              pw.Row(children: [
                pw.Text("Dose $doseNum ",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 12,
                        fontStyle: pw.FontStyle.italic)),
                pw.Text("of 2", style: pw.TextStyle(fontSize: 12)),
              ]),
              pw.Container(
                padding: pw.EdgeInsets.all(15),
                margin: pw.EdgeInsets.only(right: 10),
                decoration: pw.BoxDecoration(border: pw.Border.all(width: 1)),
                child: pw.BarcodeWidget(
                  color: PdfColor.fromHex("#000000"),
                  barcode: pw.Barcode.qrCode(),
                  data:
                      "https://sejahtera-bea87.web.app/digital-certificate/$uid/1",
                  width: 120,
                  height: 120,
                ),
              )
            ]),
            pw.Expanded(
              child: pw.Container(
                decoration:
                    pw.BoxDecoration(color: PdfColor.fromHex('#B1C1CC')),
                padding: pw.EdgeInsets.all(8),
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Tarikh Divaksin / Date of Vaccination",
                          style: pw.TextStyle(
                              fontStyle: pw.FontStyle.italic, fontSize: 10)),
                      pw.Text(
                          doseNum == 1
                              ? uData.dose1_date.split(" ")[0]
                              : uData.dose2_date.split(" ")[0],
                          style: pw.TextStyle(
                              fontSize: 10, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 5),
                      pw.Text("Pusat Pemberian Vaksin / Vaccination Center",
                          style: pw.TextStyle(
                              fontStyle: pw.FontStyle.italic, fontSize: 10)),
                      pw.Text(facility,
                          style: pw.TextStyle(
                              fontSize: 10, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 5),
                      pw.Text("Nama Produk / Product name",
                          style: pw.TextStyle(
                              fontStyle: pw.FontStyle.italic, fontSize: 10)),
                      pw.Text(
                          "CoronaVac Suspension for Injection SARS-CoV-2 Vaccine (Vero Cell), Inactivated",
                          style: pw.TextStyle(
                              fontSize: 10, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 5),
                      pw.Text("Nama Umum / Common Name",
                          style: pw.TextStyle(
                              fontStyle: pw.FontStyle.italic, fontSize: 10)),
                      pw.Text("Sinovac",
                          style: pw.TextStyle(
                              fontSize: 10, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 5),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                            width: 150,
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("Pengeluar / Manufacturer",
                                    style: pw.TextStyle(
                                        fontStyle: pw.FontStyle.italic,
                                        fontSize: 10)),
                                pw.Text(manufacturer,
                                    style: pw.TextStyle(
                                        fontSize: 10,
                                        fontWeight: pw.FontWeight.bold)),
                              ],
                            ),
                          ),
                          pw.Container(
                            width: 150,
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("Jenis Vaksin / Vaccine Type",
                                    style: pw.TextStyle(
                                        fontStyle: pw.FontStyle.italic,
                                        fontSize: 10)),
                                pw.Text(
                                    "COVID-19 vaccine, non-replicating viral vector",
                                    style: pw.TextStyle(
                                        fontSize: 10,
                                        fontWeight: pw.FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text("No. Lot / Batch No.",
                          style: pw.TextStyle(
                              fontStyle: pw.FontStyle.italic, fontSize: 10)),
                      pw.Text(batchNo,
                          style: pw.TextStyle(
                              fontSize: 10, fontWeight: pw.FontWeight.bold)),
                    ]),
              ),
            ),
          ],
        ));
  }
}
