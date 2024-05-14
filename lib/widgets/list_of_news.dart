import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getNotasFromFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final newsData = snapshot.data;

          if (newsData == null) {
            return const Center(
              child: Text('No hay noticias'),
            );
          }

          return ListView.builder(
              itemCount: newsData.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NewsScreen(noticia: newsData[index])))
                  },
                  child: NewCard(
                    noticia: newsData[index],
                  ),
                );
              });
        });
  }

  // Future<void> _dialogBuilder(BuildContext context) {
  //   return showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         backgroundColor: Colors.white,
  //         title: const Text(
  //           'En construcción..',
  //           style: TextStyle(fontWeight: FontWeight.bold),
  //         ),
  //         content: const Text(
  //           'Traer las notas del sitio web, es un trabajo que está en construcción, las que ve son solo un ejemplo de como se podrían ver...',
  //           style: TextStyle(fontSize: 15),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             style: TextButton.styleFrom(
  //               textStyle: Theme.of(context).textTheme.labelLarge,
  //             ),
  //             child: const Text('Entiendo'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }
}
