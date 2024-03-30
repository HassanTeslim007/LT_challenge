import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lt_challenge/core/shared/spacer.dart';
import 'package:lt_challenge/core/utils/utils.dart';
import 'package:lt_challenge/features/wordle/data/entities/letter.dart';
import 'package:lt_challenge/features/wordle/presentation/bloc/wordle_bloc.dart';
import 'package:lt_challenge/features/wordle/presentation/widgets/board.dart';
import 'package:lt_challenge/features/wordle/presentation/widgets/keyboard.dart';

class Wordle extends StatefulWidget {
  const Wordle({super.key});

  @override
  State<Wordle> createState() => _WordleState();
}

class _WordleState extends State<Wordle> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        showSnackBar(
          context,
          message: 'No Internet Connection',
        );
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<WordleBloc>();
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 128, 128, 185),
        body: BlocConsumer<WordleBloc, WordleState>(
          listener: (context, state) {
            String word = bloc.currentWord?.wordString ?? '';

            if (state is WordleError) {
              showSnackBar(context, message: state.error);
            }
            if (state is WordleSuccess) {
              context.read<WordleBloc>().add(UpdateKeysEvent(word));
            }
          },
          builder: (context, state) {
            return SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const Text(
                    'WORDLE',
                    style: TextStyle(fontSize: 48, color: Colors.white),
                  ),
                  WordleTiles(words: bloc.words),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outlined,
                        color: Colors.red,
                        size: 30,
                      ),
                      xSpace(20),
                      const Expanded(
                        child: Text(
                            'No internet Connection. We\'ll take you back to surf videos once you have a connection'),
                      )
                    ],
                  ),
                  ySpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Wins: ${bloc.wins}',
                        style: const TextStyle(fontSize: 24),
                      ),
                      Text(
                        'Losses: ${bloc.losses}',
                        style: const TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CustomKeyboard(
                      onKeyPressed: (key) {
                        setState(() {
                          bloc.currentWord?.addLetter(key);
                        });
                      },
                      onBackPressed: () {
                        setState(() {
                          bloc.currentWord?.removeLetter();
                        });
                      },
                      onEnterPressed: () async {
                        if (bloc.status == GameStatus.over) {
                          setState(() {
                            bloc.add(PlayAgainEvent());
                          });
                          return;
                        }
                        String word = bloc.currentWord!.wordString;
                        if (bloc.currentWord!.letters
                            .contains(Letter.empty())) {
                          showSnackBar(context, message: 'Word Incomplete');
                          return;
                        }
                        context.read<WordleBloc>().add(CheckWordEvent(
                            bloc.randomWord, word.toLowerCase()));
                        Future.delayed(const Duration(seconds: 1));
                        if (word == bloc.randomWord) {
                          bloc.wins += 1;
                          await showAlertDialog(
                            context,
                            title: 'Congratulations, You win',
                            body: ySpace(1),
                            okTitle: 'Play Again',
                            okPressed: () {
                              bloc.add(PlayAgainEvent());
                              Navigator.pop(context);
                              setState(() {});
                            },
                            withButton: true,
                          );
                          return;
                        }
                        if (bloc.currentIndex == 5) {
                          bloc.losses += 1;
                          if (word != bloc.randomWord) {
                            bloc.status = GameStatus.over;
                            await showAlertDialog(
                              context,
                              title: 'Sorry, You lose',
                              body: Text('Correct Word is ${bloc.randomWord}'),
                              okTitle: 'Play Again',
                              okPressed: () {
                                bloc.add(PlayAgainEvent());
                                Navigator.pop(context);
                                setState(() {});
                              },
                              withButton: true,
                            );
                          }
                          return;
                        }
                      },
                      pressedKeys: bloc.pressedKeys)
                ],
              ),
            ));
          },
        ));
  }
}
