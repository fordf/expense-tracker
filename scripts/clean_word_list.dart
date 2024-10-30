import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:path/path.dart' as path;

class FileExistsException implements Exception {
  String cause;
  FileExistsException(this.cause);
}

void main() async {
  final writeFilePath =
      path.join(path.dirname(path.current), 'assets', 'words.txt');
  final writeFile = File(writeFilePath);
  try {
    if (writeFile.existsSync()) {
      throw (FileExistsException('File $writeFilePath already exists.'));
    }
    final readFilePath = path.join(path.current, 'words_alpha.txt');
    final readFile = File(readFilePath);
    var sink = writeFile.openWrite();

    Stream<String> words = readFile
        .openRead()
        .transform(utf8.decoder)
        .transform(const LineSplitter());

    await for (var word in words) {
      if (word.length > 3) {
        sink.writeln(word);
      }
    }
    await sink.flush();
    await sink.close();
  } on FileExistsException catch (e) {
    print(e.cause);
    rethrow;
  } on PathNotFoundException {
    writeFile.deleteSync();
    rethrow;
  } catch (e) {
    print('Error: $e');
    rethrow;
  }
}
