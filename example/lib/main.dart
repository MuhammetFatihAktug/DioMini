// ignore_for_file: avoid_print

import 'package:dio_mini/dio_mini.dart';
import 'package:example/students_model.dart';
import 'package:flutter/material.dart';
import 'elevated_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(),
      ),
      home: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  DioMini service = DioMini(
      model: StudentsModel(),
      baseURL:
          'https://flutter-akademi-f1ca7-default-rtdb.europe-west1.firebasedatabase.app');

  getData() async {
    final result =
        await service.getData('users', '4');
    print(result?['name']);
  }

  getDataList() async {
    final result =
        await service.getDataList('users');
    print(result);
  }

  postData() async {
    await service.postData('newUsers')
        ? print('Correct')
        : print('NoCorrect');
  }

  putData() async {
    await service.putData('5', 'users')
        ? print('Correct')
        : print('NoCorrect');
  }

  deleteData() async {
    await service.deleteData('5', 'users')
        ? print('Correct')
        : print('NoCorrect');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButtonView(
                  onPressed: getData,
                  child: const Text(
                      'Get Data Section'),
                ),
              ),
              Expanded(
                child: ElevatedButtonView(
                  onPressed: getDataList,
                  child: const Text(
                      'Get Data List Section'),
                ),
              ),
              Expanded(
                child: ElevatedButtonView(
                  onPressed: postData,
                  child: const Text(
                      'Post Data Section'),
                ),
              ),
              Expanded(
                child: ElevatedButtonView(
                  onPressed: putData,
                  child: const Text(
                      'Put Data Section'),
                ),
              ),
              Expanded(
                child: ElevatedButtonView(
                  onPressed: deleteData,
                  child: const Text(
                      'Delete Data Section'),
                ),
              ),
            ],
          ),
        ));
  }
}
