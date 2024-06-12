import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hikemaniak_app/screens/account.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class PersonalInfo extends StatefulWidget {
  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Info'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: AccountForm(),
      ),
    );
  }
}

class AccountForm extends StatefulWidget {
  @override
  _AccountFormState createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  String? username = '';
  String email = 'example@example.com';
  String phone = '';

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    try {
      if (token!.isNotEmpty) {
        final url = Uri.parse('$BASE_URL/user');
        final response = await http.get(
          url,
          headers: {'Authorization': 'Bearer $token'},
        );

        if (response.statusCode == 200) {
          var userData = json.decode(response.body);
          setState(() {
            _nameController.text = userData['name'];
            email = userData['email'];
            phone = userData['phone'];
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("User data fetched successfully")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.body.toString())),
          );
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller:_nameController,
          // initialValue: _nameController,
          decoration: InputDecoration(
              labelText: 'Name',
            hintText: username
          ),
        ),
        SizedBox(height: 20.0),
        TextFormField(
          enabled: false,
          controller: TextEditingController(text: email),
          decoration: InputDecoration(
            labelText: 'Email',
          ),
        ),
        SizedBox(height: 20.0),
        TextFormField(
          controller: _phoneController,
          decoration: InputDecoration(
              labelText: 'Phone',
            hintText: phone
          ),
        ),
        Spacer(),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Save or update account information
                  String name = _nameController.text;
                  String phone = _phoneController.text;
                  String uemail = email;
                  updateUser(name, phone,uemail);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context)=>const Account())
                  );
                },
                child: Text('Save'),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate back
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context)=>const Account())
                  );
                },
                child: Text('Back'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }


  Future<void> updateUser(String name, String phone,String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    try {
      if (token != null && token.isNotEmpty) {
        final url = Uri.parse('$BASE_URL/update/user');
        final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'name': name,
            'phone': phone,
            'email': email,
          }),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("User data updated successfully")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("User details not updated")),
          );
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

}
