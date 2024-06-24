import 'package:flutter/material.dart';
import 'package:radioseiboapp/models/news.model.dart';
import 'package:radioseiboapp/widgets/youtube_banner.dart';

import '../screens/new_screen.dart';
import '../services/firebase.dart';
import 'new_card.dart';

class ListOfNews extends StatefulWidget {
  const ListOfNews({
    super.key,
  });

  @override
  State<ListOfNews> createState() => _ListOfNewsState();
}

class _ListOfNewsState extends State<ListOfNews> {
  List<NewsFirebase> _listOfNews = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (_listOfNews.isEmpty) {
        return const Center(
          child:
              Text('No se econtraron noticias, revise su conexión a internet'),
        );
      } else {
        return RefreshIndicator(
          onRefresh: _handleRefresh,
          child: ListView.builder(
              itemCount: _listOfNews.length,
              itemBuilder: (context, index) {
                return index != 1
                    ? GestureDetector(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NewsScreen(noticia: _listOfNews[index])))
                        },
                        child: NewCard(
                          noticia: _listOfNews[index],
                        ),
                      )
                    : Column(
                        children: [
                          const YoutubeBanner(),
                          GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewsScreen(
                                          noticia: _listOfNews[index])))
                            },
                            child: NewCard(
                              noticia: _listOfNews[index],
                            ),
                          )
                        ],
                      );
              }),
        );
      }
    }
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _loading = true;
    });
    // Simulate network fetch or database query
    List<NewsFirebase> list = await getNotasFromFirebase();
    // Update the list of items and refresh the UI
    setState(() {
      _loading = false;
      _listOfNews = list;
    });
  }
}
