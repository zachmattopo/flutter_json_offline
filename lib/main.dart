import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'l10n/app_localizations.dart';
import 'data/repositories/post_repository.dart';
import 'data/repositories/bookmark_repository.dart';
import 'data/models/post.dart';
import 'presentation/cubits/posts_cubit/posts_cubit.dart';
import 'presentation/cubits/bookmark_cubit/bookmark_cubit.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/details_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PostAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => PostRepository()),
        RepositoryProvider(create: (context) => BookmarkRepository()..init()),
      ],
      child: Builder(
        builder: (context) {
          final postRepository = context.read<PostRepository>();

          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => PostsCubit(postRepository)..loadPosts()),
              BlocProvider(create: (context) => BookmarkCubit(context.read<BookmarkRepository>())),
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'), // English
                Locale('ms'), // Malay
              ],
              initialRoute: '/',
              routes: {
                "/": (context) => const HomePage(),
                "details/": (context) => const DetailsPage(),
              },
            ),
          );
        },
      ),
    );
  }
}
