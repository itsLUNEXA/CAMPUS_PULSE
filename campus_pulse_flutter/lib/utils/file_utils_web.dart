// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:async';
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
  final completer = Completer<PickedPdf?>();
  final input = html.FileUploadInputElement()..accept = '.pdf,application/pdf';
  input.click();

  input.onChange.listen((e) {
    final files = input.files;
    if (files == null || files.isEmpty) {
      if (!completer.isCompleted) completer.complete(null);
      return;
    }
    final file = files[0];
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    reader.onLoadEnd.listen((e) {
      final result = reader.result;
      if (result is Uint8List) {
        if (!completer.isCompleted) {
          completer.complete(
            PickedPdf(name: file.name, bytes: result, size: file.size),
          );
        }
      } else if (result is ByteBuffer) {
        if (!completer.isCompleted) {
          completer.complete(
            PickedPdf(
              name: file.name,
              bytes: result.asUint8List(),
              size: file.size,
            ),
          );
        }
      } else {
        if (!completer.isCompleted) completer.complete(null);
      }
    });
    reader.onError.listen((e) {
      if (!completer.isCompleted) completer.complete(null);
    });
  });

  return completer.future;
}

void downloadBytesWeb(Uint8List bytes, String fileName) {
  final blob = html.Blob([bytes], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);
  html.AnchorElement(href: url)
    ..setAttribute('download', fileName)
    ..click();
  html.Url.revokeObjectUrl(url);
}
