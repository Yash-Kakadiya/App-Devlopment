import 'package:flutter/material.dart';

import 'Page1.dart';

class Home extends StatelessWidget {
  const Home ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home page', style: TextStyle(fontSize: 100),),
            ElevatedButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Page1(),));
            }, child: Text('Next page'))
          ],
        ),
      ),
    );
  }
}
