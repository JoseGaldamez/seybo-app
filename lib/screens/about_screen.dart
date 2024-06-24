import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acerca de..."),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: 250,
                height: 250,
                child: Image.asset("assets/images/logoseybo.png")),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                "¿Quiénes somos?",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                "Somos una familia de comunicadores guiados por el carisma de Santo Domingo de Guzmán. Queremos ser fieles a la primera Comunidad Dominica en la isla en la lucha por la dignidad compartiendo con los preferidos de Jesús. Trabajamos en red con la Unión Dominicana de Emisoras Católicas (UDECA) y la Asociación Latinoamericana de Educación y Comunicación Popular (ALER).",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                "Contacto",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                "Si quiere comunicarse con nosotros existen varias maneras. Puede visitar nuestro sitio web, llamarnos por teléfono o enviarnos un correo electrónico. Estamos para servirle.",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              width: double.infinity,
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () {
                    _launchUrl("https://www.radioseibo.org/");
                  },
                  child: const Text('Visitar Sitio Web')),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              width: double.infinity,
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () {
                    _launchUrl("tel:+18095523274");
                  },
                  child: const Text('Llamar a la radio - Cabina')),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              width: double.infinity,
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () {
                    _launchUrl("tel:+18095523614");
                  },
                  child: const Text('Llamar a la radio - Oficina')),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              width: double.infinity,
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () {
                    _launchUrl("mailto:radioseybo@dominicos.org");
                  },
                  child: const Text('Enviar un correo electrónico')),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              width: double.infinity,
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Volver')),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(color: Colors.grey[100]),
              child: const Text("Made with ♥ by Jose Galdamez"),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
