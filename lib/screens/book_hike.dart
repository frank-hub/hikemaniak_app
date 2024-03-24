import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme.dart';

class BookHike extends StatefulWidget {
  const BookHike({super.key});

  @override
  State<BookHike> createState() => _BookHikeState();
}

class _BookHikeState extends State<BookHike> {
  bool _isLoading = false;
  final _dateFormat = DateFormat('yyyy-MM-dd');
  DateTime? _selectedDate;

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
          : SingleChildScrollView(
            child: Container(
                    padding: const EdgeInsets.all(20),
                    height: 740,
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
                'Number Of Adults',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Select number of adults'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              Text(
                'Number of Kids',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Number of kids'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              Text(
                'Payment Date',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Date'),
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                },
                controller: TextEditingController(
                  text: _selectedDate != null ? _dateFormat.format(_selectedDate!) : '',
                ),
              ),
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
          ),
    );
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}


