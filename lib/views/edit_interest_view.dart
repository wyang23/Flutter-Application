import 'package:architectapp/helpers/interests.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:architectapp/helpers/article_model.dart';
import 'package:architectapp/models/category_model.dart';
import 'article_view.dart';

class InterestView extends StatefulWidget {
  late List<String> interestList;

  InterestView({required this.interestList});

  @override
  _InterestViewState createState() => _InterestViewState(this.interestList);
}

class _InterestViewState extends State<InterestView>{

  late List<String> interestList;
  _InterestViewState(this.interestList);

  bool _loading = true;
  List<bool> _following = List.filled(17, false, growable: false);

  @override
  void initState() {
    super.initState();
    //print(interestList.toString());
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //super.build(context);
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
              Text("Interests",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  )
              ),
              MergeSemantics(
                child: Column(
                    children: <Widget>[
                      Container(
                          child: Text(interestList.toString(),
                              style: TextStyle(
                                fontSize: 18,
                              )
                          ),
                          padding: EdgeInsets.all(10)
                      ),
                      ListTile(
                        title: const Text('Urban Planning'),
                        trailing: CupertinoSwitch(
                          value: _following[0],
                          onChanged: (bool value) {
                            setState(() {
                              _following[0] = value;
                              if (interestList.contains("Urban Planning")) {
                                interestList.remove("Urban Planning");
                              } else {
                                interestList.add("Urban Planning");
                              }
                            }); },
                        ),
                        onTap: () {}
                      ),
                      ListTile(
                        title: const Text('Sustainable Cities'),
                        trailing: CupertinoSwitch(
                          value: _following[1],
                          onChanged: (bool value) {
                            setState(() {
                              _following[1] = value;
                              if (interestList.contains("Sustainable Cities")) {
                                interestList.remove("Sustainable Cities");
                              } else {
                                interestList.add("Sustainable Cities");
                              }
                            }); },
                        ),
                        onTap: () {}
                      ),
                      ListTile(
                        title: const Text('Bikesharing'),
                        trailing: CupertinoSwitch(
                          value: _following[2],
                          onChanged: (bool value) {
                            setState(() {
                              _following[2] = value;
                              if (interestList.contains("Bikesharing")) {
                                interestList.remove("Bikesharing");
                              } else {
                                interestList.add("Bikesharing");
                              }
                            }); },
                        ),
                        onTap: () {}
                      ),
                      ListTile(
                        title: const Text('Planning and Development'),
                        trailing: CupertinoSwitch(
                          value: _following[3],
                          onChanged: (bool value) {
                            setState(() {
                              _following[3] = value;
                              if (interestList.contains("Planning and Development")) {
                                interestList.remove("Planning and Development");
                              } else {
                                interestList.add("Planning and Development");
                              }}); },
                        ),
                        onTap: () {}
                      ),
                      ListTile(
                        title: const Text('Town planning'),
                        trailing: CupertinoSwitch(
                          value: _following[4],
                          onChanged: (bool value) {
                            setState(() {
                              _following[4] = value;
                              if (interestList.contains("Town planning")) {
                                interestList.remove("Town planning");
                              } else {
                                interestList.add("Town planning");
                              }
                            }); },
                        ),
                        onTap: () {}
                      ),
                      ListTile(
                        title: const Text('Social planning'),
                        trailing: CupertinoSwitch(
                          value: _following[5],
                          onChanged: (bool value) {
                            setState(() { _following[5] = value;
                            if (interestList.contains("Social planning")) {
                              interestList.remove("Social planning");
                            } else {
                              interestList.add("Social planning");
                            }
                            }); },
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        title: const Text('Public interest'),
                        trailing: CupertinoSwitch(
                          value: _following[6],
                          onChanged: (bool value) {
                            setState(() { _following[6] = value;
                            if (interestList.contains("Public interest")) {
                              interestList.remove("Public interest");
                            } else {
                              interestList.add("Public interest");
                            }
                            }); },
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        title: const Text('Community planning'),
                        trailing: CupertinoSwitch(
                          value: _following[7],
                          onChanged: (bool value) {
                            setState(() {
                              _following[7] = value;
                              if (interestList.contains("Community planning")) {
                                interestList.remove("Community planning");
                              } else {
                                interestList.add("Community planning");
                              }
                            }); },
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        title: const Text('Geography'),
                        trailing: CupertinoSwitch(
                          value: _following[8],
                          onChanged: (bool value) {
                            setState(() {
                              _following[8] = value;
                              if (interestList.contains("Geography")) {
                                interestList.remove("Geography");
                              } else {
                                interestList.add("Geography");
                              }
                            });
                          },
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        title: const Text('Participatory mapping'),
                        trailing: CupertinoSwitch(
                          value: _following[9],
                          onChanged: (bool value) {
                            setState(() {
                              _following[9] = value;
                              if (interestList.contains("Participatory mapping")) {
                                interestList.remove("Participatory mapping");
                              } else {
                                interestList.add("Participatory mapping");
                              }
                            }); },
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        title: const Text('Suburbanisation'),
                        trailing: CupertinoSwitch(
                          value: _following[10],
                          onChanged: (bool value) {
                            setState(() { _following[10] = value;
                            if (interestList.contains("Suburbanisation")) {
                              interestList.remove("Suburbanisation");
                            } else {
                              interestList.add("Suburbanisation");
                            }
                            }); },
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        title: const Text('Transport planning'),
                        trailing: CupertinoSwitch(
                          value: _following[11],
                          onChanged: (bool value) {
                            setState(() {
                              _following[11] = value;
                              if (interestList.contains("Transport planning")) {
                                interestList.remove("Transport planning");
                              } else {
                                interestList.add("Transport planning");
                              }
                            }); },
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        title: const Text('Civil and Structural Engineering'),
                        trailing: CupertinoSwitch(
                          value: _following[12],
                          onChanged: (bool value) {
                            setState(() {
                              _following[12] = value;
                              if (interestList.contains("Civil and Structural Engineering")) {
                                interestList.remove("Civil and Structural Engineering");
                              } else {
                                interestList.add("Civil and Structural Engineering");
                              }
                            }); },
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        title: const Text('Management'),
                        trailing: CupertinoSwitch(
                          value: _following[13],
                          onChanged: (bool value) {
                            setState(() {
                              _following[13] = value;
                              if (interestList.contains("Management")) {
                                interestList.remove("Management");
                              } else {
                                interestList.add("Management");
                              }
                            }); },
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        title: const Text('Tourism'),
                        trailing: CupertinoSwitch(
                          value: _following[14],
                          onChanged: (bool value) {
                            setState(() {
                              _following[14] = value;
                              if (interestList.contains("Tourism")) {
                                interestList.remove("Tourism");
                              } else {
                                interestList.add("Tourism");
                              }
                            }); },
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        title: const Text('Automative Engineering'),
                        trailing: CupertinoSwitch(
                          value: _following[15],
                          onChanged: (bool value) {
                            setState(() {
                              _following[15] = value;
                              if (interestList.contains("Automative Engineering")) {
                                interestList.remove("Automative Engineering");
                              } else {
                                interestList.add("Automative Engineering");
                              }
                            }); },
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        title: const Text('Arts and Humanities (miscellaneous)'),
                        trailing: CupertinoSwitch(
                          value: _following[16],
                          onChanged: (bool value) {
                            setState(() {
                              _following[16] = value;
                              if (interestList.contains("Arts and Humanities (miscellaneous)")) {
                                interestList.remove("Arts and Humanities (miscellaneous)");
                              } else {
                                interestList.add("Arts and Humanities (miscellaneous)");
                              }
                            }); },
                        ),
                        onTap: () {},
                      )
                    ]
                ),
              )
            ]
          ),
        ),
      ),
    );
  }

}

class BlogTile extends StatelessWidget {

  late final String imageUrl, title, desc, author, url, keywords, typeOfWork,
      subtype, collections, publication, publicationPlace;
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
                similarArticles: similarArticles,
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

