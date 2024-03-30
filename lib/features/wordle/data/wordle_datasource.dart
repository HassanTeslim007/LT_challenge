import 'dart:math';

import 'package:english_words/english_words.dart';

class WordleDataSource {
  List<String> fiveLetterWords = [
    ...all.where((word) => word.length == 5).toList(),
    ...all.where((word) => word.length == 4).map((e) => '${e}s').toList()
  ];

  Future<String> generateWord() async {
    int randomIndex = Random().nextInt(fiveLetterWords.length);
    return Future.value(fiveLetterWords[randomIndex].toUpperCase());
  }

  Future<bool> doesWordExist(String word) async {
    return fiveLetterWords.contains(word.toLowerCase());
  }

  Future<bool> checkWord(
      {required String guessedWord, required String generatedWord}) async {
    return guessedWord == generatedWord;
  }
}
