import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Customdrawer extends StatefulWidget {
  const Customdrawer({super.key});

  @override
  State<Customdrawer> createState() => _CustomdrawerState();
}

class _CustomdrawerState extends State<Customdrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
          child :Lottie.network('https://lottie.host/8a861e86-28a4-4e94-85dd-e4f6b0a9c048/UHbbIynRzu.json')
          ),
          Padding(padding: EdgeInsets.all(10),
          child: ListTile(
            leading: IconButton(onPressed: (){}, icon: Icon(Icons.home)),
            title: Text("H O M E"),
          ),
          
          ),
          Padding(padding: EdgeInsets.all(10),
          child: ListTile(
            leading: IconButton(onPressed: (){}, icon: Icon(Icons.settings)),
            title: Text("S E T T I N G S"),
          ),
          
          ),
          Spacer(),
          Divider(
            thickness: 2,
          ),


          Padding(padding: EdgeInsets.all(10),
          child: ListTile(
            leading: IconButton(onPressed: (){}, icon: Icon(Icons.email)),
            title: Text("J O I N  U S"),
          ),
          
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}