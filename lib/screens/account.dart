import 'package:flutter/material.dart';
import 'package:hikemaniak_app/screens/test.dart';
import 'package:hikemaniak_app/widgets/bottom_nav_selector.dart';

import '../theme.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNav(),

      body: SafeArea(
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
                      TextButton(
                          onPressed:(){
                            Navigator.push(context, MaterialPageRoute(builder:
                            (context)=> Test()
                            ));
                          },

                          child: Text("Hike Data")),
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
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Hike Maniak'),
                                    Text('hikemaniak@gmail.com',
                                    style: TextStyle(
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
                    const Row(
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
                    const SizedBox(height: 20,),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                    ////
                    const SizedBox(height: 20,),
                    Row(
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
                    const SizedBox(height: 20,),
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
                    const SizedBox(height: 20,),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                    ////
                    const SizedBox(height: 20,),
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
                    const SizedBox(height: 20,),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                    /////
                    const SizedBox(height: 20,),
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
                    const SizedBox(height: 20,),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                    TextButton(onPressed: (){}, child: Text(
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
    );
  }
}
