import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:boilerplate_flutter/component/route/routers.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        leading: IconButton(
          onPressed: () => context.maybePop(),
          icon: Icon(
            Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => context.router.push(const AccountRoute()),
              child: const Text('Go To Account'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<PostsCubit, PostsState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state.error != null) {
                    return _ErrorView(
                      message: state.error!,
                      onRetry: () => context.read<PostsCubit>().fetchPosts(),
                    );
                  }

                  if (state.posts.isEmpty) {
                    return const Center(
                      child: Text('No posts available'),
                    );
                  }

                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final post = state.posts[index];
                      return ListTile(
                        title: Text(post.title),
                        subtitle: Text(
                          post.body,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemCount: state.posts.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}
