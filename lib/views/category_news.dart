import 'package:flutter/material.dart';
import 'package:architectapp/helpers/article_model.dart';
import 'package:architectapp/helpers/news.dart';

import 'article_view.dart';

class CategoryNews extends StatefulWidget {

  late final String category;
  CategoryNews({required this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {

  List<ArticleModel> articles = [];
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getCategoryNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
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
              ),)
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
            child: Container( padding: EdgeInsets.symmetric(horizontal:16),
                child: Column(
                    children: <Widget>[
                      ///blogs
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
                    ]
                )
            )
        )
    );
  }
}

class BlogTile extends StatelessWidget {

  late final String imageUrl, title, desc, author, url, keywords, typeOfWork, subtype,
      collections, publication, publicationPlace;
  late List<ArticleModel> similarArticles;
  BlogTile({required this.imageUrl, required this.title, required this.desc, required this.author,
    required this.url, required this.keywords, required this.typeOfWork, required this.subtype,
    required this.collections, required this.publication, required this.publicationPlace, required this.similarArticles});
  @override
  Widget build(BuildContext context) {
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
                similarArticles: similarArticles
            )
        ));
      },

      child: Container(
          margin: EdgeInsets.only(bottom:16),
          child: Column(
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(imageUrl)
                ),
                SizedBox(height: 8),
                Text(title, style: TextStyle(
                    fontSize: 17,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500
                ),),
                Text(desc, style: TextStyle(
                    color: Colors.black54
                ),)
              ]
          )
      ),
    );
  }
}

