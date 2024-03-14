import 'package:flutter/material.dart';
import 'package:hikemaniak_app/screens/book_hike.dart';
import 'package:hikemaniak_app/theme.dart';

class HikeDetails extends StatefulWidget {
  const HikeDetails({super.key});

  @override
  State<HikeDetails> createState() => _HikeDetailsState();
}

class _HikeDetailsState extends State<HikeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hike Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/details.jpg",
                fit: BoxFit.cover,
                height: 300,
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 2,
                width: double.infinity,
                color: lightColorScheme.primary,
              ),
              SizedBox(height: 10,),
              Center(
                child: Text("Mt Kenya Day Dash – Sirimon",
                  style: TextStyle(
                    color: lightColorScheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        children: [
                          WidgetSpan(
                              child: Icon(Icons.calendar_month,
                                color: lightColorScheme.primary,
                                size: 26,
                              )
                          ),
                          const TextSpan(
                            text: "From: 15-Mar-2024 11:00",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          )
                        ]
                    ),
                  ),
                  SizedBox(width: 15,),
                  RichText(
                    text: TextSpan(
                        children: [
                          WidgetSpan(
                              child: Icon(Icons.group,
                                color: lightColorScheme.primary,
                                size: 26,
                              )
                          ),
                          const TextSpan(
                            text: "Group: 5",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          )
                        ]
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        children: [
                          WidgetSpan(
                              child: Icon(Icons.calendar_month,
                                color: lightColorScheme.primary,
                                size: 26,
                              )
                          ),
                          const TextSpan(
                            text: "From: 17-Mar-2024 19:00",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          )
                        ]
                    ),
                  ),
                  SizedBox(width: 15,),
                  RichText(
                    text: TextSpan(
                        children: [
                          WidgetSpan(
                              child: Icon(Icons.pin_drop,
                                color: lightColorScheme.primary,
                                size: 26,
                              )
                          ),
                          const TextSpan(
                            text: "Mt Kenya Lenana",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          )
                        ]
                    ),
                  ),
                ],
              ),
        
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        children: [
                          WidgetSpan(
                              child: Icon(Icons.run_circle_rounded,
                                color: lightColorScheme.primary,
                                size: 26,
                              )
                          ),
                          const TextSpan(
                            text: "Difficulty: 4",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          )
                        ]
                    ),
                  ),
                  SizedBox(width: 115,),
                  RichText(
                    text: TextSpan(
                        children: [
                          WidgetSpan(
                              child: Icon(Icons.group,
                                color: lightColorScheme.primary,
                                size: 26,
                              )
                          ),
                          const TextSpan(
                            text: "Group: 5",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          )
                        ]
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Text("Tour details",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold
              ),
              ),
              SizedBox(height: 10,),
              Text(
                "Are you ready to transcend ordinary mountain adventures? Join us for the Mt Kenya Dash, a journey beyond the ordinary, where reaching the summits is not just a goal; it’s a profound connection with self and nature. Our mission is to experience every moment, to savor the breathtaking views, and to revel in the beauty of this snow-capped East African giant, perfectly situated at the Equator."
              ),
              SizedBox(height: 10,),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Start Point:",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold
                      )
                    ),
                    TextSpan(
                      text: "Sirimon Gate (2950m ASL)",
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                      )
                    ),
                  ]
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder:
                    (context)=> const BookHike()
                    ));
                  },
                  child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: lightColorScheme.primary,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: Text("BOOK NOW",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                    ),
                    ),
                  ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
