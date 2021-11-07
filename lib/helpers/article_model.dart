class ArticleModel{
  late String author;
  late String title;
  late String description;
  late String url;
  late String urlToImage;
  late String keywords;
  late String typeOfWork;
  late String subtype;
  late String collections;
  late String publication;
  late String publicationPlace;
  late List<ArticleModel> similarArticles;

  ArticleModel({required this.author, required this.title, required this.description,
    required this.url, required this.urlToImage, required this.keywords, required this.typeOfWork,
    required this.subtype, required this.collections, required this.publication, required this.publicationPlace,
    required this.similarArticles});
}