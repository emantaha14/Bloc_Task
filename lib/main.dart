import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrospeedy_bloc_task/bloc/bloc.dart';
import 'package:metrospeedy_bloc_task/bloc/event_bloc.dart';
import 'package:metrospeedy_bloc_task/model/post_repo.dart';
import 'package:metrospeedy_bloc_task/ui/post_ui.dart';

void main() {
  runApp(MaterialApp(home: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PostRepo(),
      child: BlocProvider(
        create: (context) => PostBloc(context.read<PostRepo>())..add(FetchPostsEvent()),
        child: PostLayout(),
      ),
    );
  }
}