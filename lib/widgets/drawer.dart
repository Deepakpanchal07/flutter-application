import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    const imageUrl =
        "https://imgs.search.brave.com/pN0PNsdS_iyhnl_53iumGssWdlp12DVM0zmhkBjOtak/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93YWxs/cGFwZXJjYXQuY29t/L3cvZnVsbC8yLzcv/Yy81NTY5NC0xMjIw/eDIxNjAtc2Ftc3Vu/Zy1oZC1yb25hbGRv/LXdhbGxwYXBlci1p/bWFnZS5qcGc";

    return Drawer(
      child: Container(
        color: Colors.deepPurple,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(color: Colors.deepPurple),
              accountName: Text("Deep", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              accountEmail: Text("dp@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
            ListTile(
              leading: Icon(CupertinoIcons.home, color: Colors.white),
              title: Text(
                "Home",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {
                Navigator.pop(context); // Drawer close karega
                Navigator.pushNamed(context, "/"); // Home page pe le jayega
              },
            ),
            ListTile(
              leading: Icon(CupertinoIcons.profile_circled, color: Colors.white),
              title: Text(
                "Profile",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/profile");
              },
            ),
            ListTile(
              leading: Icon(CupertinoIcons.mail, color: Colors.white),
              title: Text(
                "Email Me",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
