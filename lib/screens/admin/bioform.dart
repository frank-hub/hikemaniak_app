import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hikemaniak_app/constants.dart';
import 'package:hikemaniak_app/screens/account.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BioForm extends StatefulWidget {
  @override
  State<BioForm> createState() => _BioFormState();
}

class _BioFormState extends State<BioForm> {
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
  TextEditingController _bioController = TextEditingController();
  String? bio = '';
  String user_id = '';
  String email = '';

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
            user_id = userData['id'].toString();
            email = userData['email'];
          });

          // final url2  = await http.get(Uri.parse('$BASE_URL/bio/$user_id'));
          final url2 = Uri.parse('$BASE_URL/bio/$user_id');
          final res2 = await http.get(
            url2,
            headers: {'Authorization': 'Bearer $token'},
          );

          if(res2.statusCode == 200){
            var bioData = json.decode(res2.body);

            setState(() {
              bio = bioData['body']['bio'].toString();
            });
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('No Bio'))
            );
          }

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
          controller:_bioController,
          // initialValue: _nameController,
          decoration: InputDecoration(
              labelText: 'Bio',
              hintText: bio
          ),
        ),
        Spacer(),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Save or update account information
                  String bio = _bioController.text;
                  String id = user_id;
                  updateBio(id,bio);
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
    _bioController.dispose();
    super.dispose();
  }


  Future<void> updateBio(String id, String bio) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');

    try {
      if (token != null && token.isNotEmpty) {
        final url = Uri.parse('$BASE_URL/update/bio/$id');

        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'user_id': id,
            'bio': bio,
          }),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("User Bio updated successfully")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              // "User bio not updated"
            SnackBar(content: Text(response.statusCode.toString())),
          );
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

}
