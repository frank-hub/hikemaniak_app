import 'package:flutter/material.dart';
import 'package:hikemaniak_app/screens/list_screen.dart';

class GridSelector extends StatefulWidget {
  @override
  _GridSelectorState createState() => _GridSelectorState();
}

class _GridSelectorState extends State<GridSelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 69,
                    width: 148,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/cost.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Moorland',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 69,
                    width: 148,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/mountain.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Alpine',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListScreen(),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 69,
                    width: 148,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/river.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'River',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Container(
                    height: 69,
                    width: 148,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/forest.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Forest',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}