import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrospeedy_bloc_task/bloc/bloc.dart';
import 'package:metrospeedy_bloc_task/ui/error_handler.dart';

import '../bloc/state_bloc.dart';

class PostLayout extends StatelessWidget with ErrorHandler {
  const PostLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PostBloc, BlocState>(builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PostSuccessState) {
          var posts = state.posts;
          return ListView.builder(
            controller: context.read<PostBloc>().scrollController,
            itemCount: posts.length + 1,
            itemBuilder: (context, index) {
              if (index == posts.length) {
                return state.allDataFetched? Center(child: Text('All Data Fetched',style: Theme.of(context).textTheme.headlineLarge,)) :Center(child: CircularProgressIndicator());
              } else {
                var post = posts[index];
                return Card(
                  child: ListTile(
                    title: Text(post['title']),
                    subtitle: Text(post['body']),
                  ),
                );
              }
            },
          );
        }
        else if (state is PostError) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            handleApiError(state.error, context);
          });
          return CircularProgressIndicator();
        } else {
          return Container();
        }
      }),
    );
  }
}
