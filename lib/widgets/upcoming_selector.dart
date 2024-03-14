import 'package:flutter/material.dart';

import '../theme.dart';
class UpcomingSelector extends StatefulWidget {
  const UpcomingSelector({super.key});

  @override
  State<UpcomingSelector> createState() => _UpcomingSelectorState();
}

class _UpcomingSelectorState extends State<UpcomingSelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 10),
          width: double.infinity,
          //color: Colors.green,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Our Upcoming Adventures',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: lightColorScheme.primary,
                  fontFamily: 'Montserrat',
                ),
              ),
              Text('Amazing Experiences',
                  style: TextStyle(
                      fontSize: 14, color: Colors.black.withOpacity(0.35))),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {

                },
                child: Card(
                  child: Container(
                    height: 335,
                    width: 250,
                    padding: const EdgeInsets.all(10),
                    child:Column(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(
                                    'assets/images/test.jpg'),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10,),
                              Text('4 Days Mt Kenya Naromoru -Sirimon',
                                style: TextStyle(
                                    color: lightColorScheme.primary,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const Text('August 15, 2024',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                              Stack(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.pin_drop,
                                        color: lightColorScheme.primary,),
                                      Expanded(
                                        child: Text('Naromoru',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("From"),
                                      SizedBox(width: 5,),
                                      Text(
                                        '44500',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: lightColorScheme.primary
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {

                },
                child: Card(
                  child: Container(
                    height: 335,
                    width: 250,
                    padding: const EdgeInsets.all(10),
                    child:Column(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(
                                    'assets/images/test2.jpg'),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10,),
                              Text('Mount Kilimanjaro Marangu Climb',
                                style: TextStyle(
                                    color: lightColorScheme.primary,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const Text('March 28, 2024',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                              Stack(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.pin_drop,
                                        color: lightColorScheme.primary,),
                                      Expanded(
                                        child: Text('Moshi, Tanzania',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("From"),
                                      SizedBox(width: 5,),
                                      Text(
                                        '94500',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: lightColorScheme.primary
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {

                },
                child: Card(
                  child: Container(
                    height: 335,
                    width: 250,
                    padding: const EdgeInsets.all(10),
                    child:Column(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(
                                    'assets/images/test.jpg'),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10,),
                              Text('4 Days Mt Kenya Naromoru -Sirimon',
                                style: TextStyle(
                                    color: lightColorScheme.primary,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const Text('August 15, 2024',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                              Stack(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.pin_drop,
                                        color: lightColorScheme.primary,),
                                      Expanded(
                                        child: Text('Naromoru',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("From"),
                                      SizedBox(width: 5,),
                                      Text(
                                        '44500',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: lightColorScheme.primary
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {

                },
                child: Card(
                  child: Container(
                    height: 335,
                    width: 250,
                    padding: const EdgeInsets.all(10),
                    child:Column(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(
                                    'assets/images/test.jpg'),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10,),
                              Text('4 Days Mt Kenya Naromoru -Sirimon',
                                style: TextStyle(
                                    color: lightColorScheme.primary,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              const Text('August 15, 2024',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                              Stack(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.pin_drop,
                                        color: lightColorScheme.primary,),
                                      Expanded(
                                        child: Text('Naromoru',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("From"),
                                      SizedBox(width: 5,),
                                      Text(
                                        '44500',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: lightColorScheme.primary
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        )
      ],
    );
  }
}
