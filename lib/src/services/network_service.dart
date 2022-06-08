// ignore_for_file: prefer_const_declarations, depend_on_referenced_packages
// network_service.dart
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mystock/src/constants/api.dart';
import 'package:mystock/src/models/post.dart';
import 'package:mystock/src/models/product.dart';
import 'package:http_parser/http_parser.dart';

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
  // AddProduct
  Future<String> addProduct(Product product, {File? imageFile}) async {
    final url = API.PRODUCT;

    FormData data = FormData.fromMap(
      {
        'name': product.name,
        'price': product.price,
        'stock': product.stock,
        if (imageFile != null)
          'photo': await MultipartFile.fromFile(
            imageFile.path,
            contentType: MediaType('image', 'jpg'),
          ),
      },
    );

    final Response response = await _dio.post(url, data: data);

    if (response.statusCode == 201) {
      return "Add Successfully";
    }
    throw Exception('Network failed');
  }

  // EditProduct
  Future<String> editProduct(Product product, {File? imageFile}) async {
    final url = '${API.PRODUCT}/${product.id}';

    FormData data = FormData.fromMap(
      {
        'name': product.name,
        'price': product.price,
        'stock': product.stock,
        if (imageFile != null)
          'photo': await MultipartFile.fromFile(
            imageFile.path,
            contentType: MediaType('image', 'jpg'),
          ),
      },
    );

    final Response response = await _dio.put(url, data: data);

    if (response.statusCode == 200) {
      return "Edit Successfully";
    }
    throw Exception('Network failed');
  }

  // DeleteProduct
  Future<String> deleteProduct(int productId) async {
    final url = '${API.PRODUCT}/$productId';

    final Response response = await _dio.delete(url);

    if (response.statusCode == 204) {
      return "Delete Successfully";
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
