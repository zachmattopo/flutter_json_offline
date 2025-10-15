import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_tech_task/data/models/post.dart';
import 'package:flutter_tech_task/presentation/cubits/bookmark_cubit/bookmark_cubit.dart';
import 'package:flutter_tech_task/presentation/pages/bookmarked_details_page.dart';
import 'package:flutter_tech_task/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'bookmarked_details_page_test.mocks.dart';

@GenerateMocks([BookmarkCubit])
void main() {
  late MockBookmarkCubit mockBookmarkCubit;

  setUp(() {
    mockBookmarkCubit = MockBookmarkCubit();
  });

  testWidgets('Bookmarked details page renders title and body', (WidgetTester tester) async {
    final post = Post(id: 1, title: 'Test Title', body: 'Test Body');

    when(mockBookmarkCubit.state).thenReturn(BookmarkInitial());
    when(mockBookmarkCubit.isBookmarked(any)).thenReturn(false);
    when(mockBookmarkCubit.stream).thenAnswer((_) => Stream.fromIterable([]));

    await tester.pumpWidget(
      BlocProvider<BookmarkCubit>.value(
        value: mockBookmarkCubit,
        child: MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en', ''), // English
          ],
          home: BookmarkedDetailsPage(post: post),
        ),
      ),
    );

    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Test Body'), findsOneWidget);
  });
}