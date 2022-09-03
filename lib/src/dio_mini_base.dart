// ignore_for_file: avoid_print
import 'dart:io';
import 'package:dio/dio.dart';

abstract class IDioMini {
  String baseUrl;
  final dynamic model;
  late final Dio dio;
  late final FormData formData;

  IDioMini({
    required this.model,
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
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      print('!Sending request to: ${options.path}');
    }, onResponse: (response, handler) {
      print('Response status code: ${response.statusCode.toString()}');
      print('Response data: ${response.data.toString()}');
      return handler.next(response);
    }, onError: (DioError e, handler) {
      print('Error received! Message is: ${e.message}');
      return handler.next(e);
    }));
  }

  Future<List<dynamic>?> getDataList(String mainUrlName);

  Future<dynamic> getData(String mainUrlName, String id);

  Future<bool> postData(String mainUrl);

  Future<bool> putData(String id, String mainUrl);

  Future<bool> deleteData(String id, String mainUrl);

  Future<void> uploadData(
      String dataPath, String fileName, String keyName, String mainUrl);
}

class DioMini extends IDioMini {
  final String baseURL;
  final dynamic model;
  DioMini({required this.model, required this.baseURL})
      : super(model: model, baseUrl: baseURL);

  @override
  Future<Map<String, dynamic>?> getData(String mainUrlName, String id) async {
    try {
      Response userData = await dio.get('/$mainUrlName/$id');

      final dataList = userData.data;
      return dataList;
      //

    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
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
  Future<bool> postData(String mainUrl) async {
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
  Future<bool> putData(String id, String mainUrl) async {
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

  // not for real time database.
  @override
  Future<void> uploadData(
      String dataPath, String fileName, String keyName, String mainUrl) async {
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
  Future<bool> deleteData(String id, String mainUrl) async {
    try {
      await dio.delete('/$mainUrl/$id');
      return true;
    } catch (e) {
      print('Error deleting user: $e');
      return false;
    }
  }

  @override
  Future<List<dynamic>?> getDataList(String mainUrlName) async {
    try {
      Response data = await dio.get('/$mainUrlName');

      return data.data;
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
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
}
