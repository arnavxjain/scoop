import 'dart:convert';

import 'package:http/http.dart';
import 'package:scoop/model/model.dart';

const String apiKey = "583c3aff8c974bdea492acdb7405a141";
// const String apiKey = "f4d1f25b9dfa43d0960f73c9ff9a707d";

String localeLast = "";
String categoryLast = "";
List<Article> localeArticles = [];

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
    if (localeLast == locale && categoryLast == category) {
      print("sending localArticles [saved]");
      return localeArticles;
    } else {
      localeLast = locale;
      categoryLast = category;

      print("sending localArticles [new]");
      List<Article> articles = [];

      Response response = await get(Uri.parse(Uri.encodeFull("https://newsapi.org/v2/top-headlines?country=$locale&category=$category&apiKey=$apiKey")));

      // print("https://newsapi.org/v2/top-headlines?country=$locale&category=$category&apiKey=$apiKey");

      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        final resArticles = res["articles"];

        for (int x = 0; x < resArticles.length; x++) {
          Article newArticle = Article(
              imgURL: resArticles[x]["urlToImage"] ?? "https://picsum.photos/200/200",
              title: resArticles[x]["title"] ?? "Error",
              content: resArticles[x]["content"] ?? "No Content Available.",
              source: resArticles[x]["source"]["name"] ?? "n/a",
              sourceId: resArticles[x]["source"]["id"] ?? "Source Unavailable",
              url: resArticles[x]["url"]
          );

          articles.add(newArticle);
        }
      }

      localeArticles = articles;
      return articles;
    }
  }

  Future<List<Article>> overCall(locale, category) async {

    List<Article> articles = [];

    Response response = await get(Uri.parse(Uri.encodeFull("https://newsapi.org/v2/top-headlines?country=$locale&category=$category&apiKey=$apiKey")));

    // print("https://newsapi.org/v2/top-headlines?country=$locale&category=$category&apiKey=$apiKey");

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      final resArticles = res["articles"];

      for (int x = 4; x < resArticles.length; x++) {
        Article newArticle = Article(
            imgURL: resArticles[x]["urlToImage"] ?? "https://picsum.photos/200/200",
            title: resArticles[x]["title"] ?? "Error",
            content: resArticles[x]["content"] ?? "No Content Available.",
            source: resArticles[x]["source"]["name"] ?? "n/a",
            sourceId: resArticles[x]["source"]["id"] ?? "Source Unavailable",
            url: resArticles[x]["url"]
        );

        articles.add(newArticle);
      }
    }

    return articles;
  }

  Future<Article> sysInit() async {
    Response response = await get(Uri.parse(Uri.encodeFull("https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey")));

    final res = json.decode(response.body);
    final resArticles = res["articles"];

    Article newArticle = Article(
        imgURL: resArticles[0]["urlToImage"] ?? "https://picsum.photos/200/200",
        title: resArticles[0]["title"] ?? "Error",
        content: resArticles[0]["content"] ?? "No Content Available",
        source: resArticles[0]["source"]["name"] ?? "n/a",
        sourceId: resArticles[0]["source"]["id"] ?? "Source Unavailable",
        url: resArticles[0]["url"]
    );

    return newArticle;
  }

  Future<List<Article>> specifySourcedArticles(String sourceID) async {
    List<Article> articles = [];

    Response response = await get(Uri.parse(Uri.encodeFull("https://newsapi.org/v2/top-headlines?sources=$sourceID&apiKey=$apiKey")));

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      final resArticles = res["articles"];

      for (int x = 0; x < resArticles.length; x++) {
        Article newArticle = Article(
            imgURL: resArticles[x]["urlToImage"] ?? "https://picsum.photos/200/200",
            title: resArticles[x]["title"] ?? "Error",
            content: resArticles[x]["content"] ?? "No Content Available.",
            source: resArticles[x]["source"]["name"] ?? "n/a",
            sourceId: resArticles[x]["source"]["id"] ?? "Source Unavailable",
            url: resArticles[x]["url"]
        );

        articles.add(newArticle);
      }
    }

    return articles;
  }
}