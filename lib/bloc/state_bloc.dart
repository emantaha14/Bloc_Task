class BlocState {
  final posts;
  BlocState(this.posts);
}

class InitialState extends BlocState {
  InitialState(super.posts);
}

class LoadingState extends BlocState {
  LoadingState(super.posts);
}

class PostSuccessState extends BlocState {
  bool allDataFetched ;
  PostSuccessState({required posts,required this.allDataFetched}) : super(posts);
}

class PostError extends BlocState{
  final String error;
  PostError(this.error) : super(null);
}
