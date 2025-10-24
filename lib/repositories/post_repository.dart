import 'dart:convert';

import 'package:dio/dio.dart';

import '../data/remote/base_service.dart';
import '../models/models.dart';

abstract class PostRepository {
  Future<List<PostModel>> fetchPosts();
}

class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl(this._service);

  final BaseService _service;

  @override
  Future<List<PostModel>> fetchPosts() async {
    try {
      final response = await _service.dio.get('/posts');
      final raw = response.data;
      final List<dynamic> decoded;
      if (raw is String) {
        decoded = jsonDecode(raw) as List<dynamic>;
      } else if (raw is List) {
        decoded = raw.cast<dynamic>();
      } else {
        throw const FormatException('Unexpected response format');
      }

      return decoded
          .map(
            (e) => PostModel.fromJson(
              Map<String, dynamic>.from(e as Map),
            ),
          )
          .toList();
    } on DioException catch (error) {
      final message = error.message ?? 'Network error';
      throw Exception(message);
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
