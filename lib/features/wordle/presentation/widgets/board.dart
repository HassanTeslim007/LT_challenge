import 'package:flutter/material.dart';
import 'package:lt_challenge/features/wordle/data/entities/word.dart';
import 'package:lt_challenge/features/wordle/presentation/widgets/letter_box.dart';

class WordleTiles extends StatefulWidget {
  final List<Word> words;
  const WordleTiles({super.key, required this.words});

  @override
  State<WordleTiles> createState() => _WordleTilesState();
}

class _WordleTilesState extends State<WordleTiles> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: widget.words
            .map((word) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: word.letters
                      .map((letter) => LetterBox(letter: letter))
                      .toList(),
                ))
            .toList());
  }
}

