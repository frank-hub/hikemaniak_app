import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hikemaniak_app/constants.dart';
import 'package:hikemaniak_app/screens/admin/home.dart';
import 'package:hikemaniak_app/screens/auth/auth_service.dart';
import 'package:hikemaniak_app/screens/auth/login.dart';
import 'package:hikemaniak_app/screens/guide/home.dart';
import 'package:hikemaniak_app/screens/past_hikes.dart';
import 'package:hikemaniak_app/screens/personalInfo.dart';
import 'package:hikemaniak_app/screens/shop/privacy.dart';
import 'package:hikemaniak_app/screens/shop/shop_web_view.dart';
import 'package:hikemaniak_app/screens/tests/map_test.dart';
import 'package:http/http.dart' as http;
import 'package:hikemaniak_app/widgets/bottom_nav_selector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String? username;
  String email = '';
  final user = FirebaseAuth.instance.currentUser;
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      Navigator.pushReplacementNamed(context, '/logout'); // Navigate to LoginScreen
      print('Successfully signed out!');
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  Future<void> fetchUser() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token  = preferences.getString('token');
    try{
      if(token!.isNotEmpty) {
        final url = Uri.parse('$BASE_URL/user');
        final response = await http.get(url,
            headers: {'Authorization': 'Bearer $token'}
        );

        if (response.statusCode == 200) {
          var userData = json.decode(response.body);
          setState(() {
            username = userData['name'];
            email = userData['email'];
          });
        }else{

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(response.body.toString()))
          );
        }
      }
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    username ??= user?.email;
    return Scaffold(
      bottomNavigationBar: const BottomNav(),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
          
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  //color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // TextButton(
                        //     onPressed:(){
                        //       Navigator.push(context, MaterialPageRoute(builder:
                        //       (context)=> Test()
                        //       ));
                        //     },
                        //
                        //     child: Text("Hike Data")),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                                icon: Image.asset(
                                  'assets/images/backicon.png',
                                  height: 20,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            const Text(
                              'Profile',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.black,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                            icon: const Icon(
                              Icons.notifications_active,
                              size: 26,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  child: ClipOval(
                                    child: Image(
                                      image: AssetImage('assets/images/profile.jpg'),
                                      fit: BoxFit.cover,
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(this.username ?? ''),
                                      Text(email ?? 'ops',
                                      style: const TextStyle(
                                        color: Colors.grey
                                      ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const Icon(Icons.keyboard_arrow_right,size: 25,)
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 25,),
                        height: 2,
                        width: double.infinity,
                        color: lightColorScheme.primary,
                      ),
          
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text('Settings',
          
                          style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.start,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:
                          (context)=>PersonalInfo()
                          ));
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.account_circle_outlined),
                                SizedBox(width: 10,),
                                Text('Personal information')
                              ],
                            ),
                            Icon(Icons.keyboard_arrow_right)
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                      ////
                      const SizedBox(height: 20,),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.notifications_active),
                              SizedBox(width: 10,),
                              Text('Notifications')
                            ],
                          ),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                      ////
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Privacy(),
                          ));
                        },
                        child: const Column(
                          children: [
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.cases_rounded),
                                    SizedBox(width: 10,),
                                    Text('Privacy and sharing')
                                  ],
                                ),
                                Icon(Icons.keyboard_arrow_right)
                              ],
                            ),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                      ////
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:
                          (context)=>PastHikes()
                          ));
                        },
                        child: const Column(
                          children: [
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.archive),
                                    SizedBox(width: 10,),
                                    Text('Past Hikes')
                                  ],
                                ),
                                Icon(Icons.keyboard_arrow_right)
                              ],
                            ),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                     InkWell(
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder:
                         (context)=> const ShopWebView()
                         ));
                       },
                       child: const Column(
                         children: [
                           SizedBox(height: 20,),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Row(
                                 children: [
                                   Icon(Icons.store),
                                   SizedBox(width: 10,),
                                   Text('Shop ')
                                 ],
                               ),
                               Icon(Icons.keyboard_arrow_right)
                             ],
                           ),
                           SizedBox(height: 20,),
                         ],
                       ),
                     ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context)=> const HomeAdmin()
                          ));
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.admin_panel_settings_outlined),
                                SizedBox(width: 10,),
                                Text('Admin Portal')
                              ],
                            ),
                            Icon(Icons.keyboard_arrow_right)
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 20,),
          
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:
                          (context)=> const HomeGuide()
                          ));
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.hiking),
                                SizedBox(width: 10,),
                                Text('Guide Portal')
                              ],
                            ),
                            Icon(Icons.keyboard_arrow_right)
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                      /////
                      InkWell(
                        onTap: (){
                          _makePhoneCall();
                        },
                        child: const Column(
                          children: [
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.headset_mic_outlined),
                                    SizedBox(width: 10,),
                                    Text('Call Us')
                                  ],
                                ),
                                Icon(Icons.keyboard_arrow_right)
                              ],
                            ),
                            SizedBox(height: 20,),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey,
                      ),
                      TextButton(
                          onPressed: () async {
                            // logout();
                            await authService.logout();
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context)=> SignInScreen()
                            ));
                          },
                          child: Text(
                        'Logout',
                        style: TextStyle(color: lightColorScheme.primary),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _makePhoneCall() async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: '+254717353774',
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      print('Could not launch $launchUri');
    }
  }

}
