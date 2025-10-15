import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repositories/post_repository.dart';
import 'presentation/cubits/posts_cubit/posts_cubit.dart';
import 'presentation/pages/list_page.dart';
import 'presentation/pages/details_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postRepository = PostRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PostsCubit(postRepository)..loadPosts(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: 'list/',
        routes: {
          "list/": (context) => const ListPage(),
          "details/": (context) => const DetailsPage(),
        },
      ),
    );
  }
}
