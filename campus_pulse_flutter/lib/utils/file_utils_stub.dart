import 'dart:typed_data';

class PickedPdf {
  final String name;
  final Uint8List bytes;
  final int size;

  PickedPdf({
    required this.name,
    required this.bytes,
    required this.size,
  });
}

Future<PickedPdf?> pickPdfWeb() async {
  return null;
}

void downloadBytesWeb(Uint8List bytes, String fileName) {}
