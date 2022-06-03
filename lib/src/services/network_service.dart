// ignore_for_file: prefer_const_declarations
// network_service.dart
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mystock/src/models/post.dart';
import 'package:mystock/src/models/product.dart';

import '../constants/api.dart';

class NetworkService {
  NetworkService._internal();

  static final NetworkService _instance = NetworkService._internal();

  factory NetworkService() => _instance;

  static final _dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.baseUrl = API.BASE_URL;
          options.connectTimeout = 5000;
          options.receiveTimeout = 3000;
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioError error, handler) {
         return handler.next(error);
        },
      ),
    );

  Future<List<Product>> getAllProduct() async {
    final url = API.PRODUCT;
    final Response response = await _dio.get(url);

    if (response.statusCode == 200) {
      return productFromJson(jsonEncode(response.data));
    }
    throw Exception('Network failed');
  }

  Future<List<Post>> fetchPosts(int startIndex, {int limit = 10}) async {
    final url =
        'https://jsonplaceholder.typicode.com/posts?_start=startIndex&_limit=$limit';
    final Response response = await _dio.get(url);

    if (response.statusCode == 200) {
      return postFromJson(jsonEncode(response.data));
    }
    throw Exception('Network failed');
  }
}
