import 'package:flutter/material.dart';

class ImageGrid extends StatelessWidget {
  ImageGrid({super.key});
  final List<Map<String, String>> list = [
    {
      "img":
          "https://images.pexels.com/photos/235986/pexels-photo-235986.jpeg?auto=compress&cs=tinysrgb",
      "text": "Nature - Mountains"
    },
    {
      "img": "https://images.unsplash.com/photo-1540206395-68808572332f",
      "text": "Abstract Gradient"
    },
    {
      "img": "https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0",
      "text": "Cityscape - Skyline at night"
    },
    {
      "img":
          "https://images.pexels.com/photos/276092/pexels-photo-276092.jpeg?auto=compress&cs=tinysrgb&w=600",
      "text": "Minimalist - Clean gradient"
    },
    {
      "img": "https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3",
      "text": "Space - Galaxy"
    },
    {
      "img":
          "https://images.pexels.com/photos/289586/pexels-photo-289586.jpeg?auto=compress&cs=tinysrgb&w=600",
      "text": "Ocean - Waves"
    },
    {
      "img":
          "https://images.pexels.com/photos/1323550/pexels-photo-1323550.jpeg?auto=compress&cs=tinysrgb&w=600",
      "text": "Forest - Nature"
    },
    {
      "img":
          "https://images.pexels.com/photos/268533/pexels-photo-268533.jpeg?auto=compress&cs=tinysrgb&w=600",
      "text": "Urban - Street"
    },
    {
      "img":
          "https://images.pexels.com/photos/289586/pexels-photo-289586.jpeg?auto=compress&cs=tinysrgb&w=600",
      "text": "Texture - Wooden"
    },
    {
      "img": "https://images.unsplash.com/photo-1446776811953-b23d57bd21aa",
      "text": "Sunset - Serene beach"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Image grid',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemCount: list.length,
        itemBuilder: (_, index) => card(index),
      ),
    );
  }

  Widget card(int i) {
    return Column(
      children: [
        Expanded(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(list[i]['img']!,),fit: BoxFit.fill)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Text(
          list[i]['text']!,
          style: TextStyle(fontSize: 30, color: Colors.orange),
        )
      ],
    );
  }
}
