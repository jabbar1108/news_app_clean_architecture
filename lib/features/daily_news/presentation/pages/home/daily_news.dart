import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/widgets/article_tile.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text(
        "Today News",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
        builder: (_, state) {
      if (state is RemoteArticleLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is RemoteArticleError) {
        print(state.error);
        return const Center(
          child: Icon(Icons.refresh),
        );
      }
      if (state is RemoteArticleDone) {
        print(state.articles);
        return ListView.builder(
          itemCount: state.articles!.length,
          itemBuilder: (context, index) {
            return ArticleWidget(article: state.articles![index],);
          },
        );
      }

      return const SizedBox();
    });
  }
}
