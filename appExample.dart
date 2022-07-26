// for Responsive App
import 'package:.../constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(
      context: context,
      deviceHeight: 875.428,
      deviceWidth: 411.428,
    );
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 300,
              // height: 200,
              height: responsive.getHeight(height: 200),
              color: Colors.red[500]!,
            ),
          ),
          SizedBox(
            height: responsive.getHeight(height: 50),
          ),
          Container(
            // width: responsive.getWidth(width: 80),
            // height: responsive.getHeight(height: 80),
            padding: EdgeInsets.only(
              left: responsive.getLeftPadding(padding: 20),
              right: responsive.getRightPadding(padding: 20),
              top: responsive.getTopPadding(padding: 20),
              bottom: responsive.getBottomPadding(padding: 20),
            ),
            // margin: EdgeInsets.only(
            //   left: responsive.getLeftPadding(padding: 20),
            //   right: responsive.getRightPadding(padding: 20),
            //   top: responsive.getTopPadding(padding: 20),
            //   bottom: responsive.getBottomPadding(padding: 20),
            // ),
            // margin: const EdgeInsets.all(20),

            color: Colors.deepOrange,
            child: const Text(
              "Purple",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: responsive.getHeight(height: 20),
          ),
          Center(
            child: Text(
              "TEXT",
              textScaleFactor:
                  responsive.getTextScaleFactor(textScaleFactor: 1),
              style: TextStyle(
                fontSize: responsive.getFontSize(fontSize: 30),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: responsive.getHeight(height: 20),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: 20,
            ),
            color: Colors.deepOrange,
            child: const Text(
              "Purple",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
