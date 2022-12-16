// class TVShow {
//   final String? title;
//   final String? overview;
//   final String? firstAir;
//   final int id;
//   // final List<String> genres = [];
//   final String? poster;
//   final dynamic vote;
//
//   TVShow({this.title, this.overview, this.firstAir, required this.id, this.poster,
//     this.vote});
// }

class SourceObj {
  // final String? imageURL;
  final String name;
  final String URL;
  final String type;

  SourceObj({required this.name, required this.URL, required this.type});
}

class Article {
  final String imgURL;
  final String title;
  final String content;
  final String source;
  final String url;
  final String sourceId;

  Article({required this.imgURL, required this.title, required this.content, required this.source, required this.url, required this.sourceId});
}