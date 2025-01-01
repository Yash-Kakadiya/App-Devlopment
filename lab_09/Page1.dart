import 'package:flutter/material.dart';
import 'package:lab_06/lab_09/Page2.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Page1',
              style: TextStyle(fontSize: 100),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Page2(),
                  ));
                },
                child: Text('Next page')),
            SizedBox(height: 10,),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Back')),
          ],
        ),
      ),
    );
  }
}
