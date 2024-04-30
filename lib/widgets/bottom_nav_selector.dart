import 'package:flutter/material.dart';
import 'package:hikemaniak_app/screens/account.dart';
import 'package:hikemaniak_app/screens/cartegories.dart';
import 'package:hikemaniak_app/screens/home.dart';
import 'package:hikemaniak_app/screens/list_screen.dart';
import 'package:hikemaniak_app/theme.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60, // Increased height to accommodate icons and names
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.grey.withOpacity(0.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
            borderRadius: BorderRadius.circular(20.0),
            child: Column(
              children: [
                Icon(Icons.home, color: lightColorScheme.primary, size: 28),
                Text('Home'),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListScreen(),
                ),
              );
            },
            borderRadius: BorderRadius.circular(20.0),
            child: Column(
              children: [
                Icon(Icons.list_alt_outlined, color: lightColorScheme.primary, size: 28),
                Text('List'),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CategoryScreen(),
                ),
              );
            },
            borderRadius: BorderRadius.circular(20.0),
            child: Column(
              children: [
                Icon(Icons.category_outlined, color: lightColorScheme.primary, size: 28),
                Text('Categories'),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder:
              (context)=> Account()
              ));
            },
            borderRadius: BorderRadius.circular(20.0),
            child: Column(
              children: [
                Icon(Icons.account_circle, color: lightColorScheme.primary, size: 28),
                Text('Profile'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
