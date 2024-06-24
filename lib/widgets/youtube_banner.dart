import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class YoutubeBanner extends StatelessWidget {
  const YoutubeBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final urlYoutube = Uri.parse("https://www.youtube.com/@RadioSeibo025");
        if (await canLaunchUrl(urlYoutube)) {
          launchUrl(urlYoutube);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.all(color: Colors.red, width: 3)),
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: const Text(
                "Haz click y síguenos en: ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Image.asset("assets/images/youtube-banner.jpg")),
          ],
        ),
      ),
    );
  }
}
