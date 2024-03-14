import 'package:flutter/material.dart';

import '../theme.dart';

class BookHike extends StatefulWidget {
  const BookHike({super.key});

  @override
  State<BookHike> createState() => _BookHikeState();
}

class _BookHikeState extends State<BookHike> {
  bool _isLoading = false;

  void _bookNow() {
    setState(() {
      _isLoading = true;
    });
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Booked successfully'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Hike"),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Container(
        padding: const EdgeInsets.all(20),
        height: 500,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter your name',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Email',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter your email',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Phone Number',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter your phone number',
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Additional Information',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              maxLines: null, // Allows multiple lines for additional information
              decoration: InputDecoration(
                hintText: 'Enter additional information',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _bookNow,
              style: ElevatedButton.styleFrom(
                backgroundColor: lightColorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "BOOK NOW",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
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
