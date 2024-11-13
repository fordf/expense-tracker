import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

void main(List<String> args) {
  final readFilePath = path.join(path.current, '2of12id.json');
  final writeFilePath =
      path.join(path.dirname(path.current), 'assets', 'categorized_words.json');
  writeTrimmedCategorizedWords(
    readFilePath: readFilePath,
    writeFilePath: writeFilePath,
  );
}

void writeTrimmedCategorizedWords(
    {required readFilePath, required writeFilePath}
  ) {
    final readFile = File(readFilePath);
    final writeFile = File(writeFilePath);

    Map<String, dynamic> readWords = jsonDecode(readFile.readAsStringSync());

    final Map<String, dynamic> trimmedWords = {
      'noun': readWords['N'],
      'verb': readWords['V'],
      'adjective': <String>[],
      'adverb': <String>[],
    };

    trimmedWords['verb']!.removeWhere((verb) => !verb.endsWith('ing'));

    for (final (word as String) in readWords['A']) {
      if (word.endsWith('ly')) {
        trimmedWords['adverb']!.add(word);
      } else {
        trimmedWords['adjective']!.add(word);
      }
    }

    writeFile.writeAsStringSync(jsonEncode(trimmedWords));
  }
