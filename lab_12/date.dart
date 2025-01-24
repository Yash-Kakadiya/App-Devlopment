import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormatDate extends StatefulWidget {
  const FormatDate({super.key});

  @override
  State<FormatDate> createState() => _FormatDateState();
}

class _FormatDateState extends State<FormatDate> {
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    String f1 = DateFormat("dd/MM/yyyy").format(date);
    String f2 = DateFormat("dd-MM-yyyy").format(date);
    String f3 = DateFormat("dd-MMM-yyyy").format(date);
    String f4 = DateFormat("dd-MM-yy").format(date);
    String f5 = DateFormat("dd MMM, yyyy").format(date);

    return Scaffold(
      body: Container(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DateText(f1, Colors.red),
            DateText(f2, Colors.black),
            DateText(f3, Colors.blue),
            DateText(f4, Colors.grey),
            DateText(f5, Colors.green),
            ElevatedButton(
                onPressed: () async {
                  DateTime? d = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2026));

                  if (d != null && d != date) {
                    setState(() {
                      date = d;
                    });
                  }
                },
                child: Text("show"))
          ],
        ),
      )
    );
  }

  Widget DateText(String d, Color color) {
    return Text(
      d,
      style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 50),
    );
  }
}
