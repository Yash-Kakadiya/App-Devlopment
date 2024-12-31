// Write a flutter code to display an Image into the Image asset widget from the asset folder.
// Write a flutter code to display an Image from a WEB URL using a cached network Image.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Images extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: AssetImage("assets/imgs/img.png"),
                    fit: BoxFit.fill)),
          ),
          Container(
            height: 30,
            width: 100,
            // color: Colors.black,
            child: Image.network(
              "https://png.pngtree.com/thumb_back/fh260/background/20211031/pngtree-abstract-bg-image_914283.png",
            ),
          ),
          Positioned(
            bottom: 0,
            child: Text(
              "¥@\$#",
              style: TextStyle(color: Colors.blue, fontSize: 100),
            ),
          )
        ],
      ),
    );
  }
}
