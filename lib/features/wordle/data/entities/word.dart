import 'package:lt_challenge/features/wordle/data/entities/letter.dart';

class Word {
  final List<Letter> letters;

  Word(this.letters);

  String get wordString => letters.map((e) => e.value).join();

  Word addLetter(String val) {
    int currentIndex = letters.indexWhere((element) => element.value.isEmpty);
    if (currentIndex != -1) {
      letters[currentIndex] = Letter(val);
    }
    return Word(letters);
    
  }

  Word removeLetter() {
    int currentIndex =
        letters.lastIndexWhere((element) => element.value.isNotEmpty);
    if (currentIndex != -1) {
      letters[currentIndex] = Letter.empty();
    }
    return Word(letters);
  }

  @override
  String toString() => '$letters';
}
