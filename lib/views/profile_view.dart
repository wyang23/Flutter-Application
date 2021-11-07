import 'package:architectapp/helpers/interests.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:architectapp/helpers/article_model.dart';
import 'package:architectapp/helpers/news.dart';
import 'package:architectapp/models/category_model.dart';
import 'article_view.dart';
import 'edit_interest_view.dart';

class ProfileView extends StatefulWidget {
  late List<ArticleModel> likedArticles;
  late List<String> interestList;

  ProfileView({required this.likedArticles, required this.interestList});

  @override
  _ProfileViewState createState() => _ProfileViewState(this.likedArticles, this.interestList);
}

class _ProfileViewState extends State<ProfileView> {

  late List<ArticleModel> likedArticles;
  late List<String> interestList;
  _ProfileViewState(this.likedArticles, this.interestList);
  List<CategoryModel> categories = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      _loading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    //super.build(context);
    //interestList.add("Lmao");
    print(interestList.toString());

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
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              Container(height:10),
              Text("Profile",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
              ),
              /// Categories
              Container(
                //height: 70,
                alignment: Alignment.center,
                child: Text("Name: William Yang \nRole: Researcher at the University of Queensland",
                    style: TextStyle(
                      fontSize: 18,
                    )
                ),
                padding: EdgeInsets.all(10),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Interests",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    new GestureDetector(
                      /*
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => InterestView(interestList: interestList)
                          ));
                        },*/
                        onTap: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InterestView(interestList: interestList)
                              )
                          );
                          setState(() {});
                        },
                        child: Icon(Icons.edit))
                  ]
              ),
              Container(
                  child: Text(interestList.toString(),
                      style: TextStyle(
                        fontSize: 18,
                      )
                  ),
                  padding: EdgeInsets.all(10)
              ),
              Text("Liked Articles",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )
              ),
              /// Blogs
              Container(
                padding: EdgeInsets.only(top: 16),

                child: ListView.builder(
                    itemCount: likedArticles.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    //overflow: TextOverflow.ellipsis,
                    itemBuilder: (content, index){
                      return BlogTile(
                          author: likedArticles[index].author,
                          imageUrl: likedArticles[index].urlToImage,
                          title: likedArticles[index].title,
                          desc: likedArticles[index].description,
                          url: likedArticles[index].url,
                          keywords: likedArticles[index].keywords,
                          typeOfWork: likedArticles[index].typeOfWork,
                          subtype: likedArticles[index].subtype,
                          collections: likedArticles[index].collections,
                          publication: likedArticles[index].publication,
                          publicationPlace: likedArticles[index].publicationPlace,
                          similarArticles: likedArticles[index].similarArticles
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


class BlogTile extends StatelessWidget {

  late final String imageUrl, title, desc, author, url, keywords, typeOfWork, subtype,
      collections, publication, publicationPlace;
  late List<ArticleModel> similarArticles;
  BlogTile({required this.imageUrl, required this.title, required this.desc,
    required this.author, required this.url, required this.keywords,
    required this.typeOfWork, required this.subtype, required this.collections,
    required this.publication, required this.publicationPlace, required this.similarArticles});
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
