import 'dart:convert';

import 'package:architectapp/helpers/article_model.dart';
import 'package:architectapp/views/web_article_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ArticleView extends StatefulWidget {
  late String author,title, desc, url, keywords, typeOfWork, subtype,
      collections, publication, publicationPlace;
  late List<ArticleModel> similarArticles;
  ArticleView({required this.title, required this.desc, required this.author, required this.url, required this.keywords,
    required this.typeOfWork, required this.subtype, required this.collections, required this.publication,
    required this.publicationPlace, required this.similarArticles});

  @override
  _ArticleViewState createState() => _ArticleViewState(this.title, this.desc, this.author, this.url, this.keywords,
      this.typeOfWork, this.subtype, this.collections, this.publication,
      this.publicationPlace, this.similarArticles);
}

class _ArticleViewState extends State<ArticleView> {

  late String author,title, desc, url, keywords, typeOfWork, subtype,
      collections, publication, publicationPlace;
  late List<ArticleModel> similarArticles;
  _ArticleViewState(this.title, this.desc, this.author, this.url, this.keywords,
    this.typeOfWork, this.subtype, this.collections, this.publication,
    this.publicationPlace, this.similarArticles);

  //List<String> recommendedTitles = [];
  List<ArticleModel> recommendedArticles = [];
  String flaskUrl = '';
  var data;
  String decoded = '';

  fetchData(String url) async{
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }

  getData() async {
    flaskUrl = 'https://architectappflutter.herokuapp.com/api?query=' + title.toString();
    data = await fetchData(flaskUrl);
    decoded = data.toString();
    List<String> recommendedTitles= decoded.split("^");
    for (int i = 0; i < similarArticles.length; i++) {
      for (int j =0; j < recommendedTitles.length; j++) {
        if (recommendedTitles[j].compareTo(similarArticles[i].title) == 0) {
          recommendedArticles.add(similarArticles[i]);
        }
      }
    }
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
                  Text(title, style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500
                  ),),
                  Container(height:10),
                  Text("Author(s): " + author, style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500
                      ),
                  ),
                  Container(height:10),
                  Text("Abstract", style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500
                  ),),
                  Text(desc, style: TextStyle(
                      color: Colors.black54
                  ),),
                  Text("Keywords: " + keywords, style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500
                  ),),
                  Text("Type of Work: " + typeOfWork, style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500
                  ),),
                  Text("Subtype: " + subtype, style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500
                  ),),
                  Text("PID: " + collections, style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500
                  ),),
                  Text("Publication: " + publication, style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500
                  ),),
                  Text("Place of Publication: " + publicationPlace, style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500
                  ),),
                  TextButton(
                    child: Text("URL: " + url, style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500
                    )),
                    onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => WebArticleView(
                                blogUrl: url,
                              )
                          ));
                          },
                  ),
                  Text("Further Research",style: TextStyle(
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