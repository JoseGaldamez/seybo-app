import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:radioseiboapp/models/news.model.dart';
import 'package:radioseiboapp/styles/colors.dart';

class NewCard extends StatelessWidget {
  final NewsFirebase noticia;
  const NewCard({super.key, required this.noticia});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
              
          children: [
            Container(
              alignment: Alignment.topRight,
              child: Stack(
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
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryBlue),
                    child: Text(
                      noticia.date,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      noticia.title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${noticia.description.substring(3, 150)}...",
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w100),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
