import 'package:flutter/material.dart';

import '../theme.dart';
class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return Container(
              height: 75,
              width: double.infinity,
              child: Card(
                child: Container(
                  height: 75,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.sos_outlined,
                        size: 35,
                        color: Colors.red,
                      ),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text("SOS alert on a trail near you.Respond?",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){

                        },
                        child: Icon(Icons.remove_red_eye_outlined,
                          color: lightColorScheme.primary,
                          size: 35,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
