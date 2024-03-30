import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lt_challenge/features/search/data/datasource/remote_datasource.dart';
import 'package:lt_challenge/features/search/data/repository/search_repository_impl.dart';
import 'package:lt_challenge/features/search/presentation/bloc/search_bloc.dart';
import 'package:lt_challenge/features/search/presentation/views/search.dart';
import 'package:lt_challenge/features/wordle/data/wordle_datasource.dart';
import 'package:lt_challenge/features/wordle/presentation/bloc/wordle_bloc.dart';
import 'package:lt_challenge/features/wordle/presentation/views/wordle.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            //should use GetIt or other DI
            create: (_) => SearchBloc(
                searchRepository:
                    SearchRepositoryImpl(SearchDataSourceImpl(http.Client())))),
        BlocProvider(
            create: (_) =>
                WordleBloc(WordleDataSource())..add(GenerateRandomWordEvent()))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Home(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool hasInternet = false;
  late StreamSubscription internetSubscription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
            stream: InternetConnectionChecker().onStatusChange,
            builder: (context, snapshot) {
              if (snapshot.data == InternetConnectionStatus.disconnected) {
                return const Wordle();
              } else {
                return const SearchVideos();
              }
            }),
      ),
    );
  }
}
