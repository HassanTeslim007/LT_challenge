import 'dart:math';

class WordleDataSource {
 final List<String> fiveLetterWords;

  WordleDataSource({required this.fiveLetterWords});

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
