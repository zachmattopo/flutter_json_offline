import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../l10n/app_localizations.dart';
import '../cubits/bookmark_cubit/bookmark_cubit.dart';
import 'all_posts_page.dart';
import 'bookmarked_posts_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.appTitle),
          bottom: TabBar(
            tabs: [
              Tab(text: AppLocalizations.of(context)!.allPosts),
              BlocBuilder<BookmarkCubit, BookmarkState>(
                builder: (context, state) {
                  int count = 0;
                  if (state is BookmarkLoaded) {
                    count = state.bookmarkedPosts.length;
                  }
                  return Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            AppLocalizations.of(context)!.bookmarked,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            count.toString(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onTertiary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: const [
            AllPostsPage(),
            BookmarkedPostsPage(),
          ],
        ),
      ),
    );
  }
}
