part of 'posts_cubit.dart';

@freezed
class PostsState with _$PostsState {
  const factory PostsState.initial() = _Initial;
  const factory PostsState.loading() = _Loading;
  const factory PostsState.success(List<PostModel> posts) = _Success;
  const factory PostsState.failure(String message) = _Failure;
}

extension PostsStateX on PostsState {
  bool get isLoading => maybeWhen(
        loading: () => true,
        orElse: () => false,
      );

  List<PostModel> get posts => maybeWhen(
        success: (posts) => posts,
        orElse: () => const [],
      );

  String? get error => when(
        initial: () => null,
        loading: () => null,
        success: (_) => null,
        failure: (message) => message,
      );
}
