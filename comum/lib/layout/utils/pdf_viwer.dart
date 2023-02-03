import 'package:comum/constantes.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:internet_file/internet_file.dart';
import 'package:printing/printing.dart';

class PDFViewer extends StatelessWidget {
  const PDFViewer({
    Key? key,
    required this.url,
    this.title = 'Visualização',
  }) : super(key: key);

  final String url;
  final String title;

  Future<Uint8List> loadPDF() => InternetFile.get(url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Cores.azul,
        title: Text(title),
      ),
      body: PdfPreview(
        build: (format) => loadPDF(),
        canDebug: false,
        canChangeOrientation: false,
        canChangePageFormat: false,
      ),
    );
  }
}
