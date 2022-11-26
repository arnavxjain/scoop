import 'dart:convert';

import 'package:http/http.dart';
import 'package:scoop/model/model.dart';

const String apiKey = "583c3aff8c974bdea492acdb7405a141";

class NetworkSystem {
  Future<List<SourceObj>> showSources() async {
    List<SourceObj> sources = [];

    Response response = await get(Uri.parse(Uri.encodeFull("https://newsapi.org/v2/top-headlines/sources?apiKey=$apiKey")));

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      final resSources = res["sources"];

      for (int x = 0; x < resSources.length; x++) {
        SourceObj newSource = SourceObj(
          name: resSources[x]["name"],
          URL: resSources[x]["url"],
          type: resSources[x]["category"]
        );

        sources.add(newSource);
      }
    }

    return sources;
  }

  Future<List<Article>> contentBuilder(locale, category) async {
    List<Article> articles = [];

    Response response = await get(Uri.parse(Uri.encodeFull("https://newsapi.org/v2/top-headlines?country=$locale&category=$category&apiKey=$apiKey")));

    print("https://newsapi.org/v2/top-headlines?country=$locale&category=$category&apiKey=$apiKey");

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      final resArticles = res["articles"];

      for (int x = 0; x < resArticles.length; x++) {
        Article newArticle = Article(
            imgURL: resArticles[x]["urlToImage"] ?? "https://picsum.photos/200/200",
            title: resArticles[x]["title"] ?? "Error",
            content: resArticles[x]["content"] ?? "No Content Available",
            source: resArticles[x]["source"]["name"] ?? "n/a"
        );

        articles.add(newArticle);
      }
    }

    return articles;
  }

  Future<Article> sysInit() async {
    Response response = await get(Uri.parse(Uri.encodeFull("https://newsapi.org/v2/top-headlines?country=in&apiKey=$apiKey")));

    final res = json.decode(response.body);
    final resArticles = res["articles"];

    Article newArticle = Article(
        imgURL: resArticles[0]["urlToImage"] ?? "https://picsum.photos/200/200",
        title: resArticles[0]["title"] ?? "Error",
        content: resArticles[0]["content"] ?? "No Content Available",
        source: resArticles[0]["source"]["name"] ?? "n/a"
    );

    return newArticle;
  }
}