import 'package:flutter/material.dart';
import 'package:responsiveness/util.dart';

void main() {
  runApp(const Responsiveness());
}

class Responsiveness extends StatelessWidget {
  const Responsiveness({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Responsiveness",
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final height = 50.sH(context);
    print("Height:$height");
    final width = 50.sW(context);
    print("Width:$width");
    final font = 10.sF(context);
    print("Font: $font");
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            // Responsive
            Container(
              color: Colors.yellow,
              height: height,
              width: width,
              child: Center(
                child: Text(
                  "R",
                  style: TextStyle(fontSize: font),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // Normal
            Container(
              color: Colors.blue,
              height: 50,
              width: 50,
              child: const Center(
                child: Text(
                  "N",
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
