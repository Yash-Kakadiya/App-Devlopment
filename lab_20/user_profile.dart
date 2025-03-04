import 'package:flutter/material.dart';

import '../lab_19/user.dart';
import 'api_service.dart';

class UserProfile extends StatelessWidget {
  final String id;
  const UserProfile({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    Apiservice apiservice = Apiservice();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: apiservice.getUserById(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            User user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name: ${user.name}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            // Text(
                            //   'Email: ${user.email}',
                            //   style: TextStyle(
                            //     fontSize: 16,
                            //     color: Colors.grey[600],
                            //   ),
                            // ),
                            // SizedBox(height: 8),
                            // Text(
                            //   'Phone: ${user.phone}',
                            //   style: TextStyle(
                            //     fontSize: 16,
                            //     color: Colors.grey[600],
                            //   ),
                            // ),
                            // Add more fields as required
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Text(
                "Error loading user data",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
