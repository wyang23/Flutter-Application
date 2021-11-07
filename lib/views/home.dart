import 'package:architectapp/helpers/interests.dart';
import 'package:architectapp/views/profile_view.dart';
import 'package:architectapp/views/recommendations_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:architectapp/helpers/article_model.dart';
import 'package:architectapp/helpers/news.dart';
import 'package:architectapp/models/category_model.dart';
import 'package:architectapp/helpers/data.dart';
import 'package:flutter/services.dart';
import 'article_view.dart';
import 'category_news.dart';

List<ArticleModel> likedArticles = [];
List<String> interestList = [];
List<ArticleModel> articles = [];


ArticleModel articleModel1 = ArticleModel(
    title:
    "The urban transport crisis in emerging economies: a comparative overview",
    author: "Pojani, Dorina, Stead, Dominic",
    description: "This chapter reflects on the 12 case studies contained in this book, and identifies some of the key issues, trends, and policy measures which emerge from the previous chapters. Consideration is also given to the lessons that can be learned from these countries and the extent to which they may be generalizable and applicable in other contexts across the world. The chapter is structured according to the main headings used in each of the country-specific chapters.",
    url: "https://doi.org/10.1007/s10901-020-09767-z",
    urlToImage: "https://cdnassets.hw.net/52/6f/22b2634842c1ada80f0126ec5798/1733742913-jamesonnew-01-tcm52-1575196.jpg",
    keywords: "Geography, Planning and Development, Arts and Humanities (miscellaneous), Urban Studies",
    typeOfWork: "Journal Article",
    subtype: "Article (original research)",
    collections: "HERDC Pre-Audit, School of Earth and Environmental Sciences",
    publication: "Routledge",
    publicationPlace: "Abingdon, Oxon, United Kingdom",
    similarArticles: []
);

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categories = [];
  //List<ArticleModel> articles = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    setState(() {
      _loading = false;
    });
    getLikedArticles();
    getInterests();
    loadAsset();
  }

  loadAsset() async {
    var myData = await rootBundle.loadString("assets/gooddata.csv");
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);

    for (int i = 1; i < csvTable.length; i++) {
      ArticleModel model = new ArticleModel (
          author: csvTable[i][7].toString(),
          urlToImage: "https://cdnassets.hw.net/52/6f/22b2634842c1ada80f0126ec5798/1733742913-jamesonnew-01-tcm52-1575196.jpg",
          title: csvTable[i][2].toString(),
          description: csvTable[i][4].toString(),
          url: "http://doi.org/" + csvTable[i][8].toString(),
          keywords: csvTable[i][14].toString(),
          typeOfWork: csvTable[i][3].toString(),
          subtype: csvTable[i][11].toString(),
          collections: csvTable[i][1].toString(),
          publication: csvTable[i][13].toString(),
          publicationPlace: csvTable[i][12].toString(),
          similarArticles: [articleModel1]
      );
      articles.add(model);
    }
    setState(() {
      _loading = false;
    });
  }

  /*
  getNews() async {
    News news = News();
    await news.getNews();
    articles = news.news;
    setState(() {
      _loading = false;
    });
  }*/

  getLikedArticles() async {
    LikedArticlesClass news = LikedArticlesClass();
    await news.getLikedArticles();
    likedArticles = news.likedArticles;
  }

  getInterests() async {
    InterestsClass interests = InterestsClass();
    await interests.getFollowedInterests();
    interestList = interests.followedInterests;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text("Architect"),
            Text("Digest", style: TextStyle(
                color: Colors.blue
            ),),
            /* ADDD PROFILE PICTURE HERE*/
            Spacer(),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ProfileView(likedArticles: likedArticles, interestList: interestList)
                ));
              }
            )
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              /// Categories
              Container(
                height: 70,
                child: ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return CategoryTile(
                        imageUrl: categories[index].imageUrl,
                        categoryName: categories[index].categoryName,
                      );
                    }),
              ),
              CupertinoButton(
                child: Text("Get Recommendations"),
                onPressed: () {
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => RecommendationView(likedArticles: likedArticles, interestList: interestList, articles: articles)
                    ));
                  });
                },
              ),
              /// Blogs
              Container(
                padding: EdgeInsets.only(top: 16),
                child: ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (content, index){
                      return BlogTile(
                          author: articles[index].author,
                          imageUrl: articles[index].urlToImage,
                          title: articles[index].title,
                          desc: articles[index].description,
                          url: articles[index].url,
                          keywords: articles[index].keywords,
                          typeOfWork: articles[index].typeOfWork,
                          subtype: articles[index].subtype,
                          collections: articles[index].collections,
                          publication: articles[index].publication,
                          publicationPlace: articles[index].publicationPlace,
                          similarArticles: articles[index].similarArticles
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imageUrl, categoryName;

  CategoryTile({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /*
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => CategoryNews(
              category: categoryName.toLowerCase(),
            )
        ));

         */
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(imageUrl: imageUrl, width: 120, height: 60, fit: BoxFit.cover,),
            ),
            Container(
              alignment: Alignment.center,
              width: 120, height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(categoryName, style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500
              ),),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatefulWidget {
  @override

  late final String imageUrl, title, desc, author, url, keywords, typeOfWork, subtype, collections, publication, publicationPlace;
  late final List<ArticleModel> similarArticles;
  BlogTile({required this.imageUrl, required this.title, required this.desc, required this.author,
    required this.url, required this.keywords, required this.typeOfWork, required this.subtype,
    required this.collections, required this.publication, required this.publicationPlace, required this.similarArticles});

  _BlogTileState createState() => _BlogTileState(this.imageUrl, this.title, this.desc, this.author, this.url, this.keywords,
      this.typeOfWork, this.subtype, this.collections, this.publication, this.publicationPlace, this.similarArticles);

}

class _BlogTileState extends State<BlogTile> {
  late final String imageUrl, title, desc, author, url, keywords, typeOfWork, subtype, collections,
      publication, publicationPlace;
  late final List<ArticleModel> similarArticles;
  _BlogTileState(this.imageUrl, this.title, this.desc, this.author, this.url, this.keywords,
      this.typeOfWork, this.subtype, this.collections, this.publication, this.publicationPlace, this.similarArticles);
  bool toggle = false;


  @override
  Widget build(BuildContext context) {

    ArticleModel newArticle = ArticleModel(
        author: author,
        title: title,
        url: url,
        keywords: keywords,
        typeOfWork: typeOfWork,
        subtype: subtype,
        collections: collections,
        publication: publication,
        publicationPlace: publicationPlace,
        urlToImage: url,
        description: desc,
        similarArticles: articles
    );

    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ArticleView(
              author: author,
              title: title,
              desc: desc,
              url: url,
              keywords: keywords,
              typeOfWork: typeOfWork,
              subtype: subtype,
              collections: collections,
              publication: publication,
              publicationPlace: publicationPlace,
              similarArticles: articles
            )
        ));
      },
      child: Container(
          margin: EdgeInsets.only(bottom:16),
          child: Column(
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    //child: Image.network(imageUrl)
                ),
                SizedBox(height: 4),
                Text(title, style: TextStyle(
                    fontSize: 17,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500
                ),),
                SizedBox(height: 8),
                RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: keywords,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500
                    ),
                  ),),
                RichText(
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: desc,
                    style: TextStyle(
                        color: Colors.black54
                    ),
                ),),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Like",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          )
                      ),
                      IconButton(
                          icon: toggle ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                          onPressed: () {
                            setState(() {
                              toggle = !toggle;
                              if (toggle) {
                                likedArticles.add(newArticle);
                              } else {
                                for (int i = 0;i < likedArticles.length; i++) {
                                  if (likedArticles[i].author.compareTo(newArticle.author) == 0) {
                                    likedArticles.removeAt(i);
                                    print("yes");
                                  }
                                }
                              }
                              print(likedArticles.toString());
                            });// Here we changing the icon.
                          }
                          ),
                    ]
                )
              ]
          )
      ),
    );
  }
}
