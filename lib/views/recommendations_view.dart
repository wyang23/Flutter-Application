import 'dart:convert';

import 'package:architectapp/helpers/article_model.dart';
import 'package:architectapp/views/web_article_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'article_view.dart';

class RecommendationView extends StatefulWidget {
  late List<ArticleModel> likedArticles;
  late List<String> interestList;
  late List<ArticleModel> articles;

  RecommendationView({required this.likedArticles, required this.interestList, required this.articles});

  @override
  _RecommendationViewState createState() => _RecommendationViewState(this.likedArticles, this.interestList, this.articles);
}

class _RecommendationViewState extends State<RecommendationView> {

  late List<ArticleModel> likedArticles;
  late List<String> interestList;
  late List<ArticleModel> articles;
  _RecommendationViewState(this.likedArticles, this.interestList, this.articles);

  List<ArticleModel> recommendedArticles = [];
  String flaskUrl = '';
  var data;
  String decoded = '';

  fetchData(String url) async{
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }

  listToString(List<ArticleModel> lst) {
    String parseString = "";
    for (int i = 0; i < lst.length; i++) {
      parseString += lst[i].title;
      parseString += "^";
    }
    print(parseString.substring(0,parseString.length-1));
    return parseString.substring(0,parseString.length-1);
  }

  getData() async {
    flaskUrl = 'https://architectappflutter.herokuapp.com/api2?query=' + listToString(likedArticles);
    data = await fetchData(flaskUrl);
    decoded = data.toString();
    print(decoded);
    List<String> recommendedTitles= decoded.split("^");
    for (int i = 0; i < articles.length; i++) {
      for (int j =0; j < recommendedTitles.length; j++) {
        if (recommendedTitles[j].compareTo(articles[i].title) == 0) {
          recommendedArticles.add(articles[i]);
        }
      }
    }
    print(recommendedArticles);

    setState(()
    {});
  }

  @override
  void initState() {
    super.initState();
    getData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Architect"),
              Text("Digest", style: TextStyle(
                  color: Colors.blue
              ),)
            ]
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.save)),
          )
        ],
      ),

      body: Container(

          margin: EdgeInsets.only(bottom:16),
          child: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  SizedBox(height: 8),
                  Text("Recommended Articles",style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500
                  ),),
                  Container(
                    padding: EdgeInsets.only(top: 16),
                    child: ListView.builder(
                        itemCount: recommendedArticles.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        //overflow: TextOverflow.ellipsis,
                        itemBuilder: (content, index){
                          return BlogTile(
                            author: recommendedArticles[index].author,
                            imageUrl: recommendedArticles[index].urlToImage,
                            title: recommendedArticles[index].title,
                            desc: recommendedArticles[index].description,
                            url: recommendedArticles[index].url,
                            keywords: recommendedArticles[index].keywords,
                            typeOfWork: recommendedArticles[index].typeOfWork,
                            subtype: recommendedArticles[index].subtype,
                            collections: recommendedArticles[index].collections,
                            publication: recommendedArticles[index].publication,
                            publicationPlace: recommendedArticles[index].publicationPlace,
                            similarArticles: recommendedArticles[index].similarArticles,
                          );
                        }),
                  )
                ]
            ),
          )
      ),
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
                  //child: Image.network(imageUrl)
                ),
                SizedBox(height: 8),
                Text(title, style: TextStyle(
                    fontSize: 17,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500
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
              ]
          )
      ),
    );
  }
}