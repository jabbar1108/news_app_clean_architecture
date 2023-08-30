import 'package:dio/src/dio_exception.dart';
import 'package:news_app_clean_architecture/core/constants/constants.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/models/article.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/respository/article_repository.dart';

class ArticleRepositoryImplementation implements ArticleRepository {
  final NewsApiService _newsApiService;

  ArticleRepositoryImplementation(this._newsApiService);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      final httpResponse = await _newsApiService.getNewsArticles(
        apiKey: newAPIKey,
        country: country,
        category: category,
      );
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            requestOptions: httpResponse.response.requestOptions,
            error: httpResponse.response.statusCode,
            message: httpResponse.response.statusMessage,
          ),
        );
      }
    } on DioException catch(e) {
      return DataFailed(e);
    }

  }
}
