// import 'package:flutter/material.dart';
// import 'package:story_view/story_view.dart';
//
// class HikingScreen extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return Status();
//   }
// }
//
// class Status extends StatelessWidget {
//   final StoryController controller = StoryController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Delicious Ghanaian Meals"),
//       ),
//       body: Container(
//         margin: EdgeInsets.all(
//           8,
//         ),
//         child: ListView(
//           children: <Widget>[
//             Container(
//               height: 300,
//               child: StoryView(
//                 controller: controller,
//                 storyItems: [
//                   StoryItem.text(
//                     title:
//                     "Hello world!\nHave a look at some great hike listings. \n\nTap!",
//                     backgroundColor: Colors.orange,
//                     roundedTop: true,
//                   ),
//                   // StoryItem.inlineImage(
//                   //   NetworkImage(
//                   //       "https://image.ibb.co/gCZFbx/Banku-and-tilapia.jpg"),
//                   //   caption: Text(
//                   //     "Banku & Tilapia. The food to keep you charged whole day.\n#1 Local food.",
//                   //     style: TextStyle(
//                   //       color: Colors.white,
//                   //       backgroundColor: Colors.black54,
//                   //       fontSize: 17,
//                   //     ),
//                   //   ),
//                   // ),
//                   StoryItem.inlineImage(
//                     url:
//                     "https://hikemaniak.co.ke/wp-content/uploads/2024/01/53F63597-24C7-4453-819D-C9E892D317F7_1_105_c-1024x761.jpeg",
//                     controller: controller,
//                     caption: Text(
//                       "Mount Kenya Chogoria Sirimon Route",
//                       style: TextStyle(
//                         color: Colors.white,
//                         backgroundColor: Colors.black54,
//                         fontSize: 17,
//                       ),
//                     ),
//                   ),
//                   StoryItem.inlineImage(
//                     url:
//                     "https://hikemaniak.co.ke/wp-content/uploads/2023/04/B3E557C4-EAF5-47A4-85F7-2D7247F06C27-1024x768.jpeg",
//                     controller: controller,
//                     caption: Text(
//                       "Gura Forest Trek and Waterfall Chase",
//                       style: TextStyle(
//                         color: Colors.white,
//                         backgroundColor: Colors.black54,
//                         fontSize: 17,
//                       ),
//                     ),
//                   )
//                 ],
//                 onStoryShow: (storyItem, index) {
//                   print("Showing a story");
//                 },
//                 onComplete: () {
//                   print("Completed a cycle");
//                 },
//                 progressPosition: ProgressPosition.bottom,
//                 repeat: false,
//                 inline: true,
//               ),
//             ),
//             Material(
//               child: InkWell(
//                 onTap: () {
//                   Navigator.of(context).push(
//                       MaterialPageRoute(builder: (context) => MoreStories()));
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: Colors.black54,
//                       borderRadius:
//                       BorderRadius.vertical(bottom: Radius.circular(8))),
//                   padding: EdgeInsets.symmetric(vertical: 8),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Icon(
//                         Icons.arrow_forward,
//                         color: Colors.white,
//                       ),
//                       SizedBox(
//                         width: 16,
//                       ),
//                       Text(
//                         "View more stories",
//                         style: TextStyle(fontSize: 16, color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class MoreStories extends StatefulWidget {
//   @override
//   _MoreStoriesState createState() => _MoreStoriesState();
// }
//
// class _MoreStoriesState extends State<MoreStories> {
//   final storyController = StoryController();
//
//   @override
//   void dispose() {
//     storyController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("More"),
//       ),
//       body: StoryView(
//         storyItems: [
//           StoryItem.text(
//             title: "I guess you'd love to see more of our Hikes. That's great.",
//             backgroundColor: Colors.blue,
//           ),
//           StoryItem.text(
//             title: "Nice!\n\nTap to continue.",
//             backgroundColor: Colors.red,
//             textStyle: TextStyle(
//               fontFamily: 'Dancing',
//               fontSize: 40,
//             ),
//           ),
//           StoryItem.pageImage(
//             url:
//             "https://hikemaniak.co.ke/wp-content/uploads/2023/05/4997C446-02D3-4131-A3A3-7F52DF0BC818_1_102_o-1024x1019.jpeg",
//             caption: Text(
//               "Lukenya Rock Climbing",
//               style: TextStyle(
//                 fontSize: 15,
//                 color: Colors.white,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             controller: storyController,
//           ),
//           StoryItem.pageImage(
//               url: "https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif",
//               caption: Text(
//                 "Working with gifs",
//                 style: TextStyle(
//                   fontSize: 15,
//                   color: Colors.white,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               controller: storyController),
//           StoryItem.pageImage(
//             url: "https://hikemaniak.co.ke/wp-content/uploads/2023/04/9018C913-51BB-4D0A-8D35-1B696E53E947-scaled-1-1024x717.jpeg",
//             caption: Text(
//               "4 Days Loita Hills Hike ‘N Camp",
//               style: TextStyle(
//                 fontSize: 15,
//                 color: Colors.white,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             controller: storyController,
//           ),
//           StoryItem.pageImage(
//             url: "https://hikemaniak.co.ke/wp-content/uploads/2023/04/L1330401e-1024x684.jpg",
//             caption: Text(
//               "Sleeping Warrior and Ugali Hills Excursion",
//               style: TextStyle(
//                 fontSize: 15,
//                 color: Colors.white,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             controller: storyController,
//           ),
//         ],
//         onStoryShow: (storyItem, index) {
//           print("Showing a story");
//         },
//         onComplete: () {
//           print("Completed a cycle");
//         },
//         progressPosition: ProgressPosition.top,
//         repeat: false,
//         controller: storyController,
//       ),
//     );
//   }
// }