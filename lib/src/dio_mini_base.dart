// ignore_for_file: avoid_print
import 'dart:io';
import 'package:dio/dio.dart';
import 'ex_model_class.dart'; // Delete after

// !!! you must change StudentModel your ModelClass
typedef ModelClass = NameModel; // !!!
// !!!

abstract class IDioMini {
  String baseUrl;

  late final Dio dio;
  late final FormData formData;

  IDioMini({
    required this.baseUrl,
  }) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 5000,
        receiveTimeout: 3000,
      ),
    );

    //
    // dioSettings(); You can setting interceptors in here method.
    //
  }

  void dioSettings() {
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
      print(
          '!Sending request to: ${options.path}');
    }, onResponse: (response, handler) {
      print(
          'Response status code: ${response.statusCode.toString()}');
      print(
          'Response data: ${response.data.toString()}');
      return handler.next(response);
    }, onError: (DioError e, handler) {
      print(
          'Error received! Message is: ${e.message}');
      return handler.next(e);
    }));
  }

  Future<List<ModelClass>?> getDataList(
      {required String mainUrlName});

  Future<ModelClass?> getData(
      {required String mainUrlName,
      required String id});

  Future<bool> postData(
      {required ModelClass model,
      required String mainUrl});

  Future<bool> putData(
      {required ModelClass model,
      required String id,
      required String mainUrl});

  Future<bool> deleteData(
      {required String id,
      required String mainUrl});

  Future<void> uploadData({
    required String dataPath,
    required String fileName,
    required String keyName,
    required String mainUrl,
  });
}

class DioMini extends IDioMini {
  final String baseURL;

  DioMini({required this.baseURL})
      : super(baseUrl: baseURL);

  @override
  Future<ModelClass?> getData(
      {required String mainUrlName,
      required String id}) async {
    ModelClass? model;
    try {
      Response userData = await dio.get(
          '/$mainUrlName/$id'); // Maybe add '.json' your path :D

      final dataList = userData.data;
      model = ModelClass.fromJson(dataList);
      return model;
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print(
            'STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    return null;
  }

  @override
  Future<bool> postData(
      {required ModelClass model,
      required String mainUrl}) async {
    try {
      await dio.post(
        '/$mainUrl',
        data: model.toJson(),
      );
    } catch (e) {
      print('Error creating user: $e');
      return false;
    }
    return true;
  }

  @override
  Future<bool> putData(
      {required ModelClass model,
      required String id,
      required String mainUrl}) async {
    try {
      await dio.put(
        '/$mainUrl/$id',
        data: model.toJson(),
      );
      return true;
    } catch (e) {
      print('Error updating user: $e');
      return false;
    }
  }

  @override
  Future<void> uploadData(
      {required String dataPath,
      required String fileName,
      required String keyName,
      required String mainUrl}) async {
    File imageFile = File(dataPath);

    formData = FormData.fromMap({
      keyName: await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
      ),
    });
    await dio.post(
      '/$mainUrl',
      data: formData,
      onSendProgress: (int sent, int total) {
        print('$sent $total');
      },
    );
  }

  @override
  Future<bool> deleteData(
      {required String id,
      required String mainUrl}) async {
    try {
      await dio.delete('/$mainUrl/$id');
      return true;
    } catch (e) {
      print('Error deleting user: $e');
      return false;
    }
  }

  @override
  Future<List<ModelClass>?> getDataList(
      {required String mainUrlName}) async {
    List<ModelClass>? models;
    try {
      Response data =
          await dio.get('/$mainUrlName');
      final userData = data.data;

      if (userData is List) {
        models = userData
            .map((e) => ModelClass.fromJson(e))
            .toList();
      }
      return models;
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print(
            'STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    return models;
  }
}
