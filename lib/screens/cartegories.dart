import 'package:flutter/material.dart';
import 'package:hikemaniak_app/screens/cartegory_list.dart';
import 'package:hikemaniak_app/screens/list_screen.dart';
import 'package:hikemaniak_app/theme.dart';
import 'package:hikemaniak_app/widgets/bottom_nav_selector.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNav(),
      body: SafeArea(
        child: Column(
          children:<Widget> [
            Container(
              width: double.infinity,
              //color: Colors.green,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
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
                        Text(
                          'Hike Categories',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 31,
                            color: Colors.black,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 36,
                          width: 36,
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
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 1, horizontal: 30),
                // width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:
                          (context)=> CategoryLists(category: 'Forest')
                          ));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Stack(
                            children: [
                              Container(
                                width: 350,
                                height: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/test3.jpeg'), // Replace 'image.jpg' with your image path
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                width: 350,
                                height: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.black.withOpacity(0.4), // Semi-transparent grey color
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Forest',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    Text(
                                      'Embrace nature and disconnect from technology by spending time outdoors in a camping or glamping setting.',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 15,),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder:
                                            (context)=> CategoryLists(category: 'forest')
                                        ));
                                        },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: lightColorScheme.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      child: Text(
                                        'Book',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context)=> CategoryLists(category: 'Water')
                          ));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Stack(
                            children: [
                              Container(
                                width: 350,
                                height: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/test3.jpeg'), // Replace 'image.jpg' with your image path
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                width: 350,
                                height: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.black.withOpacity(0.4), // Semi-transparent grey color
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Water',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    Text(
                                      'Embrace nature and disconnect from technology by spending time outdoors in a camping or glamping setting.',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 15,),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder:
                                            (context)=> CategoryLists(category: 'Water')
                                        ));
                                        },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: lightColorScheme.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      child: Text(
                                        'Book',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context)=> CategoryLists(category: 'Rock')
                          ));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Stack(
                            children: [
                              Container(
                                width: 350,
                                height: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/test3.jpeg'), // Replace 'image.jpg' with your image path
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                width: 350,
                                height: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.black.withOpacity(0.4), // Semi-transparent grey color
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Rock',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    Text(
                                      'Embrace nature and disconnect from technology by spending time outdoors in a camping or glamping setting.',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 15,),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder:
                                            (context)=> CategoryLists(category: 'Rock')
                                        ));                                  
                                        },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: lightColorScheme.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      child: Text(
                                        'Book',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:
                          (context)=> CategoryLists(category: 'Alpine')
                          ));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Stack(
                            children: [
                              Container(
                                width: 350,
                                height: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/test3.jpeg'), // Replace 'image.jpg' with your image path
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                width: 350,
                                height: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.black.withOpacity(0.4), // Semi-transparent grey color
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Alpine',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    Text(
                                      'Embrace nature and disconnect from technology by spending time outdoors in a camping or glamping setting.',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 15,),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder:
                                            (context)=> CategoryLists(category: 'Alpine')
                                        ));
                                        },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: lightColorScheme.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      child: Text(
                                        'Book',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                  ],
                                ),
                              ),
                                          
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context)=> CategoryLists(category: 'Moorland')
                          ));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Stack(
                            children: [
                              Container(
                                width: 350,
                                height: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/test3.jpeg'), // Replace 'image.jpg' with your image path
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                width: 350,
                                height: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.black.withOpacity(0.4), // Semi-transparent grey color
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Moorland',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    Text(
                                      'Embrace nature and disconnect from technology by spending time outdoors in a camping or glamping setting.',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 15,),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder:
                                            (context)=> CategoryLists(category: 'Moorland')
                                        ));
                                        },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: lightColorScheme.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      child: Text(
                                        'Book',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder:
                          (context)=> CategoryLists(category: 'Camping')
                          ));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Stack(
                            children: [
                              Container(
                                width: 350,
                                height: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/test3.jpeg'), // Replace 'image.jpg' with your image path
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                width: 350,
                                height: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.black.withOpacity(0.4), // Semi-transparent grey color
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Camping',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                    Text(
                                      'Embrace nature and disconnect from technology by spending time outdoors in a camping or glamping setting.',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 15,),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder:
                                            (context)=> CategoryLists(category: 'Camping')
                                        ));                                  
                                        },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: lightColorScheme.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      child: Text(
                                        'Book',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
