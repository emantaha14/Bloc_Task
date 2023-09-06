import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:metrospeedy_bloc_task/bloc/event_bloc.dart';
import 'package:metrospeedy_bloc_task/bloc/state_bloc.dart';

import '../model/post_repo.dart';

class PostBloc extends Bloc<BlocEvent, BlocState> {
  PostRepo repo;
  int page = 1;
  ScrollController scrollController = ScrollController();
  bool isLoading = false;
  PostBloc(this.repo) : super(InitialState(null)) {
    scrollController.addListener(() {
      add(LoadMoreEvent());
    });
    on<FetchPostsEvent>((event, emit) async {
      try {
        emit(LoadingState(null));
        var posts = await repo.fetchPosts(page);
        emit(PostSuccessState(posts: posts, allDataFetched: posts.isEmpty));
      } catch (error) {
        emit(PostError(error.toString()));
      }
    });
    on<LoadMoreEvent>((event, emit) async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        isLoading = true;
        page++;
        var posts = await repo.fetchPosts(page);
          emit(PostSuccessState(posts: [...state.posts, ...posts], allDataFetched: posts.isEmpty));
      }
    });
  }
}
