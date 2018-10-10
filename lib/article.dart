class Article {
  String source;
  String id;
  String name;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;
  Article(
      {this.source,
      this.id,
      this.name,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        source: json['source']['id'],
        id: json['source']['id'],
        name: json['source']['name'],
        title: json['title'],
        description: json['description'],
        url: json['url'],
        urlToImage: json['urlToImage'],
        publishedAt: json['publishedAt'],
        content: json['content']);
  }
}
