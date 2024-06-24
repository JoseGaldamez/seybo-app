import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:radioseiboapp/models/news.model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class NewsScreen extends StatelessWidget {
  final NewsFirebase noticia;
  const NewsScreen({super.key, required this.noticia});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text(
            'Volver',
            style: TextStyle(fontSize: 16),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                height: MediaQuery.of(context).size.width * 0.5,
                width: double.infinity,
                fit: BoxFit.cover,
                imageUrl: noticia.image,
                placeholder: (context, url) => const Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator()),
                  ],
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  noticia.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(noticia.date,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey)),
                          const Text("Por Radio Seibo",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey))
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Share.share(
                                'Hola, podría interesarte este artículo:\n${noticia.title} - ${noticia.url}');
                          },
                          child: const Text("Compartir",
                              style: TextStyle(fontSize: 14)))
                    ],
                  )),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Divider(),
              ),
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(children: _interpretHtml(noticia.content))),
              const Padding(padding: EdgeInsets.all(15.0), child: Divider()),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => _launchUrl(noticia.url),
                      child: const Text("Ver en el sitio web",
                          style: TextStyle(fontSize: 14))),
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ));
  }

  List<Widget> _interpretHtml(String html) {

    final List<Widget> widgets = [];
    final List<String> lines = html.split('\n');
    for (final line in lines) {

    if (line.contains('<img') && line.contains('<p>')) {
      // Cuando las imagenes vienen dentro de un P
          List<String> listOfImageInP = html.split('<img');

          for (var imageLink in listOfImageInP) {
            List<String> imageInP = imageLink.split('src="');
            if (imageInP.length > 1) {
              String ulrImage = imageInP[1].split('"')[0];

              widgets.add(CachedNetworkImage(
                imageUrl: ulrImage,
              ));
            }
          } 

        } else if (line.contains('<p>')){

        widgets.add(Text(
          line
              .replaceAll("<p>", "")
              .replaceAll("</p>", "\n")
              .replaceAll("<strong>", "")
              .replaceAll("</strong>", "")
              .replaceAll("<em>", "")
              .replaceAll("</em>", "")
              .replaceAll("<br>", "")
              .replaceAll("&nbsp;", "")
              .replaceAll("<br />", ""),
          style: const TextStyle(fontSize: 16),
        ));
        } else if (line.contains('<img')) {
        final src = line.split('src="')[1].split('"')[0];
        widgets.add(CachedNetworkImage(
          imageUrl: src,
        ));
      } else if (line.contains("<a")) {
        final href = line.split('href="')[1].split('"')[0];
        final text = line.split('">')[1].split('</a>')[0];
        widgets.add(GestureDetector(
            onTap: () => _launchUrl(href),
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Text(text, style: const TextStyle(color: Colors.blue)),
            )));
      } 
    }
    return widgets;
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
