import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:boilerplate_flutter/models/models.dart';
import 'package:boilerplate_flutter/repositories/repositories.dart';

part 'posts_cubit.freezed.dart';
part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit(this._repository) : super(const PostsState.initial());

  final PostRepository _repository;

  Future<void> fetchPosts() async {
    emit(const PostsState.loading());
    try {
      final posts = await _repository.fetchPosts();
      emit(PostsState.success(posts));
    } catch (error) {
      emit(PostsState.failure(error.toString()));
    }
  }
}
