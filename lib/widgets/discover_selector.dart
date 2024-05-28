import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hikemaniak_app/screens/auth/auth_service.dart';
import 'package:hikemaniak_app/theme.dart';

class DiscoverSelector extends StatefulWidget {
  String userName;

  DiscoverSelector({super.key,required  this.userName });


  @override
  _DiscoverSelectorState createState() => _DiscoverSelectorState();
}

class _DiscoverSelectorState extends State<DiscoverSelector> {
  final userDetails = AuthService();
  String? currentUserEmail;

  String getEffectiveUsername() {
    return currentUserEmail?.isNotEmpty ?? false ? currentUserEmail! : widget.userName.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentUserEmail = user.email;
    } else {
      // Handle the case where the user is not signed with gmail
      currentUserEmail = widget.userName.toUpperCase();
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        width: double.infinity,
        //color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Discover',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                    color: lightColorScheme.primary,
                    fontFamily: 'Montserrat',
                  ),
                ),
                Text(
                    // widget.userName.toUpperCase(),
                    getEffectiveUsername(),
                    style: TextStyle(
                        fontSize: 14, color: Colors.black.withOpacity(0.35))),
                Text('Trending Activities everywhere',
                    style: TextStyle(
                        fontSize: 14, color: Colors.black.withOpacity(0.35))),
              ],
            ),
            Stack(
              children: <Widget>[
                Container(
                  height: 41,
                  width: 41,
                  child: CircleAvatar(
                    child: ClipOval(
                      child: Image(
                        image: AssetImage('assets/images/profile.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color.fromRGBO(92, 214, 115, 1)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}